part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  final bool isLoading;
  final String? loadingText;
  const StoreState({
    required this.isLoading,
    this.loadingText,
  });
  @override
  List<Object?> get props => [isLoading, loadingText];
}

class StoreStateInitial extends StoreState {
  const StoreStateInitial({
    required super.isLoading,
    super.loadingText,
  });
}

class StoresStateLoaded extends StoreState {
  final List<StoreResponse>? stores;
  final Exception? exception;

  const StoresStateLoaded({
    required this.stores,
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });

  @override
  List<Object?> get props => [
        stores,
        exception,
        isLoading,
        loadingText,
      ];
}
