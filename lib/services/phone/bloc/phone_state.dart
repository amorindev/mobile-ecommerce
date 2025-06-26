part of 'phone_bloc.dart';

abstract class PhoneState extends Equatable {
  final bool isLoading;
  final String? loadingText;
  const PhoneState({
    required this.isLoading,
    this.loadingText,
  });

  @override
  List<Object?> get props => [isLoading, loadingText];
}

class PhoneStateInitial extends PhoneState {
  const PhoneStateInitial({
    required super.isLoading,
    super.loadingText,
  });
}

class PhoneStateLoaded extends PhoneState {
  // * null para mostrar loading
  // * [] para mostrar que no existe elementos
  final List<PhoneResp>? phones;
  // lascreated? ver address state ver si es necesario
  final Exception? exception;

  const PhoneStateLoaded({
    required this.phones,
    required this.exception,
    required super.isLoading,
    super.loadingText,
  });

// * de momento pondre todo
  @override
  List<Object?> get props => [
        phones,
        exception,
        isLoading,
        loadingText,
      ];
  PhoneStateLoaded copyWith({
    List<PhoneResp>? phones,
    Exception? exception,
    bool? isLoading,
    String? loadingText,
  }) {
    return PhoneStateLoaded(
      phones: phones ?? this.phones,
      exception: exception ?? this.exception,
      isLoading: isLoading ?? this.isLoading,
      loadingText: loadingText ?? this.loadingText,
    );
  }
}
