import 'package:flu_go_jwt/services/auth/models/model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
      ),
      body: const Column(
        children: [
           Text("Session"),
          /* authProvider.session != null
              ? ShowSession(session: authProvider.session!)
              : const Text("session is null"), */
          /* ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () => context.go('/details/$index'),
                title: Text('Item #$index'),
              );
            },
            separatorBuilder: (_, __) {
              return const Divider(
                height: 0.5,
                color: Colors.grey,
              );
            },
            itemCount: 15,
          ) */
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/branchio');
        },
        child: const Icon(Icons.next_plan),
      ),
    );
  }
}

class ShowSession extends StatelessWidget {
  final Session session;
  const ShowSession({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(session.accessToken),
        Text(session.refreshToken),
        Text(session.provider),
        Text(session.user.id),
        Text(session.user.email),
        Text(session.user.emailVerified.toString()),
        Text(session.user.createdAt.toString()),
        Text(session.user.updatedAt.toString()),
      ],
    );
  }
}
