import 'dart:math';

import 'package:flu_go_jwt/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flu_go_jwt/services/auth/constants/constants.dart';
import 'package:flu_go_jwt/services/auth/models/model.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

class Practice2Screen extends StatefulWidget {
  const Practice2Screen({super.key});

  @override
  State<Practice2Screen> createState() => _Practice2ScreenState();
}

class _Practice2ScreenState extends State<Practice2Screen> {
  late final Box _myBox;
  late final Box<Session> _myAuthBox;

  late final _textController;

  late Session session;

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box("credentials");
    _myAuthBox = Hive.box(AppConstants.authHiveKey);
    _textController = TextEditingController();
    // load data, if none exists then default to empty list
    /* final accessToken = _myBox.get("acccess_token") ?? "access-token-null";
    final refreshToken = _myBox.get("refresh_token") ?? "refresh-token-null";
    session = Session(
      provider: "provider-test",
      accessToken: accessToken,
      refreshToken: refreshToken,
      user: User(
        id: "id",
        email: "email",
        emailVerified: false,
        roles: [],
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ); */
  }

  @override
  void dispose() {
    //Hive.box(AppConstants.credentials).close();
    //Hive.box(AppConstants.authHiveKey).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //     final products = Hive.box<Product>(productBox).values;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Learn Hive"),
      ),
      body: ValueListenableBuilder<Box<Session>>(
        // * cual es ladiferencia entre Box<Session> y solo session en hive.box<>

        valueListenable:
            Hive.box<Session>(AppConstants.authHiveKey).listenable(),
        builder: (BuildContext context, Box<Session> value, child) {
          final sessions = value.values.toList();
          if (sessions.isEmpty) {
            return const Center(
              child: Text("Hive is empty"),
            );
          }
          return ListView.builder(
            itemCount: sessions.length,
            itemBuilder: (context, index) {
              final session = sessions.toList()[index];
              return Column(
                children: [
                  ShowSession(session: session)
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final random = Random();
          final number = random.nextInt(100);
          _myAuthBox.put(
            number,
            Session(
              provider: "password",
              accessToken: "access-token",
              refreshToken: "refresh-token",
              user: User(
                id: "id",
                email: "fernan@gmil.com",
                emailVerified: false,
                roles: [],
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
            ),
          );
        },
      ),
      /* body: Column(
        children: [
          /* Text(''),
          TextButton(
            onPressed: () {
              print(session.toJson());
            },
            child: const Text("get tokesn"),
          ),
          TextButton(
            onPressed: () {
              _myBox.put("access-token", "access-token-123456");
              _myBox.put("refresh-token", "refresh-token-123456");
            },
            child: const Text("Assign tokens"),
          ),
          TextButton(
            onPressed: () {
              print("Access Token ${_myBox.get("access-token")}");
              print("Refresh Token ${_myBox.get("refresh-token")}");
            },
            child: const Text("Print tokems"),
          ),
          TextButton(
            onPressed: () {
              print(_myBox.values);
            },
            child: const Text("print data"),
          ),
          TextButton(
            onPressed: () {
              _myBox.delete("access_token");
              _myBox.delete("refresh-token");
            },
            child: const Text("Remove tokems"),
          ), */
          /* TextButton(
            onPressed: () {
              _myAuthBox.delete("access_token");
              _myAuthBox.delete("refresh-token");
            },
            child: const Text("Remove tokems"),
          ), */
          
        ],
      ), */
    );
  }
}
