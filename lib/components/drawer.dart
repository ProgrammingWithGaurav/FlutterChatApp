import 'package:chat_app/services/auth/auth_service.dart';
import 'package:chat_app/pages/SettingsPage.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              // Drawer Header
              Container(
                margin: EdgeInsets.only(top: 35),
                height: 200,
                padding: const EdgeInsets.only(top: 25),
                child: Center(
                  child: Column(
                    children: [
                      Icon(Icons.message,
                          size: 40,
                          color: Theme.of(context).colorScheme.primary),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                    title: const Text("H O M E"),
                    leading: Icon(Icons.home),
                    onTap: () {
                      // pop the drawer
                      Navigator.pop(context);
                    }),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                    title: const Text("S E T T I N G S"),
                    leading: Icon(Icons.settings),
                    onTap: () {
                      // pop the drawer
                      Navigator.pop(context);
                      // navigate to settings page
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage()));
                    }),
              ),
            ]),
            Padding(
                padding: const EdgeInsets.only(
                  left: 25.0,
                  bottom: 25.0,
                ),
                child: ListTile(
                  title: const Text("L O G O U T"),
                  leading: Icon(Icons.logout),
                  onTap: logout,
                ))
          ],
        ));
  }
}
