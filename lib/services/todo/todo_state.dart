part of 'todo_bloc.dart';

@immutable
abstract class TodoState extends Equatable {
  final int value;
  const TodoState(this.value);

  @override
  List<Object> get props => [value];
}

class TodoInitial extends TodoState {
  const TodoInitial(super.value);
}

class CounterStateValid extends TodoState {
  const CounterStateValid(super.value);
}

class CounterStateInvalidNumber extends TodoState {
  final String invalidValue;
  //const CounterStateInvalidNumber(super.value, this.invalidValue);
  const CounterStateInvalidNumber({
    required int previusValue,
    required this.invalidValue,
  }) : super(previusValue);

  @override
  List<Object> get props => [value, invalidValue];
}
