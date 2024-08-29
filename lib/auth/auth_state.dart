import 'package:eco_app/page/login_page.dart';
import 'package:eco_app/page/register_page.dart';
import 'package:flutter/widgets.dart';

class Authstate extends StatefulWidget {
  const Authstate({super.key});

  @override
  State<Authstate> createState() => _AuthstateState();
}

class _AuthstateState extends State<Authstate> {
  bool showLogin = true;

  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
