import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/services/ecomm/order/core/resp.dart';
import 'package:flu_go_jwt/services/ecomm/order/gateway/order_gateway.dart';
import 'package:flu_go_jwt/services/ecomm/product/domain/domain_product_item.dart';
import 'package:flu_go_jwt/services/payment/stripe/gateway/stripe_gateway.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrderBloc extends Bloc<OrderEvent, OrderState> {
  // * parece arq hex injectando varios
  OrderBloc(OrderGateway gateway, StripeGateway stripeGateway)
      : super(const OrderStateInitial(
          isLoading: false,
        )) {
    on<OrderEventSetProductItems>((event, emit) {
      /* if (state is OrderStatePay) {
        final currentState = state as OrderStatePay;
        
        /* emit(currentState.copyWith(
          total: event.subtotal,
          products: event.products,
        )); */
        emit(OrderStatePay(
            deliveryType: null,
            products: event.products,
            pickup: null,
            delivery: null,
            subTotal: event.subtotal,
            total: null,
            success: false,
            exception: null,
            isLoading: false,));
      } */
// ! AQUI debemos crear por primera ves el OrderStay
      //! según nuestro flujo
      emit(OrderStatePay(
        deliveryType: null,
        products: event.products,
        pickup: null,
        delivery: null,
        subTotal: event.subtotal,
        total: event.subtotal,
        success: false,
        exception: null,
        isLoading: false,
      ));
    });

    //OrderEventSetShippingInfo
    on<OrderEventSetShippingInfo>((event, emit) {
      if (state is OrderStatePay) {
        final currentState = state as OrderStatePay;

        // agregarlo a constantes o enumeraciones
        if (event.deliveryType == "delivery") {
          if (event.delivery == null) {
            // bueno ya deberia estar vaidado o desde donde validarlo
            emit(currentState.copyWith(isLoading: false));
            emit(currentState.copyWith(
              exception: Exception("an error ocurred"),
            ));
            return;
          }

          // * Me parece que debería ir en cada paso del flujo de pago
          // * al momneto de agregar los item de los productos al carrito
          // * pongo su primer valor asi que no será nulo
          // * en pickup no se deberia cambiar nada ver
          final total = currentState.subTotal! + currentState.shippingCost;
          // ! AQUI debemos crear por primera ves el OrderStay
          emit(currentState.copyWith(
            deliveryType: event.deliveryType,
            delivery: event.delivery,
            total: total,
          ));

          return;
        }
        if (event.deliveryType == "pickup") {
          if (event.pickup == null) {
            // bueno ya deberia estar vaidado o desde donde validarlo
            //debugPrint("error pickup should be not empty");
            return;
          }
          emit(currentState.copyWith(
            deliveryType: event.deliveryType,
            pickup: event.pickup,
            // ! harcodear
            total: currentState.subTotal,
          ));
          return;
        }
      }
    });

    on<OrderEventCreate>((event, emit) async {
      // casas hacer un recarga de pagina para ver el ultimo agregado
      // por que usa webhooks y podemos ver el estado en no pagodao
      // o usar reload
      // poner colores del stado pendiente o pagaod ver
      if (state is OrderStatePay) {
        final currentState = state as OrderStatePay;
        emit(currentState.copyWith(
          // datos de las pantallas anteriores
          isLoading: true,
        ));

        // cerrar la pantalla  si no es OrderStayPay

        // emit(state); cuando usarlo o uasr copiwith

        // ver como manejar diferentes paises
        const String currency = "PEN";
        // * Todo ver los dos flujos web y mobile -stripe
        // el backend lo parsea - ver
        // ver desde donde poner el currency

        /* final authBloc = AuthBloc(AuthDioGateway());
      // en este punto deeriamos tener el accestoken
      final accessToken = authBloc.sessionBloc!.accessToken; */

        // ? Obtiene el client secret
        // ? ver como manejar el currency frontend o backend o ambos - creo que se envia del frontend
        // ? para adjuntarlo en la data
        // ver s van en una sola consulta o infrige single responsability
        // * si vas acrear  varios metodos de pago separar porque este uarrá stripe

        // * En ambos no debe
        // * products no deber nulo
        // *  total no debe ser nulo
        // *  deliveryType no debe ser nulo
        // * subTotal no debe ser nulo no requerdio
        if (currentState.deliveryType == "delivery") {
          if (currentState.delivery == null) {
            if (currentState.delivery == null) {
              //debugPrint("delivery no de ser nulo orderbloc");
            }
            emit(currentState.copyWith(
              isLoading: false,
            ));
            return;
          }
        }
        if (currentState.deliveryType == "pickup") {
          if (currentState.pickup == null) {
            if (currentState.pickup == null) {
              //debugPrint("pickup no de ser nulo orderbloc");
            }
            emit(currentState.copyWith(
              isLoading: false,
            ));
            return;
          }
        }
        final (resp, respErr) = await gateway.create(
          accessToken: event.accessToken,
          //total: event.total, me parece mejor sacarlo des estaod
          total: currentState.total!,
          // ! ver ver
          // productItems: event.products,
          productItems: currentState.products!,
          // *delivery type desde dhipping screen
          // en este punto no debería ser nulo
          deliveryType: currentState.deliveryType!,
          delivery: currentState.delivery,
          pickup: currentState.pickup,
          paymentMethod: "stripe",
          currency: currency,
        );
        //print(resp);
        //print(respErr);

        // * ver donde parar la carga hay varias consultas
        /* emit(const OrderStatePay(
        exception: null,
        isLoading: false,
      )); */
        // ! que pasa si exptira el token como obtenemos
        // ! un nueo token de momento poner en el backend
        // ! de larga uracion bueno posríamos iniciar denuevo
        // ! ver ese flujo para que no se congele la app
        // manejat loading errores nulos del resp y que no se combinen las variables
        // MANEJAR PAGOS EXITOSO
        // MANEJAR CONECCION A INTERNET MANENEJAR DIALOGOS ARE YOU SURE DELETE ACCOUNT
        if (respErr != null) {
          // *loading des aqui por que aré dos consultas asincoronas
          emit(currentState.copyWith(isLoading: false));
          emit(currentState.copyWith(exception: respErr));
          return;
        }
        // ! NO SE SI VA RETORNAR UN VAOR DE PENDERA DEl
        // ! diselo de la api
        // ! ver cual es el flujo correcto para manejar
        // ! las funciones de bloc
        /* if (resp == null) {
        emit(OrderStatePay(
          exception: Exception("nose"),
          isLoading: false,
        ));
        return;
      } */

        // * como hago por que este es otro loading
        // aplicar arq hezagonal o dentro de los
        // if antes de los retur primero parar la carga
        // circular
        // * estas haciendo dos consultas
        // * seguridad y reutilizacion?
        //print(currentState.total);
        final metadata = {'payment_id': resp!.payment.id};
        final (respPI, respPIErr) = await stripeGateway.createPaymentIntent(
          accessToken: event.accessToken,
          amount: currentState.total!,
          currency: currency,
          metadata: metadata,
        );
        
        //print(respPI);
        //print(respPIErr);
        if (respPIErr != null) {
          emit(currentState.copyWith(isLoading: false));
          emit(currentState.copyWith(exception: respPIErr));
          return;
        }

        // ? ver como separar responsabilidaes, initPaymentSheet presentPaymentSheet
        // ? ver como separar o crear custom ui para separar el bloc de stripe de momento chill
        // * recueras mitch coco cuando cierra la pantalla solo return en google signin
        // * Configurar parámetors de pago
        // ? genera error ? trycatch - separar llevarlo a stripe DDD
        // *  respPI!.clientSecret // ? veridicar si es nulo?
        // ! ver si te esta generando una orden adicional ver como signin google de mitch koko
        // ! usa los returns
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: respPI!.clientSecret,
            //customerId: , ! para save card
            // customerEphemeralKeySecret: , save card
            merchantDisplayName: "Auth Templ",
            //customFlow: true, // no completa el pago revisar como se usa
            // me parece que es para guardar los datos de la tarjeta
            // mejor crear el customer y se le pasa al cutomerId  y customer ephemeral
            /* billingDetails: const BillingDetails( es mejor primero c

                address: Address(
              city: "Callao",
              country: "PE",
              line1: "906767533",
              line2: null,
              postalCode: "07031",
              state: "Callao",
            ),), */
          ),
        );

        // * Eliminar loading de carga
        emit(currentState.copyWith(isLoading: false));

        // * Mostrar la hoja de pago
        // ? genera error ? trycatch - separar llevarlo a stripe DDD
        try {
          await Stripe.instance.presentPaymentSheet();
        } catch (e) {
          // aqui es similar al de googel sign in es null ver como manearlo
          // y como afecta al order actualizarlo a cancelado
          // que pasa si no se puedo lo dejamos en pendientes ver 
          //print(e.toString());
          return;
        }

        // ! Ver desde donde se manejaran los mensajes de error desde
        // ! la capa que consulta la api Generci Exception y pasarlo a nuestros errores
        // ! sería logico si lo vamos a validar en las siguients capas
        // ! o validarlo ya en la ui if Excetion.tostring = user-not-found
        // ! mostrar User not  found y agregar internacionalizacion
        // ! se borraria la carpeta de errrors en ese caso recuerda cmo valida goalng en
        // ! cada capa
        /* if (resp.data['message'] == EmailAlreadyInUseAuthException().toString()) {
        return (null, EmailAlreadyInUseAuthException());
      }*/
        // * De momento no necesito mostrar nada solo un success

        emit(currentState.copyWith(
          success: true,
        ));
        add(OrderEventGetAll(accessToken: event.accessToken));
        // puede ser emitiendo el estado loaded o este evento ver
        // ver por que se queda en carga
        /* emit(OrderStatePay(
          exception: respPIErr,uth
          delivery: null,
          products: null,
          subTotal: null,
          total: null,
          deliveryType: null,
          pickup: null,
          isLoading: false,
          success: true,
        )); */
      }
    });

    on<OrderEventGetAll>((event, emit) async {
      emit(const OrderStateLoaded(
        orders: null,
        exception: null,
        isLoading: true,
      ));

      // cambiar de nombre gateway a provider
      final (resp, respErr) = await gateway.getAll(
        accessToken: event.accessToken,
      );

      //print("---------------------");
      //print(resp);
      //print("---------------------");

      emit(const OrderStateLoaded(
        orders: null,
        exception: null,
        isLoading: false,
      ));

      if (respErr != null) {
        emit(OrderStateLoaded(
          orders: null,
          exception: respErr,
          isLoading: false,
        ));
        return;
      }
      // ? verificar si  es nulo los orders?
      emit(OrderStateLoaded(
        orders: resp,
        exception: null,
        isLoading: false,
      ));
    });

    on<OrderEventReset>((event, emit) {
      emit(const OrderStateInitial(isLoading: false));
    });
  }
}
