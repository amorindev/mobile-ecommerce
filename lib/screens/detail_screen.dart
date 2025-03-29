import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.itemId});

  final String itemId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail screen"),
      ),
      body: Center(
        child: Text('Detail #$itemId'),
      ),
    );
  }
}
