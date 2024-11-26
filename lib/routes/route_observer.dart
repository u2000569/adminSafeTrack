import 'package:adminpickready/common/widgets/layouts/sidebars/sidebar_controller.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
/// A custom route observer for managing navigation events in the application.
class SRouteObservers extends GetObserver{
  // Called when a route is popped from the navigation stack.
  @override
  void didPop(Route<dynamic>? route, Route<dynamic>? previousRoute){
    final sidebarController = Get.put(SidebarController());

    if(previousRoute != null){
      // Check route name and update the active item in sidebar accordingly
      for( var routeName in SRoutes.sideMenuItems){
        if(previousRoute.settings.name == routeName){
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }

  @override
  void didPush(Route<dynamic>? route, Route<dynamic>? previousRoute){
    final sidebarController = Get.put(SidebarController());

    if(route != null){
      // Check route name and update the active item in sidebar accordingly
      for( var routeName in SRoutes.sideMenuItems){
        if(route.settings.name == routeName){
          sidebarController.activeItem.value = routeName;
        }
      }
    }
  }
}