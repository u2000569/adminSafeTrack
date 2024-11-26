import 'package:adminpickready/models/newuser.dart';
import 'package:adminpickready/screens/adminsignin.dart';
import 'package:adminpickready/screens/navrail.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<NewUserData?>(context);
    if (user == null) {
      return const AdminSignIn();
    } else {
      return const NavRail();
    }
  }
}
