import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:adminpickready/screens/adminscreen.dart';
import 'package:adminpickready/screens/backupscreen.dart';
import 'package:adminpickready/screens/createuserscreen.dart';
import 'package:adminpickready/services/auth_services.dart';

class TestNavRail extends StatefulWidget {
  const TestNavRail({super.key});

  @override
  State<TestNavRail> createState() => _TestNavRailState();
}

class _TestNavRailState extends State<TestNavRail> {
  int _selectedIndex = 0;
  final FirebaseAuth _authService = FirebaseAuth.instance;

  final List<Widget> _screens = [
    const AdminScreen(),
     CreateUserScreen(),
    const BackUp(),
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
                      label: Text("Home"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.bar_chart),
                      label: Text("Report"),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.person),
                      label: Text("User"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromRGBO(9, 31, 91, 1), // Button color
                  ),
                  onPressed: _logout,
                  child: const Text('Log Out'),
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
