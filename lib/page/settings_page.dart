import 'package:eco_app/themes/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back_ios_new)),
        title: const Text('Settins Page'),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('Dark Mode'),
            CupertinoSwitch(
              value: Provider.of<ThemeProvider>(context,listen: false).isDarkMode,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context,listen: false).toogleTheme();
              },
            ),
          ],
        ),
      ),
    );
  }
}
