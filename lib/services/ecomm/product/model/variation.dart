class Variation {
  final String name;
  final List<String> values;

  Variation({
    required this.name,
    required this.values,
  });

  factory Variation.fromJson(Map<String, dynamic> json) => Variation(
        name: json["name"],
        values: List<String>.from(json["values"].map((x) => x)),
      );

  /* Map<String, dynamic> toJson() => {
        "name": name,
        "values": List<dynamic>.from(values.map((x) => x)),
      }; */
}
 