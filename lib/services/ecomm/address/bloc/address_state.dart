part of 'address_bloc.dart';

abstract class AddressState extends Equatable {
  final bool isLoading;
  final String? loadingText;
  const AddressState({
    required this.isLoading,
    this.loadingText,
  });

  @override
  List<Object?> get props => [isLoading, loadingText];
}

class AddressStateInitial extends AddressState {
  const AddressStateInitial({
    required super.isLoading,
    super.loadingText,
  });
}

/* class AddressStateCreate extends AddressState {
  final AddressResponse? address;
  final Exception? exception;
  const AddressStateCreate({
    required this.address,
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });
  @override
  List<Object?> get props => [
        address,
        exception,
        isLoading,
        loadingText,
      ];
} */

/*
class AddressStateGetAll extends AddressState {
  final List<AddressResponse>? addresses;
  final Exception? exception;
  const AddressStateGetAll({
    required this.addresses,
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });
  @override
  List<Object?> get props => [
        addresses,
        exception,
        isLoading,
        loadingText,
      ];
} */

class AddressStateLoaded extends AddressState {
  // se puede manejar sin nulos en las listas pero como en todos estoy trabajando con eso lo voy a dejar como nulo pero igual desde la ui verificar que no sea null o []
  // ver cuando usar ! para este estado
  final List<AddressResponse>? addresses;
  final AddressResponse? lastCreated;
  final Exception? exception;
  final bool? isSuccess;

  const AddressStateLoaded({
    required this.addresses,
    required this.lastCreated,
    required this.exception,
    required super.isLoading,
    required this.isSuccess,
    super.loadingText,
  });
  @override
  List<Object?> get props => [
        addresses,
        lastCreated,
        exception,
        isLoading,
      ];
  AddressStateLoaded copyWith({
    List<AddressResponse>? addresses,
    AddressResponse? lastCreated,
    Exception? exception,
    bool? isLoading,
    String? loadingText,
    bool? isSuccess,
  }) {
    return AddressStateLoaded(
      addresses: addresses ?? this.addresses,
      lastCreated: lastCreated ?? this.lastCreated,
      exception: exception ?? this.exception,
      isLoading: isLoading ?? this.isLoading,
      loadingText: loadingText ?? this.loadingText,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}

// ! ver por que usamos copiwith por si cambia un atrivuto de la entidad no se refrescara podiaris poner props dentro de la entidad o  usar copy with para crear una neuva instancia y refresque el estado
