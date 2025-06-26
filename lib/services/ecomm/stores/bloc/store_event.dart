part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object> get props => [];
}

class StoreEventReset extends StoreEvent {}

class StoreEventGetAll extends StoreEvent {
  final String accessToken;

  const StoreEventGetAll({
    required this.accessToken,
  });
}
