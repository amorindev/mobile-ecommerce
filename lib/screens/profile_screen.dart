import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/address/bloc/address_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/cart/bloc/cart_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/order/bloc/order_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/product/bloc/product_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/stores/bloc/store_bloc.dart';
import 'package:flu_go_jwt/services/phone/bloc/phone_bloc.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

// * Tenemos el google sign out revisasr
// * cambiar los align a right y no center si es center pero verificar si es un box se ira al medio dont worry
// * ! Listview tiene padding, usa only rigt si usas tabs o que afecte la parte de la derecha o ambas
class _ProfileScreenState extends State<ProfileScreen> {
  //String phone = "901236589d";
  String? phone;
  String? postalCode;

  /*  */

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateSignedIn) {
          if (state.exception is Exception) {
            await showErrorDialog(context, 'Generic exception');
          }
        }
        // ! Otra forma es poner los Navigator donde se necesitean
/*         if (state is AuthBlocng) {
          showLoadingDialog(context);
          return;
        }
        Navigator.of(context, rootNavigator: true).pop();
        if (state is AuthBlocd) {
          await showErrorDialog(context);
        }
        if (state is AuthBlocss) {
          showSuccessDialog(context);
        } */

        // * Quiero saber si el otroescucha si no doble navegacion, si eso pasa agregra un
        // * atributo pagina que lo debe hacer, AuthState agregar final string page;
        /* if (state is AuthStateSignedOut) {
         // comparar la pagina

       } */
        if (state is AuthStateSignedOut) {
          if (!state.isLoading) {
            // error al cerrar sesion
            if (state.exception == null) {
              if (context.mounted) {
                // ver los demas como phone address (importante todos menos auth)
                // si por que usara valores precargados el anterior se debe reiniciar todos
                // los blocs menos auth me parece o como seria
                context.read<AddressBloc>().add(AddressEventReset());
                context.read<CartBloc>().add(CartEventResetCart());
                context.read<OrderBloc>().add(OrderEventReset());
                context.read<ProductBloc>().add(ProductEventReset());

                context.read<StoreBloc>().add(StoreEventReset());
                context.read<PhoneBloc>().add(PhoneEventReset());
                // se congela la app si se activa esto
                // por que esta antes del sign in me parece entonces de momento
                // no lo vamos a usar
                /* context.read<OnboardingBloc>().add(OnboardingEventReset()); */
                // ? necesita await ?

                await GoRouter.of(context).pushReplacement(
                  AppRoutes.signInRoute,
                );
              }
            }
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Profile",
              //textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: AppColors.brandColor,
          actions: [
            // * ver si se usará inhereted widget ya quee no es tan complejo
            // * y cuando usar animedt builder de diegoveloper casos de uso
            // * dende iría de momento lo dejo aqui
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.dark_mode,
                color: AppColors.whiteColor,
              ),
            )
          ],
        ),
        backgroundColor: AppColors.whiteColor,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.only(right: 10.0, left: 10.0, top: 10.0),
            children: [
              /* const SizedBox(height: 10.0), */
              /* const Text(
                textAlign: TextAlign.center,
                'PROFILE',
                //style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700),
              ), */
              const SizedBox(height: 10.0),
              Stack(
                alignment: Alignment.center, // ! ver si funcina pero
                children: [
                  CircleAvatar(
                    radius: 60.0,
                    backgroundColor: AppColors.grey2Color,
                    child: Image.asset(
                      'assets/profile.png',
                      //fit: BoxFit.cover,
                      //height: 130.0,
                    ),
                  ),
                  /* const CircleAvatar(
                    radius: 60.0,
                    backgroundImage: NetworkImage(
                      'https://plus.unsplash.com/premium_photo-1689568126014-06fea9d5d341?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
                    ),
                  ), */
                  /* Positioned(
                    bottom: 18.0,
                    right: 105.0,
                    child: GestureDetector(
                      child: const CircleAvatar(
                        radius: 16.0,
                        backgroundColor: AppColors.blackColor,
                        child: Icon(
                          Icons.add_a_photo,
                          size: 21.0,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ), */
                ],
              ),
              const SizedBox(height: 10.0),
              /* const Text(
                'Fernando Amorin',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                'Senior software engineer',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ), */
              const SizedBox(height: 30.0),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthStateSignedIn) {
                    return Card(
                      elevation: 2.0,
                      shadowColor: Colors.black12,
                      child: BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, state) {
                          if (state is AuthStateSignedIn) {
                            return ListTile(
                              title: Text(
                                state.authResponse!.user.name!,
                              ),
                              leading: const Icon(
                                Icons.person,
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 2.0,
                shadowColor: Colors.black12,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthStateSignedIn) {
                      //final authState = state as AuthStateSignedIn;
                      return ListTile(
                        title: Text(
                          state.authResponse!.user.email,
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
              const SizedBox(height: 8.0),
              Card(
                elevation: 2.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  onTap: () {
                    GoRouter.of(context).push(AppRoutes.phonesRoute);
                  },
                  title: const Text(
                    "Phones",
                  ),
                  leading: const Icon(
                    Icons.phone,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 2.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  onTap: () {
                    GoRouter.of(context).push(AppRoutes.addressRoute);
                  },
                  title: const Text(
                    "Addresses",
                  ),
                  leading: const Icon(
                    Icons.edit_location,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              const SizedBox(height: 8.0),
              const Divider(),
              Card(
                elevation: 2.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  onTap: () {
                    GoRouter.of(context).push(AppRoutes.changePasswordRoute);
                  },
                  title: const Text(
                    "Change password",
                  ),
                  leading: const Icon(
                    Icons.logout,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              const SizedBox(height: 8.0),
              Card(
                elevation: 2.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  onTap: () {
                    context.read<AuthBloc>().add(const AuthEventSignOut());
                  },
                  title: const Text(
                    "Sign out",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                  leading: const Icon(
                    Icons.logout,
                    color: Colors.redAccent,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              const SizedBox(height: 8.0),
              /* Card(
                elevation: 2.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  onTap: () {
                    GoRouter.of(context).push(AppRoutes.settingsRoute);
                  },
                  title: const Text(
                    "Configuration",
                  ),
                  leading: const Icon(
                    Icons.settings,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              const SizedBox(height: 8.0), */
              /* Card(
                elevation: 2.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  onTap: () {
                    GoRouter.of(context).push(AppRoutes.adminRoute);
                  },
                  title: const Text(
                    "Admin",
                  ),
                  leading: const Icon(
                    Icons.admin_panel_settings,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              const SizedBox(height: 10.0), */
              Card(
                elevation: 2.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  onTap: () {
                    GoRouter.of(context).push(AppRoutes.twoFactorAuthRoute);
                  },
                  title: const Text(
                    "Two-factor authentication",
                  ),
                  leading: const Icon(
                    Icons.admin_panel_settings,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              const SizedBox(height: 10.0),
              Card(
                elevation: 2.0,
                shadowColor: Colors.black12,
                child: ListTile(
                  onTap: () {
                    GoRouter.of(context).push(AppRoutes.deleteAccountRoute);
                  },
                  title: const Text(
                    // * deve ser account settings para todo lo relacionado a la cuenta
                    // * y el otro perfil todo asociado al usuario orders, direcicones
                    "Delete account",
                  ),
                  leading: const Icon(
                    Icons.admin_panel_settings,
                  ),
                  trailing: const Icon(Icons.chevron_right),
                ),
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}


// * Si usamos mas adelante
/* void _showEditDialog({
    required String title,
    required String initialValue,
    required Function(String) onConfirm,
  }) {
    final controller = TextEditingController(text: initialValue);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Editar $title'),
          content: TextField(
            controller: controller,
            decoration: InputDecoration(labelText: title),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm(controller.text);
                Navigator.pop(context);
              },
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  
  Card(
                elevation: 2.0,
                shadowColor: Colors.black12,
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is AuthStateSignedIn) {
                      return ListTile(
                        title: postalCode != null
                            ? Text(
                                postalCode!,
                              )
                            : const Text(
                                "postal code",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                        leading: const Icon(
                          Icons.numbers,
                        ),
                        trailing: IconButton(
                          onPressed: () {
                            _showEditDialog(
                              title: "Codigo postal",
                              initialValue: "",
                              onConfirm: (p0) {
                                setState(() {
                                  postalCode = p0;
                                });
                              },
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
  
  } */