// * o solo detail pero tendríamos que jugar  con import names

import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/services/ecomm/cart/bloc/cart_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/product/domain/domain_product.dart';
import 'package:flu_go_jwt/services/ecomm/product/domain/domain_product_item.dart';
import 'package:flu_go_jwt/services/ecomm/product/domain/domain.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  double rating = 0;
  // que pasaría si tenemos mas variantes como material esto ya no funcionaría
  late String colorSelected;
  late String sizeSelected;
  late ProductItem productSelected; // * ver si es late

  @override
  void initState() {
    super.initState();

    // ! esto va depender si el producto es tiene variacion o no
    for (var v in widget.product.variations!) {
      if (v.name == "COLOR") {
        colorSelected = v.values[0];
      }
      if (v.name == "SIZE") {
        sizeSelected = v.values[0];
      }
    }
    /* print("Color selected $colorSelected");
    print("Size selected $sizeSelected"); */
    // * Buscar el color y asignarlo
    bool found = false;
    for (var p in widget.product.products) {
      // que pasa si no existe bueno debería estar
      // se que debe venir las opciones - ver hasta que punto es adecuaddo
      // mejor separar en dos pantalas
      bool isColorOk = false;
      bool isSizeOk = false;
      for (var varOp in p.options!) {
        /* print("Name ${varOp.name}");
        print("Size ${varOp.value}"); */
        if (varOp.name == "COLOR" && varOp.value == colorSelected) {
          isColorOk = true;
        }
        if (varOp.name == "SIZE" && varOp.value == sizeSelected) {
          isSizeOk = true;
        }
      }
      if (isColorOk && isSizeOk) {
        if (mounted) {
          productSelected = p;
          break;
        } else {
          /* print("not mounted"); */
        }
      }
    }
    if (!found) {
      /*  print("NO se encontro el producto"); */
    }
  }

  void _updateColorSelectedProduct(String value) {
    // Busca el producto que coincida con las variantes seleccionadas
    for (var p in widget.product.products) {
      bool matchesColor = true;
      bool matchesSize = true;

      for (var option in p.options!) {
        if (option.name == "COLOR" && option.value != value) {
          matchesColor = false;
        }
        if (option.name == "SIZE" && option.value != sizeSelected) {
          matchesSize = false;
        }
      }

      if (matchesColor && matchesSize) {
        setState(() {
          colorSelected = value;
          productSelected = p;
        });
        return;
      }
    }
    // Si no encuentra coincidencia, usa el primero como fallback
    /* setState(() {
    productSelected = widget.product.products.first;
  }); */
  }

  void _updateSizeSelectedProduct(String value) {
    // Busca el producto que coincida con las variantes seleccionadas
    for (var p in widget.product.products) {
      bool matchesColor = true;
      bool matchesSize = true;

      for (var option in p.options!) {
        if (option.name == "COLOR" && option.value != colorSelected) {
          matchesColor = false;
        }
        if (option.name == "SIZE" && option.value != value) {
          matchesSize = false;
        }
      }

      if (matchesColor && matchesSize) {
        setState(() {
          sizeSelected = value;
          productSelected = p;
        });
        return;
      }
    }
    // Si no encuentra coincidencia, usa el primero como fallback
    /* setState(() {
    productSelected = widget.product.products.first;
  }); */
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CartBloc, CartState>(
      listener: (context, state) async {
        if (state is CartStateProducts) {
          if (state.exp != null) {
            await showErrorDialog(context, state.exp.toString());
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.white,
          ),
          title: const Text(
            "Product",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          //actions: [IconButton(onPressed: () {}, icon: Icon(Icons.favorite))],

          backgroundColor: AppColors.redColor,
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
                      image: NetworkImage(productSelected.imgUrl),
                    ),
                    //child: Image.network(productSelected.imgUrl),
                    /* child: productSelected != null
                          ? Image.network(productSelected!.imgUrl)
                          : const SizedBox(), */
                    //child: Image.network(widget.product.imgUrl),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10.0,
                    right: 10.0,
                    left: 10.0,
                    bottom: 10.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.product.name,
                        //textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 20.0),
                      ),
                      /* Text(
                            '${(productSelected.price * productSelected.discount / 100).toStringAsFixed(2)}',), */
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.product.sku,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyColor),
                          ),
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
                      // ! no pasara por ShowProduct por que tendremos otra pagina para
                      // ! productos sin variaciones
                      widget.product.variations == null
                          // ? desde donde hhacer el pivote una página para cada uno
                          // ? o solamenete como estepero lo mas alto ver el primero parece mejor
                          ? ShowProduct(
                              product: widget.product,
                            )
                          : ShowProductWithvariations(
                              colorSelected: colorSelected,
                              sizeSelected: sizeSelected,
                              cSelected: (cSelected) {
                                colorSelected = cSelected;
                                _updateColorSelectedProduct(cSelected);
                              },
                              sSelected: (sSelected) {
                                sizeSelected = sSelected;
                                _updateSizeSelectedProduct(sSelected);
                              },
                              variations: widget.product.variations!,
                            ),
                      const SizedBox(height: 10.0),
                      productSelected.stock == 0
                          ? const Text(
                              "No nos quedan productos",
                              style:
                                  TextStyle(color: Colors.red, fontSize: 16.0),
                            )
                          : Text(
                              "Cantidad:${productSelected.stock}",
                              style: const TextStyle(fontSize: 16.0),
                            ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            "Price:${productSelected.price.toString()}",
                            style: const TextStyle(fontSize: 17.0),
                          ),
                          // puede ser que ambos se expandan como son solo dos
                          ElevatedButton(
                            onPressed: () {
                              final prod = productSelected;
                              prod.productGroupName = widget.product.name;
                              prod.quantity = 1;
                              context.read<CartBloc>().add(CartEventAddToCart(
                                    product: productSelected,
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.redColor,
                              minimumSize: const Size(150, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Add to cart",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      /* SizedBox(
                          height: 10.0,
                        ) */
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ! se va a separar en otro página productos sin variaciones
class ShowProduct extends StatelessWidget {
  final Product product;
  const ShowProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox();
    /* ListView.builder(
      itemCount: product.variations.length,
    ) */
  }
}

class ShowProductWithvariations extends StatelessWidget {
// me parece que es mejor todo el product y  ProductsResponseProduct
  final Function(String) cSelected; // color
  final Function(String) sSelected;

  final String colorSelected;
  final String sizeSelected;

  final List<Variation> variations;
  const ShowProductWithvariations({
    super.key,
    required this.variations,
    required this.cSelected,
    required this.sSelected,
    required this.colorSelected,
    required this.sizeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...variations.map(
          (variation) {
            // *Mejor quitar la columna de arriba no se si se debe sacar ...
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  variation.name,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 62.0,
                  width: double.infinity,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: variation.values.length,
                    itemBuilder: (context, index) {
                      final value = variation.values[index];
                      if (variation.name == "COLOR") {
                        return Padding(
                          padding: index > 0
                              ? const EdgeInsets.only(left: 7.0)
                              : const EdgeInsets.all(0),
                          child: GestureDetector(
                            onTap: () => cSelected(value),
                            child: ShowColorVariation(
                              value: value,
                              isSelected: colorSelected == value,
                            ),
                          ),
                        );
                      }
                      if (variation.name == "SIZE") {
                        return Padding(
                          padding: index > 0
                              ? const EdgeInsets.only(left: 7.0)
                              : const EdgeInsets.all(0),
                          child: GestureDetector(
                            onTap: () => sSelected(value),
                            child: ShowVariation(
                              value: value,
                              isSelected: sizeSelected == value,
                            ),
                          ),
                        );
                      }
                      // ? de donde traerlo de las variation list de produc group?
                      // * para no hacer =="" datos quemados
                      return Text("variation no implementada");
                    },
                  ),
                )
              ],
            );
          },
        )
      ],
    );
  }
}

