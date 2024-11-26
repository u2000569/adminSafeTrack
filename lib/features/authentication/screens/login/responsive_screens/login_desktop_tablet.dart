import 'package:adminpickready/common/widgets/layouts/templates/login_template.dart';
import 'package:flutter/material.dart';
import '../../../../../utils/logging/logger.dart';
import '../widgets/login_form.dart';
import '../widgets/login_header.dart';

class LoginScreenDesktopTablet extends StatelessWidget {
  const LoginScreenDesktopTablet({super.key});

  @override
  Widget build(BuildContext context) {
    SLoggerHelper.info('Login Template');
    return const SLoginTemplate(
      child: Column(
        children: [
          // Header
          SLoginHeader(),

          // Form
          SLoginForm(),
        ],
      ),
    );
  }
}