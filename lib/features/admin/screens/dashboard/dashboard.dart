import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:adminpickready/features/admin/screens/dashboard/responsive_screens/dashboard_desktop.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(
      desktop: DashboardDesktopScreen() ,
    );
  }
}