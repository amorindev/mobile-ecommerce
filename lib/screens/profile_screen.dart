import 'package:flu_go_jwt/services/auth/bloc/auth_bloc.dart';
import 'package:flu_go_jwt/services/auth/provider/provider.dart';
import 'package:flu_go_jwt/services/branchio/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    //final authProvider = Provider.of<AuthProvider>(context);
    //final branchIoProvider =
      //  Provider.of<BranchIoProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
        children: const [
          /* authProvider.session != null
              ? Column(
                  children: [
                    Text(authProvider.session!.accessToken),
                    Text(authProvider.session!.refreshToken),
                    Text(authProvider.session!.user.id),
                    Text(authProvider.session!.user.email)
                    // * Falta roles
                  ],
                )
              : const Text("session null"),
          branchIoProvider.deepLinkData != null
              ? Column(
                  children: [
                    Text(branchIoProvider.deepLinkData.toString()),
                    Text(branchIoProvider.deepLinkData!['token'])
                  ],
                )
              : const Text("is nullllllll") */
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<AuthBloc>().add(const AuthEventSignOut());
        },
        child: const Text('sign out'),
      ),
    );
  }
}
