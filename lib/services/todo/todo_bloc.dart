import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc() : super(const CounterStateValid(0)) {
    on<IncrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInvalidNumber(
          previusValue: state.value,
          invalidValue: event.value,
        ));
      } else {
        print(state.value + integer);
        emit(CounterStateValid(state.value + integer));
        print(state.value);
      }
    });
    on<DecrementEvent>((event, emit) {
      event.value.toString();
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInvalidNumber(
          previusValue: state.value,
          invalidValue: event.value,
        ));
      } else {
        emit(CounterStateValid(state.value - integer));
      }
    });
  }
}
