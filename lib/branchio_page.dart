/* import 'package:flu_go_jwt/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_branch_sdk/flutter_branch_sdk.dart';

class BrancIoPage extends StatefulWidget {
  const BrancIoPage({super.key});

  @override
  State<BrancIoPage> createState() => _BrancIoPageState();
}

class _BrancIoPageState extends State<BrancIoPage> {
  @override
  void initState() {
    super.initState();
    listenDeepLinks();
  }

  void listenDeepLinks() {
    FlutterBranchSdk.listSession().listen((data) {
      "--------------------------------".log();
      data.toString().log();
      "--------------------------------".log();

      if (data.containsKey("+clicked_branch_link") &&
          data["+clicked_branch_link"] == true) {
        String? deepLinkUrl = data["~referring_link"];
        print("Deep Link URL: $deepLinkUrl");
        // Aquí puedes navegar a una pantalla específica con los datos del deep link
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Branch Io page"),
      ),
    );
  }
}
 */