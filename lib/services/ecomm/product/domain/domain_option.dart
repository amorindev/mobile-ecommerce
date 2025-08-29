class Option {
  final String name;
  final String value;

  Option({
    required this.name,
    required this.value,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        name: json["name"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "value": value,
      };
}
