import 'dart:convert';

SessionLocalStg sessionFromJson(String str) => SessionLocalStg.fromJson(json.decode(str));

String sessionToJson(SessionLocalStg data) => json.encode(data.toJson());



// ! ya vimos en file storage del backend donde tenemos separado esta carpera
// ! la idea es que cada dominio tenga su file storage con sus entidades
// ! no sacar otra carpeta file-storage, que pasaría con payments?


// ! estoy dejando comoopcional por el anterior modelo
// ! debes usar ! si sabes que debe venir ese valor
// * tambien agregue final y const al constructor
class SessionLocalStg {
  final String? accessToken;
  final String? refreshToken;

  const SessionLocalStg({
    required this.accessToken,
    required this.refreshToken,
  });

  factory SessionLocalStg.fromJson(Map<String, dynamic> json) => SessionLocalStg(
        accessToken: json["access_token"],
        refreshToken: json["refresh_token"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "refresh_token": refreshToken,
      };
}
// !el anterior modelo
/* 
class Session {
  // en SeureStirage produce error si noes nuleable
  final String? accessToken;
  final String? refreshToken;

  Session({required this.accessToken, required this.refreshToken});
} */
