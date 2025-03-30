import 'package:flu_go_jwt/router/router.dart';
import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/auth/use_cases/api/api_dio_gateway.dart';
import 'package:flu_go_jwt/services/branchio/bloc/branch_io_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/* class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(ApiDioGateway()),
        ),
        BlocProvider<BranchIoBloc>(
          create: (context) => BranchIoBloc(),
        )
      ],
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(),
          ),
          ChangeNotifierProvider<BranchIoProvider>(
            create: (_) => BranchIoProvider(),
          )
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: Colors.white,
          ),
          routerConfig: AppRouter.router,
        ),
      ),
    );
  }
} */

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(ApiDioGateway()),
        ),
        BlocProvider<BranchIoBloc>(
          create: (context) => BranchIoBloc(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
        ),
        onGenerateRoute: AppRouter.onGenerateRoute,
      ),
    );
  }
}
