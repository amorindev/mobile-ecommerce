import 'package:flu_go_jwt/services/branchio/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/* class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final branchIoProvider = Provider.of<BranchIoProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            branchIoProvider.deepLinkData != null
                ? Column(
                    children: [
                      Text(branchIoProvider.deepLinkData.toString()),
                      Text(branchIoProvider.deepLinkData!['token'])
                    ],
                  )
                : const Text("is nullllllll")
          ],
        ),
      ),
    );
  }
} */

class EmailVerificationScreen extends StatelessWidget {
  const EmailVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Center(
          child: Text("llegamossssssssssssssssssss"),
        ),
      ),
    );
  }
}

/*
void verifyEmailToken(String token) async {
    final url = Uri.parse('http');
    final response = await http.post(url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'token': token}));

    if (response.statusCode == 200) {
      _showDialog("Exito", "Correo verificado");
    } else {
      _showDialog("Error", "token inválido o ha expirado");
    }
  }
 */
