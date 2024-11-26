
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:url_launcher/link.dart';
import 'package:flutter/material.dart';

import '../sidebar_controller.dart';

class SMenuItem extends StatelessWidget {
  const SMenuItem({
    super.key, 
    required this.route, 
    required this.icon, 
    required this.itemName
  });

  final String route;
  final IconData icon;
  final String itemName;

  @override
  Widget build(BuildContext context) {
    final menuController = Get.put(SidebarController());
    return Link(
      uri: route != 'logout' ? Uri.parse(route) : null,
      builder: (_, __) => InkWell(
        onTap: () => menuController.menuOnTap(route),
        onHover: (value) => value ? menuController.changeHoverItem(route) : menuController.changeHoverItem(''),
        child: Obx((){
          // Decoration Box
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: SSizes.xs),
            child: Container(
              decoration: BoxDecoration(
                color: menuController.isHovering(route) || menuController.isActive(route)
                ? SColors.primary
                : Colors.transparent,
                borderRadius: BorderRadius.circular(SSizes.cardRadiusMd)
              ),

              // Icon and Text Row
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Icon
                  Padding(padding: const EdgeInsets.only(left: SSizes.lg, top: SSizes.md, bottom: SSizes.md, right: SSizes.md),
                  child: menuController.isActive(route)
                  ? Icon(icon, size: 22, color: SColors.white)
                  : Icon(icon, size: 22, color: menuController.isHovering(route) ? SColors.white : SColors.darkGrey,),
                  ),
                  // Text
                  if (menuController.isHovering(route) || menuController.isActive(route))
                  Flexible(
                      child: Text(itemName, style: Theme.of(context).textTheme.bodyMedium!.apply(color: SColors.white)),
                    )
                  else
                    Flexible(
                      child: Text(itemName, style: Theme.of(context).textTheme.bodyMedium!.apply(color: SColors.darkGrey)),
                    ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}