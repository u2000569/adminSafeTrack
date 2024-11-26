import 'package:adminpickready/data/repositories/authentication/authentication_repository.dart';
import 'package:adminpickready/routes/routes.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SRouteMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route){
    return AuthenticationRepository.instance.isAuthencticated ? null : const RouteSettings(name: SRoutes.login);
  }
}