import 'package:flutter/material.dart';

class GoFlutterPage extends StatefulWidget {
  const GoFlutterPage({super.key});

  @override
  State<GoFlutterPage> createState() => _GoFlutterPageState();
}

class _GoFlutterPageState extends State<GoFlutterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("goFlutterPage"),
      ),
    );
  }
}

class GoFlutterOpenPage extends StatefulWidget {
  const GoFlutterOpenPage({super.key});

  @override
  State<GoFlutterOpenPage> createState() => _GoFlutterOpenPageState();
}

class _GoFlutterOpenPageState extends State<GoFlutterOpenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("goFlutterPageOpen"),
      ),
    );
  }
}
