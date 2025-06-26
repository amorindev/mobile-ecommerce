part of 'phone_bloc.dart';

abstract class PhoneEvent extends Equatable {
  const PhoneEvent();

  @override
  List<Object> get props => [];
}

class PhoneEventReset extends PhoneEvent{}

class PhoneEventCreate extends PhoneEvent {
  final String number;
  final String countryCode;
  final String countryISOCode;
  final String accessToken;

  const PhoneEventCreate({
    required this.countryISOCode,
    required this.accessToken,
    required this.countryCode,
    required this.number,
  });
}

class PhoneEventGetAll extends PhoneEvent {
  final String accessToken;

  const PhoneEventGetAll({
    required this.accessToken,
  });
}
