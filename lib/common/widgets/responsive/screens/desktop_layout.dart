import 'package:adminpickready/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:flutter/material.dart';

import '../../layouts/headers/header.dart';

class DesktopLayout extends StatelessWidget {
  DesktopLayout({super.key, this.body});

  /// Widget to be displayed as the body of the desktop layout
  final Widget? body;

  /// Key for the scaffold widget
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Row(
        children: [
          const Expanded(child: SSidebar()),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                SHeader(scaffoldKey: scaffoldKey),
                Expanded(child: body ?? Container()),
              ],
            ))
        ],
      ),
    );
  }
}