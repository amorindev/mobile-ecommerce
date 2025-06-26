import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/address/bloc/address_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/address/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddressesScreen extends StatefulWidget {
  const AddressesScreen({super.key});

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  @override
  void initState() {
    super.initState();

    final authState = context.read<AuthBloc>().state;
    if (authState is AuthStateSignedIn) {
      final accessToken = authState.authResponse!.session!.accessToken;
      BlocProvider.of<AddressBloc>(context).add(AddressEventGetAll(
        accessToken: accessToken,
      ));
    }
  }

  void _showAddressDialog(BuildContext context) {
    final TextEditingController labelController = TextEditingController();
    final TextEditingController addressController = TextEditingController();
    final TextEditingController postalCodeController = TextEditingController();
    final TextEditingController cityController = TextEditingController();
    final TextEditingController stateController = TextEditingController();
    final TextEditingController countryController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nueva Dirección'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: labelController,
                decoration: const InputDecoration(
                  labelText: 'Etiqueta (ej. Casa, Oficina)',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: 'City',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: stateController,
                decoration: const InputDecoration(
                  labelText: 'State',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: countryController,
                decoration: const InputDecoration(
                  labelText: 'Country',
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: postalCodeController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Código Postal',
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              final label = labelController.text;
              final address = addressController.text;
              final postalCode = postalCodeController.text;
              final city = cityController.text;
              final stateS = stateController.text;
              final country = countryController.text;

              // Aquí podrías guardar o enviar estos datos
              //debugPrint('Label: $label');
              //debugPrint('Dirección: $address');
              //debugPrint('Código Postal: $postalCode');

              final authState = context.read<AuthBloc>().state;
              // por eso no conviene el
              // de vandad por que para
              // navegar cambia el estado
              // como navegar al registro
              if (authState is AuthStateSignedIn) {
                //  en este punto deberi no ser nulo
                final accessToken =
                    authState.authResponse!.session!.accessToken;

                // ! aqui se rompe
                /* context.read<AddressBloc>().add(AddressEventCreate(
                      accessToken: accessToken,
                      label: label,
                      addressLine: address,
                      city: city,
                      state: stateS,
                      country: country,
                      postalCode: postalCode,
                    )); */
                Navigator.pop(context);
                // es necesario hacer return;
                // * Si no cumple con esta condiccion AuthStateSignedIn crear un evento para forzar eliminar authblocResp session dejarlo a nulo y redireccionar a sign in screen
                //! entonces si lo realizo de esta manera no hay necesidad de tener la session dentro del bloc si no hacemos la validacion if (authState2 is AuthStateSignedIn) si no es eso redireccionamos o haemos otra determinada acccion peor que pasa si es acccess token y  refreshtoken y que pasa tambien si quitamos
                //! (dentro de Authbloc) esto cambiaría la forma de validar ya no usariamos si authRespBloc es nulo sino verificaríamos si state is AuthStateSignIn obtenemos el access o los datos del user si es nulo lo redireccionames ver como hacer el testing

                // si no tambien jhara el conext pop de abajo

                // * no se si aqui funcioanra lo digo por el navigator  no es lo eficiente llamar a la api y ovlver a traer la lista, además no se si llamarlo desde aqui o desde el listener si fue exitos de momento asi
                /* context.read<AddressBloc>().add(AddressEventGetAll(
                      accessToken: accessToken,
                    )); */
                return;
              }
              // ! ver por que al dejar
              // !AuthResponse? authResponseBloc;
              //!Session? sessionBloc;
              // ! en elbloc seria mejor para pasarlo a nuestro paquete y asi crear como firebase auth o supabase ver si es necesario agregar una capa mas, de momento comenta los authResponseBloc y usa el estado SignedIn
              //debugPrint('El state no es signed in ');
              //debugPrint('verifica la lógica del bloc');
              // * esose debería validar en el bloc para la redireccion al como hacer de momento solo cerrare la pantalla emergente ver desde donde redireccionar o validarlo no deberia llegar aqui
              // Navigator pertenece a goruter? ver
              Navigator.pop(context);
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //String direccion = "Av. José Pardo 610, Miraflores, Lima 15074, Perú";
    //String? direccion;
    return BlocListener<AddressBloc, AddressState>(
      listener: (context, state) async {
        /* if (state is AddressStateLoaded) {
          if (state.exception != null) {
            await showErrorDialog(context, state.exception.toString());
          }
          if (state.isLoading) {
            if (context.mounted) {
              LoadingScreen().show(
                context: context,
                text: state.loadingText ?? 'loading ...',
              );
            }
          } else {
            LoadingScreen().hide();
          }
        }

        if (state is AddressStateLoaded) {
          if (state.exception != null) {
            if (context.mounted) {
              await showErrorDialog(context, state.exception.toString());
            }
          }
          if (state.isLoading) {
            if (context.mounted) {
              LoadingScreen().show(
                context: context,
                text: state.loadingText ?? 'loading ...',
              );
            }
          } else {
            LoadingScreen().hide();
          }
        } */
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              "Addresses",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
          iconTheme: const IconThemeData(color: AppColors.whiteColor),
          backgroundColor: AppColors.brandColor,
          actions: [
            // ? _showAddressDialog se rompe ver por que position puede ser opcional ?
            /* IconButton(
              onPressed: () => _showAddressDialog(context),
              icon: const Icon(Icons.add),
            ), */
            IconButton(
              onPressed: () {
                GoRouter.of(context).push(AppRoutes.addressMapRoute);
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
        body: BlocBuilder<AddressBloc, AddressState>(
          builder: (context, state) {
            //const Text("google maps para agregra direccion"),

            if (state is AddressStateLoaded) {
              if (state.addresses == null) {
                /* return const Center(
                  child: CircularProgressIndicator(),
                ); */
                // ! aqui el backend deberia retornar [] o nose
                return const SizedBox();
              }
              if (state.addresses == []) {
                return const Center(
                  child: Text("No tienes direcciones de envío"),
                );
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.horizontalMediumPadding,
                  vertical: AppSizes.verticalP,
                ),
                itemCount: state.addresses!.length,
                itemBuilder: (context, index) {
                  final address = state.addresses![index];
                  //debugPrint(address.isDefault.toString());
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: CustomAddressCard(
                      address: address,
                    ),
                  ); /* address.isDefault
                      ? Column(
                          children: [
                            CustomAddressCard(address: address),
                             * deberia haber uno por defecto si no hat mosstrar en balnco?
                            * simplemente no mostrar bueno debería haber uno
                            * que pasa si noy como se deberia ver en los lugares que se usa
                             * al crear la orden proejemplo o aqui ver
                            const Divider(),
                          ],
                        )
                      : */
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

// ! que pasa is es el address por defecto no es necesario que aparesca marcar por defecto
class CustomAddressCard extends StatelessWidget {
  final AddressResponse address;
  const CustomAddressCard({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.blackColor,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      const TextSpan(
                          text: "Label: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: address.label),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                          text: "Address Line: ",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: address.addressLine),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: "Postal code: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: address.postalCode),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: "State: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: address.state),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: "Country: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: address.country),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style,
                    children: [
                      TextSpan(
                        text: "City: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(text: address.city),
                    ],
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Seleccionaste: $value')),
              );
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Editar',
                child: Text('Editar'),
              ),
              const PopupMenuItem<String>(
                value: 'Mark by default',
                child: Text('Mark by default'),
              ),
              //* mostrar pop up estas seguro de eliminar
              const PopupMenuItem<String>(
                value: 'Eliminar',
                child: Text('Eliminar'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
