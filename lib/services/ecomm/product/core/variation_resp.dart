// * falta crear solo Varition por qu tambien tiene el id de variacion
// * de momento no lo usamos, pero que pasa si también este modelo lo usamos 
// * para la web en donde te retorna el id de lavariacion 
// * podrias reutilizar esta misma librería
class VariationResponse {
  final String name;
  final List<String> values;

  VariationResponse({
    required this.name,
    required this.values,
  });

  factory VariationResponse.fromJson(Map<String, dynamic> json) => VariationResponse(
        name: json["name"],
        values: List<String>.from(json["values"].map((x) => x)),
      );

  /* Map<String, dynamic> toJson() => {
        "name": name,
        "values": List<dynamic>.from(values.map((x) => x)),
      }; */
}
