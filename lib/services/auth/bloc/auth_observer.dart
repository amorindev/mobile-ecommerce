
import 'package:bloc/bloc.dart';

class AuthBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    /* print("----------------------------- observer");
    print('${bloc.runtimeType} $change');
    print("----------------------------- observer"); */
  }
}