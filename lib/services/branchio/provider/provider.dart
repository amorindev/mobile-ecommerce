import 'dart:async';

import 'package:flu_go_jwt/main.dart';
import 'package:flu_go_jwt/services/branchio/service.dart';
import 'package:flutter/material.dart';

// usa as String genera erro o nul? si no es estringpor que es dynamic
const tokenMap = 'token';

class BranchIoProvider extends ChangeNotifier {
  Map<dynamic, dynamic>? deepLinkData;
  final BranchioService _branchioService = BranchioService();
  String? deepLinkToken;

  BranchIoProvider() {
    // ! en branchio page si te salia los logs ahora que cambiste a gorouter no te sale los logs
    // ! ver primero eso seguro por que no lo estas consumiendo
    // ! en  el backend crea un enlace token/desdes212 mas significativo
    // ! me parece que debes usar /open/ en gorouter
    // ! Cuando haces clic en el enlace de branchio a cual llega ago_router al listener o xml
    // ? se debe crear el link en branchio?
    //  <data android:scheme="go-flutter" android:host="open" android:pathPattern="/.*" />

    // * el repo de medium de branchio
    //* no usa flutter_config pero mira su  build.gradle
    //_branchioService.initDeepLinkListener();

    // ? no deveria estar dentro del constructor?
    // se debe crear un late final StreamSubscription<Map<dynamic, dynamic>> _test antes del  listen?
    _branchioService.branchIoStream.listen(
      (data) {
        if (deepLinkData!.containsKey('+clicked_branch_link') &&
            deepLinkData!['+clicked_branch_link'] == true) {
          "routerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr3".log();

          final token = deepLinkData!['token']; // Parámetro del enlace
          final tokenM =
              deepLinkData![tokenMap] as String?; // Parámetro del enlace
          deepLinkToken = tokenM;

          if (token != null) {
            "routerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr".log();
          } else {
            "routerrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr2".log();
          }
        }
        //deepLinkData = data;

        deepLinkData.toString().log();
        notifyListeners();
      },
    );
  }
 Future test() async {
    StreamSubscription mySuscription = _branchioService.branchIoStream.listen(
      (data) {
        "BranchioService -------------------------".log();
        if (data.isNotEmpty) {
        } else {
          "BranchioService -  data is empty".log();
        }
      },
    );
  }

  // * despues de obtener el token lo enviámos al backend
  // *llamar a otro evento desde el mismo bloc despues del listen o desde la pantalla verify
}
