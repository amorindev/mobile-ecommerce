import 'dart:async';
import 'package:flu_go_jwt/services/auth/bloc/auth_observer.dart';
import 'package:flutter/material.dart';

import 'package:flu_go_jwt/app.dart';
import 'package:flu_go_jwt/services/auth/constants/constants.dart';
import 'package:flu_go_jwt/services/auth/models/model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

import 'dart:developer' as developer show log;

import 'package:flutter_dotenv/flutter_dotenv.dart';
//import 'package:hive_ce_flutter/adapters.dart';
import 'package:flu_go_jwt/services/auth/hive/hive_registrar.g.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

extension Log on Object {
  void log() => developer.log(toString());
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterBranchSdk.init();
  //FlutterBranchSdk.validateSDKIntegration();

  // * main de desarrollo
  //BranchioService.instance.initializeBranch();

  await dotenv.load(fileName: ".env");

  // * Hive
  await Hive.initFlutter();
  Hive.registerAdapters();

  // * desde el main, o desde el constructor o desde la función
  // * crear variable o desde .env?

  // * Asegúrate que tengan nombre único
  /* if (!Hive.isBoxOpen(AppConstants.credentials)) {
  } */
  await Hive.openBox(AppConstants.credentials);

  /* if (!Hive.isBoxOpen(AppConstants.authHiveKey)) {
  } */
  await Hive.openBox<Session>(AppConstants.authHiveKey);
  //await Hive.openBox<List<Session>>("auth");

  Bloc.observer = AuthBlocObserver();
  runApp(const MainApp());
}

// crear otro main para prod

// ? * cul es la direferencia entre llamar estas funciones desde el contrcutor 
// * pra empezar  no puedes usar async await en el contructor