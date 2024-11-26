import 'package:adminpickready/bindings/general_bindings.dart';
import 'package:adminpickready/common/widgets/page_not_found/page_not_found.dart';
import 'package:adminpickready/routes/app_routes.dart';
import 'package:adminpickready/routes/route_observer.dart';
import 'package:adminpickready/routes/routes.dart';
import 'utils/theme/theme.dart';
import 'package:adminpickready/utils/constants/colors.dart';
import 'package:adminpickready/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: STexts.appName,
      themeMode: ThemeMode.light,
      theme: SAppTheme.lightTheme,
      darkTheme: SAppTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      initialBinding: GeneralBindings(),
      navigatorObservers: [SRouteObservers()],
      initialRoute: SRoutes.dashboard,
      getPages: SAppRoute.pages,
      unknownRoute: GetPage(
        name: '/page-not-found', 
        page: () => const SPageNotFound(
          isFullPage: true,
          title:'Oops! You\'ve Ventured into the Abyss of the Internet!',
          subTitle:'Looks like you’ve discovered the Bermuda Triangle of our app. Don\'t worry, we won’t let you stay lost forever. Click the button below to return to safety!',
        )
      ),
      home: const Scaffold(
        backgroundColor: SColors.primary ,
        body: Center(child: CircularProgressIndicator(color: Colors.white,),),
      ),
    );
  }
}