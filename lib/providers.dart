import 'package:flu_go_jwt/app.dart';

import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/auth/use_cases/api/auth_dio_gateway.dart'
    as auth_gateway;
import 'package:flu_go_jwt/services/ecomm/address/bloc/address_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/address/use_cases/api/address_api_use_case.dart';
import 'package:flu_go_jwt/services/ecomm/cart/bloc/cart_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/order/bloc/order_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/order/use_cases/api/order_api_dio_use_case.dart';
import 'package:flu_go_jwt/services/ecomm/product/bloc/product_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/product/use_cases/api/api_dio_gateway.dart'
    as product_gateway;
import 'package:flu_go_jwt/services/ecomm/stores/bloc/store_bloc.dart';
import 'package:flu_go_jwt/services/ecomm/stores/use_cases/store_api_use_case.dart';
import 'package:flu_go_jwt/services/onboarding/bloc/onboarding_bloc.dart';
import 'package:flu_go_jwt/services/onboarding/use_cases/api/onboarding_api_use_case.dart';
import 'package:flu_go_jwt/services/payment/stripe/use_cases/stripe_impl.dart';
import 'package:flu_go_jwt/services/phone/bloc/phone_bloc.dart';
import 'package:flu_go_jwt/services/phone/use_cases/api/phone_api_use_case.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            // * como hat dos aue se llaman api dio usar alias en los import o camviar el nombre de a clase
            create: (context) => AuthBloc(auth_gateway.AuthDioGateway())
              ..add(const AuthEventInitialize())
            //..add(const AuthEventBranchIoEventSuscribe()),
            ),
        BlocProvider<ProductBloc>(
          create: (context) => ProductBloc(product_gateway.ApiDioGateway()),
        ),
        BlocProvider<CartBloc>(
          create: (context) => CartBloc(),
        ),
        // * como hacer prereloasing
        // * hay que cargar los onboaring como esta inicial para que no me muestre nuevamente la carga?
        BlocProvider<OnboardingBloc>(
          create: (context) => OnboardingBloc(
            OnboardingApiUseCase(),
          ),
        ),
        BlocProvider<AddressBloc>(
          create: (context) => AddressBloc(
            AddressApiUseCase(),
          ),
        ),
        BlocProvider<PhoneBloc>(
          create: (context) => PhoneBloc(PhoneApiUseCase()),
        ),

        BlocProvider<StoreBloc>(
          create: (context) => StoreBloc(
            StoreApiUseCase(),
          ),
        ),
        BlocProvider<OrderBloc>(
            create: (context) => OrderBloc(OrderApiDioUseCase(), StripeImpl())),
      ],
      child: const AppPrincipal(),
    );
  }
}
