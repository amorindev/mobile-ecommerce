/* import 'package:equatable/equatable.dart'; */

/* class User extends Equatable {
  final String id;
  final String email;
  final bool emailVerified;
  final List<String> roles;
  final DateTime createdAt;
  final DateTime updatedAt;

  const User({
    required this.id,
    required this.email,
    required this.emailVerified,
    required this.roles,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        email: json["email"],
        emailVerified: json["email_verified"],
        roles: List<String>.from(json["roles"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "email_verified": emailVerified,
        "roles": List<dynamic>.from(roles.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };

  @override
  List<Object?> get props => [
        id,
        email,
        emailVerified,
        roles,
        createdAt,
        updatedAt,
      ];
} */