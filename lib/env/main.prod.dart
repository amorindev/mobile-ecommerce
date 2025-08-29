import 'dart:async';
import 'package:flu_go_jwt/providers.dart';
import 'package:flu_go_jwt/services/payment/stripe/model/stripe.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  await StripeProvider.initialize();

  runApp(const MainApp());
}
