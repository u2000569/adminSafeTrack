import 'package:adminpickready/app.dart';
import 'package:adminpickready/firebase_options.dart';
import 'package:adminpickready/screens/adminscreen.dart';
import 'package:adminpickready/screens/wrapper.dart';
import 'package:adminpickready/utils/logging/logger.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_strategy/url_strategy.dart';
import 'data/repositories/authentication/authentication_repository.dart';
//old import
// import 'services/auth_services.dart';
// import 'package:adminpickready/models/newuser.dart';
// import 'package:provider/provider.dart';
// import 'package:adminpickready/services/userpreference.dart';
// import 'package:adminpickready/screens/bulkUpload.dart';
// import 'package:adminpickready/screens/excel.dart';

/// Entry point of Flutter App
Future<void> main() async {
  
  // Ensure that widgets are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetX Local Storage
  await GetStorage.init();

  // Remove # sign from url
  setPathUrlStrategy();

  // Initialize Firebase & Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  // Main App Starts here...
  runApp(const App());
  SLoggerHelper.info('runnn app');
}

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     await Firebase.initializeApp(
//       options: DefaultFirebaseOptions.currentPlatform,
//     );
//     await UserPreference.init();
//   } catch (e) {
//     print("Initialization error: $e");
//   }
//   runApp(
//     MultiProvider(
//       providers: [
//         StreamProvider<NewUserData?>.value(
//           value: AuthService().newUserData,
//           initialData: null,
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin SafeTracker',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor:const Color.fromRGBO(9, 31, 91, 1)),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false ,
      home: const Wrapper(),
      routes: {
        "/admin": (context) => const AdminScreen(),
        "/wrapper": (context) => const Wrapper(),
      },
    );
  }
}
