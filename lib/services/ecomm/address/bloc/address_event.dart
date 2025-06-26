part of 'address_bloc.dart';

abstract class AddressEvent extends Equatable {
  const AddressEvent();

  @override
  List<Object> get props => [];
}

class AddressEventReset extends AddressEvent{}

class AddressEventCreate extends AddressEvent {
  // cuando usemos gogle maps sera un objeto
  // y ya no primitivos
  // userID desde el token
  final String accessToken;
  final String label;
  final String addressLine;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final double latitude;
  final double longitude;

  const AddressEventCreate({
    required this.city,
    required this.state,
    required this.country,
    required this.accessToken,
    required this.label,
    required this.addressLine,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
  });
}

class AddressEventGetAll extends AddressEvent {
  final String accessToken;

  const AddressEventGetAll({
    required this.accessToken,
  });
}
