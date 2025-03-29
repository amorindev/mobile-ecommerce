import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flu_go_jwt/main.dart';
import 'package:flu_go_jwt/services/branchio/events/on_cancel_suscription.dart';
import 'package:flu_go_jwt/services/branchio/service.dart';

part 'branch_io_event.dart';
part 'branch_io_state.dart';

// * me prece mejor crear session con token y refresh token
// * retornar el user al sign up y no al sign in, get user ya se encarga de ello
// * Manejar el input y output
class BranchIoBloc extends Bloc<BranchIoEvent, BranchIoState> {
  

  BranchIoBloc() : super(const BranchIoInitial()) {
    //_onSuscribe();
    on<BranchIoEvent>((event, emit) {});

    

    

    // 0 debajo
    "-----------------------test".log();
    print("-----------------------test");
    //_onSuscribe();
  }

  /* Future _onSuscribe() async {
    // desde la página de verifytoken enviarlo al backend o desde el bloc?
    //verifyEmailToken(token);
    _branchIoSuscription = _srv.branchIoStream.listen(
      (data) {
        "BranchioService -------------------------".log();
        print("BranchioService -------------------------");
        if (data.isNotEmpty) {
          data.log();
          "BranchioService -  data is not empty".log();
          // if (data != null && data.containsKey('token'))
          if (data.containsKey('token')) {
            String? token = data['token'];
            if (token != null) {
              "BranchioService -  token is not empty".log();
              token.log();
              "----------------------------------".log();
              // emite el estado
            }
          }
        } else {
          "BranchioService -  data is empty".log();
        }
      },
      onError: (error) {
        ("Branchio err $error").log();
        // ? emitir estado?
      },
    );
  } */


}
