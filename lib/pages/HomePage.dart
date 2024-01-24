import 'package:chat_app/auth/auth_service.dart';
import 'package:chat_app/components/drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Theme.of(context).colorScheme.tertiary),
        title: Text('Home',
            style: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
        backgroundColor: Theme.of(context).colorScheme.primary,
        actions: [
          // logout button
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
            color: Theme.of(context).colorScheme.tertiary,
          )
        ],
      ),
      drawer: MyDrawer(),
    );
  }
}
