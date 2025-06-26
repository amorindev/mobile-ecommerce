// * falta crear solo Varition por qu tambien tiene el id de option
// * de momento no lo usamos, pero que pasa si también este modelo lo usamos 
// * para la web en donde te retorna el id de lavariacion 
// * podrias reutilizar esta misma librería
// * lo mismo para variation
class OptionResponse {
  final String name;
  final String value;

  OptionResponse({
    required this.name,
    required this.value,
  });

  factory OptionResponse.fromJson(Map<String, dynamic> json) => OptionResponse(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
