import 'package:flutter/material.dart';

class TabletLayout extends StatelessWidget {
  TabletLayout({super.key, this.body});

  /// Widget to be displayed as the body of the desktop layout
  final Widget? body;

  /// Key for the scaffold widget
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: const Text('Tablet Layout'),
    );
  }
}