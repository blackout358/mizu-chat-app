import 'package:flutter/material.dart';
import 'package:mizu/Screens/delete_account_page.dart';
import 'package:mizu/Screens/update_email_page.dart';
import 'package:mizu/Screens/update_password_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdateEmail(),
                  ),
                );
              },
              title: const Text("Change email"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const UpdatePassword(),
                  ),
                );
              },
              title: const Text("Change password"),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
          const Spacer(),
          Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DeleteAccount(),
                  ),
                );
              },
              title: const Text(
                "Delete account",
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
