import 'dart:async';
import 'package:device_preview/device_preview.dart';
import 'package:flu_go_jwt/env/main.dev.dart';
import 'package:flu_go_jwt/providers.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_observer.dart';
import 'package:flu_go_jwt/services/payment/stripe/model/stripe.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

// * Crear mains para cada entorno igual en golang, flavors
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await FlutterBranchSdk.init();
  //FlutterBranchSdk.validateSDKIntegration();

  // * main de desarrollo
  //BranchioService.instance.initializeBranch();

  await dotenv.load(fileName: ".env");
  await StripeProvider.initialize();

  // * esto perfectamente para el main de desarrollo
  Bloc.observer = AuthBlocObserver();

  runApp(const MainApp());
  /* runApp(DevicePreview(
    enabled: true,
    builder: (context) {
      return const MainApp();
    },
  )); */
}


// ? * cul es la direferencia entre llamar estas funciones desde el contrcutor 
// * pra empezar  no puedes usar async await en el contructor