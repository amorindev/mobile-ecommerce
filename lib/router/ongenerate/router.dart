import 'package:flu_go_jwt/router/app_routes.dart';
import 'package:flu_go_jwt/screens/auth/sign_in_screen.dart';
import 'package:flutter/material.dart';

class OngeneratedRouter {
  // *ver si conserva los datos par eso estan los blocs, responsabilidades
  static Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
    //final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.signInRoute:
        //final data = settings.arguments as String; // que pasa si es vacío o nulo
        //if(data.isEmpty) return; no navegues
        return MaterialPageRoute(
          builder: (context) => const SignInScreen(),
        );

      // * Agregar las demás rutas

      default:
        return MaterialPageRoute(
          builder: (context) => const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
    }
  };

  /* static Route<dynamic>? onGenerateRoute2(RouteSettings settings) {
    switch (settings.name) {
    }
  } */
}

/* Route<dynamic>? Function(RouteSettings)? onGenerateRoute = (settings) {
  switch (settings.name) {
    //
    case AppRoutes.loginPage:
      return MaterialPageRoute(builder: (context) => const LoginPage());
    case AppRoutes.registerPage:
      return MaterialPageRoute(builder: (context) => const RegisterPage());
    case AppRoutes.verifyEmailPage:
      return MaterialPageRoute(builder: (context) => const VerifyEmailPage());

    case AppRoutes.notesPage:
      return MaterialPageRoute(builder: (context) => const NotesPage());
    case AppRoutes.homePage:
      return MaterialPageRoute(builder: (context) => const HomePage());

    case AppRoutes.profilePage:
      return MaterialPageRoute(builder: (context) => const ProfilePage());

    case AppRoutes.createUpdateNotePage:
      return MaterialPageRoute(
        builder: (context) => CreateUpdateNotePage(
          note: settings.arguments as CloudNote?,
        ),
      );

    default:
      return MaterialPageRoute(builder: (context) => const LoginPage());
  }
}; */

// TODO: ongenerated route
/*
bottomNavigationBar: BottomNavigationBar(
  items: const <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      label: 'Home',
      icon: Icon(Icons.home),
    ),
    BottomNavigationBarItem(
      label: 'Cart',
      icon: Icon(Icons.add_shopping_cart),
    ),
    BottomNavigationBarItem(
      label: 'Purchases',
      icon: Icon(Icons.shopping_bag_outlined),
    ),
    BottomNavigationBarItem(
      label: 'Profile',
      icon: Icon(Icons.person),
    ),
  ],
  currentIndex: _selectedIndex,
  selectedItemColor: Colors.blue,             // Color del seleccionado
  unselectedItemColor: Colors.grey,            // Color de los no seleccionados
  onTap: (index) {
    setState(() {
      _selectedIndex = index;
    });
    _goToBranch(_selectedIndex);
  },
),


 */
