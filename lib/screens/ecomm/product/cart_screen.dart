import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/screens/ecomm/product/custom_quantity.dart';
import 'package:flu_go_jwt/services/ecomm/cart/bloc/cart_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Shopping Cart",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: AppColors.brandColor,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalMediumPadding,
          vertical: AppSizes.verticalP,
        ),
        child: Stack(
          children: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartStateProducts) {
                  if (state.products != null) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        // ! ver este vertical si hace efecto
                        // ! aun falta la parte de no este pegado al
                        // ! fondo para el botton de pagar y los enlaces en sign in y sign up
                        vertical: 10.0,
                      ),
                      itemCount: state.products!.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final product = state.products![index];
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5.0),
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(8.0),
                            ),
                            border: Border.all(
                              color: AppColors.brandColor,
                              width: 1.0,
                            ),
                          ),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 120.0,
                                height: 120.0,
                                child: FadeInImage(
                                  placeholder: const AssetImage(
                                    "assets/loading.gif",
                                  ),
                                  image: NetworkImage(product.imgUrl),
                                ),
                              ),
                              const SizedBox(width: 4.0),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      product.productGroupName!,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    const SizedBox(height: 3.0),
                                    Text(product.price.toString()),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        QuantitySelector(
                                          onChanged: (value) {
                                            //product.amount = value;
                                            context.read<CartBloc>().add(
                                                  CartEventChangeAmount(
                                                    product: product,
                                                    amount: value,
                                                  ),
                                                );
                                          },
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            // rpeguntar si desea eliminar del carrito
                                            context.read<CartBloc>().add(
                                                  CartEventRemoveFromCart(
                                                    product: product,
                                                  ),
                                                );
                                          },
                                          icon: const Icon(Icons.delete),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Text("Cart is empty"),
                  );
                }
                return const Center(
                  child: Text("cart is empty"),
                  //child: Text("an error ocurrer on cart state"),
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // ! color permite saber el tamaño del container
                // para ello cambiar sixedbox a container
                //color: Colors.amber[50],
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: AppColors.brandColor),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Subtotal:"),
                            (state is CartStateProducts)
                                ? Text(state.subTotal.toDouble().toString())
                                : Text("0.0"),
                          ],
                        );
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        /* final cartState = context.read<CartBloc>().state;
                        if (cartState is CartStateProducts) {
                          if (cartState.products == null) {
                            return;
                          }
                          context.read<OrderBloc>().add(
                                OrderEventSetProductItems(
                                  subtotal: cartState.subTotal,
                                  products: cartState.products!,
                                ),
                              );
                        } */
                        // * [] no usar esto por que debe hacer como mínimo un elemento
                        // 5-27
                        final cartState = context.read<CartBloc>().state;

                        if (cartState is! CartStateProducts ||
                            cartState.products == null) {
                          return;
                        }

                        context.read<OrderBloc>().add(
                              OrderEventSetProductItems(
                                subtotal: cartState.subTotal,
                                products: cartState.products!,
                              ),
                            );

                        GoRouter.of(context).push(AppRoutes.shippingRoute);
                      },
                      child: Container(
                        height: 55.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.brandColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            /* BlocBuilder<CartBloc, CartState>(
                              builder: (context, state) {
                                return Text(
                                  "\$/ ${state.total.toStringAsFixed(2)}",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ), */
                            Text(
                              "Buy Now",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      /* floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.brandColor,
        child: SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: 10.0),
              BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  return Text(state.amount.toString());
                },
              ),
              Spacer(),
              Text(
                "Buy Now",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(width: 10.0),
            ],
          ),
        ),
        onPressed: () {},
      ), */
      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
