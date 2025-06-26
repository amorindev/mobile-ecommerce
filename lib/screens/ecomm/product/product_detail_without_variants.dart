import 'package:flu_go_jwt/services/ecomm/product/model/product.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/services/ecomm/cart/bloc/cart_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailWithOutVariants extends StatefulWidget {
  final Product product;
  const ProductDetailWithOutVariants({super.key, required this.product});

  @override
  State<ProductDetailWithOutVariants> createState() =>
      _ProductDetailWithOutVariantsState();
}

class _ProductDetailWithOutVariantsState
    extends State<ProductDetailWithOutVariants> {
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) async{
        if (state is CartStateProducts) {
          if (state.exp != null) {
            // se podrái crear  un singleton
            // o verificar el tipo de error
            // por que de momento tenog este manejo de error para ambos
            // product con variantes y sin en estas screens
            await showErrorDialog(context, state.exp.toString());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            "Product",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          backgroundColor: AppColors.brandColor,
        ),
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: Hero(
                  tag: widget.product.id,
                  child: FadeInImage(
                    placeholder: const AssetImage("assets/loading.gif"),
                    image: NetworkImage(widget.product.imgUrl),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.name,
                      //textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20.0,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.product.sku,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyColor),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RatingBar.builder(
                          itemSize: 25.0,
                          minRating: 1,

                          /// o comentarlo
                          itemBuilder: (context, index) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          },
                          onRatingUpdate: (value) {
                            rating = value;
                          },
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.product.description,
                      style: const TextStyle(fontSize: 16.0),
                    ),
                    const SizedBox(height: 18.0),
                    // validacion [0] que venga por lo menos un elemento?
                    widget.product.products[0].stock == 0
                        ? const Text(
                            "No nos quedan productos",
                            style: TextStyle(color: Colors.red, fontSize: 16.0),
                          )
                        : Text(
                            "Cantidad:${widget.product.products[0].stock}",
                            style: const TextStyle(fontSize: 16.0),
                          ),
                    const SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Price:${widget.product.products[0].price.toString()}",
                          style: const TextStyle(fontSize: 17.0),
                        ),
                        // puede ser que ambos se expandan como son solo dos
                        GestureDetector(
                          onTap: () {
                            final prod = widget.product.products[0];
                            prod.productGroupName = widget.product.name;
                            prod.quantity = 1;
                            context.read<CartBloc>().add(
                                  CartEventAddToCart(
                                      product: widget.product.products[0]),
                                );
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 15.0),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5.0),
                            decoration: BoxDecoration(
                              color: AppColors.redColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 50,
                            width: 150,
                            child: const Center(
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17.0),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
