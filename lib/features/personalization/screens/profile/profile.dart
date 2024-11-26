import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:adminpickready/features/personalization/screens/profile/responsive_screens/profile_dekstop.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(desktop: ProfileDesktopScreen(),);
  }
}