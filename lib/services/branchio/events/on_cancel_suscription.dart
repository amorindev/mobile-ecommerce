import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flu_go_jwt/services/branchio/bloc/branch_io_bloc.dart';

Future onCancelSuscription(
  BranchIoEventCancellAllSuscriptions event,
  Emitter<BranchIoState> emit,
  StreamSubscription<Map<dynamic, dynamic>> branchIoSuscription,
) async {
  await branchIoSuscription.cancel();
  //branchIoSuscription = null;
  //emit(BranchIoStateCancelledSuscription)
}
