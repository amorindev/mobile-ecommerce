import 'package:flu_go_jwt/design/foundations/app_colors.dart';
import 'package:flu_go_jwt/design/foundations/app_sizes.dart';
import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/order/bloc/order_bloc.dart';
import 'package:flu_go_jwt/utils/dialogs/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // * De momento incluira varias cosas el reument de todos la direcciones
    // * impuestos igv, apple(no se si es legal ponerlo), costo de envio como
    // * calcularlo y donde creo que enviamos los km desde el frontend
    return BlocListener<OrderBloc, OrderState>(
      listener: (context, state) async {
        // * Falta los mensajes de carga
        if (state is OrderStatePay) {
          // ! por que suceess es requerido hacer lomismo para los demás
          if (state.success!) {
            // * Pago completado
            // ? se debería llamar desde aqui que pasa con el mounted
            if (context.mounted) {
              await showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  backgroundColor: AppColors.whiteColor,
                  title: const Text("Pago exitoso"),
                  content: const Text("Tu pago fue procesado correctamente."),
                  actions: [
                    TextButton(
                      onPressed: () {
                        context.go(AppRoutes.cartRoute);
                        // Aquí rediriges al carrito o a otra pantalla
                      },
                      child: const Text("Volver al carrito"),
                    ),
                  ],
                ),
              );
            }
          }
          if (state.exception != null) {
            if (context.mounted) {
              await showErrorDialog(
                context,
                state.exception.toString(),
              );
            }
          }
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.horizontalMediumPadding,
            ),
            child: Column(
              children: [
                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    return (state is OrderStatePay)
                        ? Container(
                            width: double.infinity,
                            margin: const EdgeInsets.only(
                              bottom: 10.0,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              border: Border.all(
                                color: AppColors.blackColor,
                              ),
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 8.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [const Text("Subtotal:"), Text("S/.${state.subTotal.toString()}")],
                                  ),
                                ),
                                state.deliveryType == "delivery"
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 8.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            const Text("Delivery:"),
                                            Text("S/.${state.shippingCost.toString()}")
                                          ],
                                        ),
                                      )
                                    : const SizedBox(),

                                state.deliveryType == "pickup"
                                    ? const Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12.0,
                                          vertical: 8.0,
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [Text("Pickup:"), Text("Free")],
                                        ),
                                      )
                                    : const SizedBox(),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0,
                                    vertical: 8.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [const Text("Total:"), Text("S/.${state.total.toString()}")],
                                  ),
                                ),

                                // *como debug
                                //Text("Pickup ${state.pickup.toString()}"),
                                //Text("Pickup ${state.delivery.toString()}"),

                                // costo de envio en delivery - pickup free
                                // que datos se va agregar segun el tipo de envio
                                /* Text(
                                  "Impuestos lista google allet igv envi ${state.total.toString()}",
                                  overflow: TextOverflow.ellipsis,
                                ), */
                                // ! total descuento producto discount o cupon
                                // ! el de producto no se muestra me parede
                                // ! el depago con tarjeta fecha festiva o  cupon de descuento
                                // ! Agregar campo total descuento
                              ],
                              // tax and fees
                              // llatmar total order o subtotal al carrio
                            ),
                          )
                        : const Text("An error ocurrer payment screen");
                  },
                ),

                // como sacar el costo del delivery maps km
                // impuesto o como se aplica impuesto wallets
                // o solo cobrar mas caro sin poner ver
                // * que pasa si tenemos varioas almacenes en diferentes lugares
                // * solo mostramos al usuario el almacen de productos que estan disponibles
                // * en su pais o todos
                // * y como calcular el costo de envío
                // ! ver multialmacen costo de envio  local o si es de otro almacen fuera
                // ! donde guardar los datos en que bloc de carrito o order me parece que order
                // const Text("o walleets de apple google pay impuesto"),

                BlocBuilder<OrderBloc, OrderState>(
                  builder: (context, state) {
                    final isLoading = state is OrderStatePay && state.isLoading;

                    return GestureDetector(
                      onTap: isLoading
                          ? null
                          : () async {
                              // ! que se vea como si se presionara el boton en todos los gesture detectors
                              // ! con containers, y delete account probar el reenviar email
                              // ! verifiar que sean solo 3 intentos de al enviar el codigo otp
                              // ! password de min 8 digitos y lo que falta de validacioens
                              // ! despues categorias y mostrar mas productos pagiancion o sign in eliges
                              // ! ir viendo el tiempo y de adm de proyectos avanzar

                              // ? ver como comnicar bloc uno es instanciando
                              // ? otro es creando Block builr y pasarlo
                              // ? el de GoPay me parece que no debe instanciar el bloc
                              // ? y se debe pasar por parametros a esta pantall ver
                              // ! ver que no de error los !

                              final authState = context.read<AuthBloc>().state;
                              if (authState is AuthStateSignedIn) {
                                //  en este punto deberi no ser nulo
                                final accessToken = authState.authResponse!.session!.accessToken;
                                context.read<OrderBloc>().add(OrderEventCreate(
                                      accessToken: accessToken,
                                    ));
                              }
                            },
                      child: Container(
                        height: 60.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isLoading ? AppColors.grey2Color : AppColors.brandColor,
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Center(
                          child: isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(),
                                )
                              : const Text(
                                  "Pay",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                    );
                  },
                ),
                /* GestureDetector(
                  onTap: () async {
                    // * NO funciona
                    final billingDetails = BillingDetails(
                      email: 'test@example.com',
                      phone: '+1234567890',
                      address: Address(
                        city: 'Lima',
                        country: 'PE',
                        line1: 'Calle Falsa 123',
                        line2: '',
                        state: 'Lima',
                        postalCode: '15000',
                      ),
                    );
                    await Stripe.instance.confirmSetupIntent(
                      paymentIntentClientSecret: "pi_3RTrQfE8kZ8WrN6r1nwtUpuV_secret_1XXN9SkApTBvgD5T93wGN1n7j",
                      params: PaymentMethodParams.card(
                        paymentMethodData: PaymentMethodData(
                          billingDetails: billingDetails,
                        ),
                      ),
                    );


                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.redColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Save card",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
 */

                // ? es desde el backend
                /* GestureDetector(
                  onTap: () async {
                    // * NO funciona
                    final billingDetails = BillingDetails(
                      email: 'test@example.com',
                      phone: '+1234567890',
                      address: Address(
                        city: 'Lima',
                        country: 'PE',
                        line1: 'Calle Falsa 123',
                        line2: '',
                        state: 'Lima',
                        postalCode: '15000',
                      ),
                    );
                    await Stripe.instance.confirmSetupIntent(
                      paymentIntentClientSecret: "pi_3RTrQfE8kZ8WrN6r1nwtUpuV_secret_1XXN9SkApTBvgD5T93wGN1n7j",
                      params: PaymentMethodParams.card(
                        paymentMethodData: PaymentMethodData(
                          billingDetails: billingDetails,
                        ),
                      ),
                    );


                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    height: 60.0,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColors.redColor,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Center(
                      child: Text(
                        "Save card",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ), */

                // ver si se usa este sizedbox para ver hasta el ultimo elemento, y no tape el boton
                //  asi para todos
                const SizedBox(height: 10.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
