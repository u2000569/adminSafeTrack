import 'package:adminpickready/common/widgets/layouts/templates/login_template.dart';
import 'package:adminpickready/features/authentication/screens/forget_password/widgets/forget_password_form.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreenDesktop extends StatelessWidget {
  const ForgetPasswordScreenDesktop({super.key});

  @override
  Widget build(BuildContext context) {
    return const SLoginTemplate(child: ForgetPasswordForm(),);
  }
}