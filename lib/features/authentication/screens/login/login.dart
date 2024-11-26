import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/login_desktop_tablet.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(useLayout:false, desktop: LoginScreenDesktopTablet(),);
  }
}