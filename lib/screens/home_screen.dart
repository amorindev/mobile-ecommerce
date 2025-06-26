import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/services/auth/models/modelv2.dart';
import 'package:flu_go_jwt/services/ecomm/product/bloc/product_bloc.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ProductBloc>(context).add(const ProductEventGetProducts());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) async {
        if (state is ProductStateGetProducts) {
          if (state.exception != null) {
            await showErrorDialog(context, state.exception.toString());
          } else {}
          // falta ría el de carga
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "New Athletic",
              //textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: AppColors.brandColor,
        ),
        body: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            // ? que pasa si es nulo el product produp o los productos
            if (state is ProductStateGetProducts) {
              if (state.products == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state.products == []) {
                return const Text("No hay productos para mostrar");
              }
              return GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 0.87,
                ),
                itemCount: state.products!.length,
                itemBuilder: (context, index) {
                  final product = state.products![index];
                  return GestureDetector(
                    onTap: () {
                      if (product.variations != null &&
                          product.variations!.isNotEmpty) {
                        context.go(
                          AppRoutes.productDetailRoute,
                          extra: product,
                        );
                      } else {
                        context.go(
                          AppRoutes.productDetailWithOutVariantsRoute,
                          extra: product,
                        );
                      }
                    },
                    child: Card(
                      child: Column(
                        children: [
                          Hero(
                            tag: product.id,
                            child: FadeInImage(
                              placeholder:
                                  const AssetImage('assets/loading.gif'),
                              image: NetworkImage(product.imgUrl),
                              fit: BoxFit.cover,
                              // height: 100, mejor la manera sencilla childaspectradio
                            ),
                          ),
                          Text(
                            product.name,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            return const Center(
              child: Text("No hay productos -loading"),
            );
          },
        ),
        /* floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go('/branchio');
            },
            child: const Icon(Icons.next_plan),
          ), */

        /*
          child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthStateSignedIn) {
                      return ListTile(
                        title: Text(
                          state.authResponse.user.email,
                        ),
                        leading: const Icon(
                          Icons.email,
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
           */
      ),
    );
  }
}

// TODO mostra esto en el profile screen
class ShowSession extends StatelessWidget {
  final AuthResponse authResponse;
  const ShowSession({super.key, required this.authResponse});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(authResponse.session!.accessToken.toString()),
        Text(authResponse.session!.refreshToken),
        Text(authResponse.credentials!.provider), // en sign up esto es nulo 
        Text(authResponse.user.id),
        Text(authResponse.user.email),
        Text(authResponse.user.emailVerified.toString()),
        Text(authResponse.user.createdAt.toString()),
        Text(authResponse.user.updatedAt.toString()),
      ],
    );
  }
}
