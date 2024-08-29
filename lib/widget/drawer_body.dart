import 'package:eco_app/auth/auth_provider.dart';
import 'package:eco_app/models/user.dart';
import 'package:eco_app/page/cart_page.dart';
import 'package:eco_app/page/home_page.dart';
import 'package:eco_app/page/order_page.dart';
import 'package:eco_app/page/settings_page.dart';
import 'package:eco_app/services/auth_services.dart';
import 'package:eco_app/widget/drawer_tile.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerBody extends StatefulWidget {
  const DrawerBody({
    super.key,
  });

  @override
  State<DrawerBody> createState() => _DrawerBodyState();
}

class _DrawerBodyState extends State<DrawerBody> {
  late final database = Provider.of<UserProvider>(context, listen: false);
  UserProfile? user;
  String currentId = LoginServices().getCurrentId();
  bool _isLoad = true;
  @override
  void initState() {
    super.initState();
    loadUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> loadUser() async {
    try {
      setState(() {
        _isLoad = true;
      });
      user = await database.userProfile(currentId);
    } finally {
      setState(() {
        _isLoad = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = LoginServices();
    void logout() async {
      await authService.logoutUser();
    }

    return Drawer(
        child: Column(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * .3,
          width: MediaQuery.of(context).size.width,
          color: const Color(0xFF212121),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                    radius: 50,
                    backgroundImage: _isLoad
                        ? null
                        : user?.image != null
                            ? NetworkImage(user!.image)
                            : null),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  _isLoad
                      ? ''
                      : user != null
                          ? user!.username
                          : '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                Text(
                    _isLoad
                        ? ''
                        : user != null
                            ? user!.email
                            : '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    )),
              ],
            ),
          ),
        ),
        Expanded(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  DrawerTitle(
                    title: 'Home',
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ));
                    },
                    icon: Icons.home,
                  ),
                  DrawerTitle(
                      title: 'Cart',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CartPage(),
                            ));
                      },
                      icon: Icons.shopping_cart_outlined),
                  DrawerTitle(
                      title: 'Orders',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderPage(),
                            ));
                      },
                      icon: Icons.playlist_add_check_outlined),
                  DrawerTitle(
                      title: 'Settings',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SettingsPage(),
                            ));
                      },
                      icon: Icons.settings),
                  const Spacer(),
                  DrawerTitle(
                      title: 'Logout', onTap: logout, icon: Icons.logout),
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
