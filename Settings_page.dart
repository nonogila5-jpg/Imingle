import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: const [
          SwitchListTile(value: true, onChanged: null, title: Text("Dark Mode")),
          ListTile(title: Text("Account Settings")),
          ListTile(title: Text("Privacy")),
        ],
      ),
    );
  }
}