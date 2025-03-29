part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent extends Equatable {
  final String value;
  const TodoEvent(this.value);

  @override
  List<Object> get props => [value];
}

class IncrementEvent extends TodoEvent {
  const IncrementEvent(super.value);
}

class DecrementEvent extends TodoEvent {
  const DecrementEvent(super.value);
}
