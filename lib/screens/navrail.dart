import 'package:adminpickready/screens/adminscreen.dart';
import 'package:adminpickready/screens/backupscreen.dart';
import 'package:adminpickready/screens/createuserscreen.dart';
import 'package:adminpickready/screens/olddashboardscreen.dart';
import 'package:adminpickready/screens/teacherscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NavRail extends StatefulWidget {
  const NavRail({super.key});

  @override
  State<NavRail> createState() => _NavRailState();
}

class _NavRailState extends State<NavRail> {
  int _selectedIndex = 0;
  final FirebaseAuth _authService = FirebaseAuth.instance;

  final List<Widget> _screens = [
    const AdminScreen(),
    const OldDashboardScreen(),
    const BackUp(),
    const OldTeacherScreen(),
    CreateUserScreen()
  ];

  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logout() async {
    await _authService.signOut();
    Navigator.of(context).pushReplacementNamed('/wrapper');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: NavigationRail(
                  selectedIndex: _selectedIndex,
                  onDestinationSelected: _onDestinationSelected,
                  labelType: NavigationRailLabelType.all,
                  destinations: const [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text("Dashboard"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bar_chart),
                      label: Text("Approval"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text("User"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.people),
                      label: Text("Teacher"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.people),
                      label: Text("Create User"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: const Color.fromRGBO(9, 31, 91, 1), // Button color
                  ),
                  onPressed: _logout,
                  child: const Row(
                    children:[
                       Icon(Icons.logout, color: Colors.black,),
                       Text(
                        'Log Out',
                        style: TextStyle(color: Colors.black),),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: _screens[_selectedIndex],
          ),
        ],
      ),
    );
  }
}
