import 'dart:async';

import 'package:flu_go_jwt/main.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

// como crear objejos y clases estáticas

// * como hacer unit testing como validar los stream en provider y service que estan funcionando
// * branchio cuando la app esta en reposo no funciona
// * como hcemos para el current user cuando la app esta en stop osea salen de a app sin cerrarla
/* class BranchioSingletonService {
  late final StreamSubscription<Map<dynamic, dynamic>>? streamSubscription;
  // es single Suscription screan sin el broadcast
  late final StreamController<Map<dynamic, dynamic>> _streamController;

  // * si descomento dará error abajo
  //BranchioService();

// * como interactua con las dems variables que son final o no oson static como se mneja eso
  // * Patrón singleton, solo exista un instancia de BranchioService
  // * _ constructor privado
  static final BranchioSingletonService _instance =
      BranchioSingletonService._shared();
  BranchioSingletonService._shared() {
    _streamController = StreamController<Map<dynamic, dynamic>>.broadcast(
      onListen: () {
        _streamController.sink.add({"start": "fernan"});
      },
    );
    _initDeepLinkListener();
  }
  factory BranchioSingletonService() => _instance;

  /* final StreamController<Map<dynamic, dynamic>> _streamController =
      StreamController.broadcast(); */

  Stream<Map<dynamic, dynamic>> get branchStream {
    return _streamController.stream;
  }

  void _initDeepLinkListener() {
    streamSubscription = FlutterBranchSdk.listSession().listen(
      (data) {
        "BranchioService -------------------------".log();

        if (data.isNotEmpty) {
          _streamController.add(data);
        } else {
          "BranchioService -  data is empty".log();
        }
      },
      onError: (error) {
        ("Branchio err $error").log();
      },
    );
  }

  void disposeDeepLinkListener() {
    streamSubscription?.cancel();
    _streamController.close();
  }
} */

// * Empezar el _initlistener desde el bloc igual que el initialize?

class BranchioService {
  static final BranchioService _instance = BranchioService._shared();
  BranchioService._shared();
  factory BranchioService() => _instance;

  Stream<Map<dynamic, dynamic>> get branchIoStream {
    return FlutterBranchSdk.listSession();
  }
}
