import 'package:flu_go_jwt/router/app_router.dart';
import 'package:flu_go_jwt/router/ongenerate/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPrincipal extends StatelessWidget {
  const AppPrincipal({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      
      debugShowCheckedModeBanner: false,
      color: Colors.white,
      //theme: ThemeData.light(),
      /* theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
        ), */
      // ! los componentes emergentes estan en morado revisar y el loading
      // ! los bordes de los container gray no negro opaca
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      routerConfig: AppRouter.router,
    );
  }
}

// * Con ongenerated
class MainApp2 extends StatelessWidget {
  const MainApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        /* BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(ApiDioGateway()),
        ), */
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
        ),
        /* onGenerateInitialRoutes: (initialRoute) {
          no se para que se usa
        }, */
        initialRoute: "/", // agregarloa al AppRoutes
        onGenerateRoute: OngeneratedRouter.onGenerateRoute,
      ),
    );
  }
}

/*
MaterialApp(
 initialRoute: '/',
 onGenerateRoute: (RouteSettings settings) {
  switch (settings.name) {
   case '/':
   // obtener el parámetro
    return MaterialPageRoute(builder: (context) => HomePage());
   case '/details':
    return MaterialPageRoute(builder: (context) => DetailsPage());
   default:
    return MaterialPageRoute(builder: (context) => NotFoundPage());
  }
 },
);
 */
