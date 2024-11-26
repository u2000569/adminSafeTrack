import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/forget_password_desktop.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(useLayout: false, desktop: ForgetPasswordScreenDesktop(),);
  }
}