import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/phone/bloc/phone_bloc.dart';
import 'package:flu_go_jwt/services/phone/core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthStateSignedIn) {
      final accessToken = authState.authResponse!.session!.accessToken;
      BlocProvider.of<PhoneBloc>(context).add(PhoneEventGetAll(
        accessToken: accessToken,
      ));
    }
  }

  void _showAddressDialog(BuildContext context) {
    String? countryCode;
    String? countryISOCode;
    String? number;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Nuevo numero'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IntlPhoneField(
                //controller: ,
                decoration: const InputDecoration(
                  //labelText: 'Phone number',
                  labelStyle: TextStyle(color: AppColors.blackColor),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: AppColors.blackColor)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.blackColor,
                      width: 1.0,
                    ), // Color del borde cuando está enfocado
                  ),
                ),
                initialCountryCode: 'PE',
                onChanged: (value) {
                  countryCode = value.countryCode;
                  countryISOCode = value.countryISOCode;
                  number = value.number;

                  //debugPrint("==============");
                  //debugPrint("value: $value");
                  //debugPrint("=============");
                },
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
              // Aquí podrías guardar o enviar estos datos
              //debugPrint('Label: $countryCode');
              //debugPrint('Label: $number');
              final authState = context.read<AuthBloc>().state;
              if (authState is AuthStateSignedIn) {
                //  en este punto deberi no ser nulo
                final accessToken =
                    authState.authResponse!.session!.accessToken;

                if (countryCode != null &&
                    number != null &&
                    countryISOCode != null) {
                  context.read<PhoneBloc>().add(PhoneEventCreate(
                        accessToken: accessToken,
                        countryCode: countryCode!,
                        countryISOCode: countryISOCode!,
                        number: number!,
                      ));
                }

                Navigator.pop(context);
                // es necesario hacer return;
                return;
                // * Si no cumple con esta condiccion AuthStateSignedIn crear un evento para forzar eliminar authblocResp session dejarlo a nulo y redireccionar a sign in screen
                //! entonces si lo realizo de esta manera no hay necesidad de tener la session dentro del bloc si no hacemos la validacion if (authState2 is AuthStateSignedIn) si no es eso redireccionamos o haemos otra determinada acccion peor que pasa si es acccess token y  refreshtoken y que pasa tambien si quitamos
                //! (dentro de Authbloc) esto cambiaría la forma de validar ya no usariamos si authRespBloc es nulo sino verificaríamos si state is AuthStateSignIn obtenemos el access o los datos del user si es nulo lo redireccionames ver como hacer el testing

                // si no tambien jhara el conext pop de abajo

                // * no se si aqui funcioanra lo digo por el navigator  no es lo eficiente llamar a la api y ovlver a traer la lista, además no se si llamarlo desde aqui o desde el listener si fue exitos de momento asi
                /* context.read<PhoneBloc>().add(PhoneEventGetAll(
                      accessToken: accessToken,
                    )); */
                //return;
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
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Phones",
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
          IconButton(
            onPressed: () => _showAddressDialog(context),
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: BlocBuilder<PhoneBloc, PhoneState>(
        builder: (context, state) {
          if (state is PhoneStateLoaded) {
            if (state.phones == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.phones == []) {
              return const Center(
                child: Text("No tienes numeros de telefonos de envío"),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.horizontalMediumPadding,
                vertical: AppSizes.verticalP,
              ),
              itemCount: state.phones!.length,
              itemBuilder: (context, index) {
                final phone = state.phones![index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: CustomPhoneCard(phone: phone),
                );
              },
            );
          }
          // ! algun error o volver a la pantalla aneriro?
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class CustomPhoneCard extends StatefulWidget {
  final PhoneResp phone;
  const CustomPhoneCard({
    super.key,
    required this.phone,
  });

  @override
  State<CustomPhoneCard> createState() => _CustomPhoneCardState();
}

class _CustomPhoneCardState extends State<CustomPhoneCard> {
  String getFlagEmoji(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) =>
              String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.blackColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalMediumPadding,
          vertical: AppSizes.verticalP,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              getFlagEmoji(widget.phone.countryISOCode),
              style: const TextStyle(
                fontSize: 20,
              ),
            ),
            //const SizedBox(width: 30.0),
            Text(
              widget.phone.number,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            widget.phone.isVerified
                ? const Text(
                    "verified",
                    style: TextStyle(
                      color: AppColors.greenColor,
                    ),
                  )
                : const Text(
                    "verify",
                    style: TextStyle(
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}

class CustomPhoneCard2 extends StatefulWidget {
  final PhoneResp phone;
  const CustomPhoneCard2({
    super.key,
    required this.phone,
  });

  @override
  State<CustomPhoneCard2> createState() => _CustomPhoneCard2State();
}

class _CustomPhoneCard2State extends State<CustomPhoneCard2> {
  String getFlagEmoji(String countryCode) {
    return countryCode.toUpperCase().replaceAllMapped(
          RegExp(r'[A-Z]'),
          (match) =>
              String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5.0),
      margin: const EdgeInsets.only(bottom: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: AppColors.blackColor,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.horizontalMediumPadding,
          vertical: AppSizes.verticalP,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /* Text(
              getFlagEmoji(widget.phone.countryISOCode),
              style: const TextStyle(
                fontSize: 20,
              ),
            ), */
            Icon(Icons.numbers),
            //const SizedBox(width: 30.0),
            Text(
              widget.phone.number,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            widget.phone.isVerified
                ? const Text(
                    "verified",
                    style: TextStyle(
                      color: AppColors.greenColor,
                    ),
                  )
                : const Text(
                    "verify",
                    style: TextStyle(
                      color: AppColors.blueColor,
                      fontWeight: FontWeight.w500,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
