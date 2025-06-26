import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/services/ecomm/cart/bloc/cart_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckOutScreen extends StatelessWidget {
  const CheckOutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // * Se necesitaria el bloc de auth o user
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
      ),
      body: SafeArea(
        child: ListView(
          // * ver como afecta este padding abajo
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
          children: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Column(
                  children: [
                    const Text("Si se desea algun dato del usuario."),
                    GestureDetector(
                      onTap: () async {
                        GoRouter.of(context).push(AppRoutes.shippingRoute);
                      },
                      child: Container(
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.redColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: const Center(
                          child: Text(
                            "Continue o no se",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
