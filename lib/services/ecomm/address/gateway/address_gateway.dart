import 'package:flu_go_jwt/services/ecomm/address/core/core.dart';

abstract class AddressGateway {
  // *Agregar el Address Creado
  // * de momento solo usaremos primitivos y no una entidad
  // * ver que mas datos ahi hay varios en la entidad geo.Placemark
  // * ver que dtos se necesitan para stripe
  Future<(AddressResponse?, Exception?)> create({
    required String accessToken,
    required String label,
    required String addressLine,
    required String state,
    required String country,
    required String city,
    required String postalCode,
    required double latitude,
    required double longitude,
  });

  // ! como manejar los nombres
  // ! getAllAddresses todos sin excepcion
  // ! getAddresses todos fintrnado
  // ! da igual me parece por que si es address debe ser traer todos por el id ver
  // * completar el retorno
  Future<(List<AddressResponse>?, Exception?)> getAll({
    required String accessToken,
  });
}

// ! redicir los nombres
// !resp a solo create
// ! igual en el vlco
