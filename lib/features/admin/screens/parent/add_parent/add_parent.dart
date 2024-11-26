import 'package:adminpickready/common/widgets/layouts/templates/site_layout.dart';
import 'package:flutter/material.dart';

import 'responsive_screens/add_parent_desktop_screen.dart';

class AddParent extends StatelessWidget {
  const AddParent({super.key});

  @override
  Widget build(BuildContext context) {
    return const SSiteTemplate(desktop: AddParentDesktopScrenn(),);
  }
}