class ShowColorVariation extends StatelessWidget {
  final String value;
  final bool isSelected;
  const ShowColorVariation({
    super.key,
    required this.value,
    required this.isSelected,
  });

  Color getColor(value) {
    if (value == "BLACK") {
      return Colors.black54;
    }
    if (value == "LEAD") {
      // Hex es universal para web tambien ver
      return const Color(0xFF42A5F5);
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56.0,
      height: 56.0,
      // Como develver des e backend en la base de datos agregar name y value
      // las tallas sono tendran name y values nulo,
      // como sabemos que el campo value vendrá cuando es color podemos usar !
      // SERIA MEJOR GUARDAR LOS COLORES EN LA BASE DE DATOS ? WORDPRESS GUARDA LA PAGINA COMPLETA
      decoration: BoxDecoration(
        color: getColor(value),
        //borderRadius: BorderRadius.circular(8),
        border: isSelected ? Border.all(color: Colors.black, width: 1.5) : null,
        //color: isSelected ? Colors.blue : Colors.black54,
        //width: isSelected ? 3 : 1, // más grueso si está seleccionado
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SizedBox(
          child: Text(
            value,
            style: const TextStyle(color: Colors.white, fontSize: 14.0),
          ),
        ),
      ),
    );
  }
}

class ShowVariation extends StatelessWidget {
  //final Function(String)? onTap;
  final String value;
  final bool isSelected;
  //const ShowVariation({super.key, required this.value, required this.onTap});
  const ShowVariation({
    super.key,
    required this.value,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        //padding: EdgeInsets.zero,
        width: 56.0,
        height: 56.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black54),
          color: isSelected ? Colors.black : Colors.white,
        ),
        child: Center(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 14.0,
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
