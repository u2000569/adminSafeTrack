import 'package:adminpickready/data/repositories/authentication/authentication_repository.dart';
import 'package:adminpickready/features/personalization/controllers/settings_controller.dart';
import 'package:adminpickready/utils/constants/enums.dart';
import 'package:adminpickready/utils/constants/image_strings.dart';
import 'package:adminpickready/utils/helpers/network_manager.dart';
import 'package:adminpickready/utils/logging/logger.dart';
import 'package:adminpickready/utils/popups/full_screen_loader.dart';
import 'package:adminpickready/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repositories/settings/setting_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/constants/text_strings.dart';
import '../../personalization/controllers/user_controller.dart';
import '../../personalization/models/setting_model.dart';
import '../../personalization/models/user_model.dart';

class LoginController extends GetxController{
  static LoginController get instance => Get.find();

  /// Whether the password should be hidden
  final hidePassword = true.obs;

  /// Whether the user has selected "Remember Me"
  final rememberMe = false.obs;

  /// Local storage instance for remembering email and password
  final localStorage = GetStorage();

  /// Text editing controller for the email field
  final email = TextEditingController();

  /// Text editing controller for the password field
  final password = TextEditingController();

  /// Form key for the login form
  final loginFormKey = GlobalKey<FormState>();

  @override
  void onInit(){
    // Retrieve stored email and password if "Remember Me" is selected
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

    /// Handles email and password sign-in process
    Future<void> emailAndPasswordSignIn() async{
      try {
        // Start Loading
        SFullScreenLoader.openLoadingDialog('Logging you in...', SImages.ridingIllustration);
        //TLoggerHelper.info('loading');

        // Check Internet Connectivity
        final isConnected = await NetworkManager.instance.isConnected();
        if(!isConnected){
          SLoggerHelper.info('connect to internet');
          SFullScreenLoader.stopLoading();
          return;
        }

        // Form validation
        if(!loginFormKey.currentState!.validate()){
          SLoggerHelper.info('form validate');
          SFullScreenLoader.stopLoading();
          return;
        }

        // Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }
           
       // Login user using Email & Password Authentication
       await AuthenticationRepository.instance.loginWithEmailAndPassword(email.text.trim(), password.text.trim());

       // User Information
      final user = await fetchUserInformation();

      // Settings Information
      await fetchSettingsInformation();

      // Remove Loader
      SFullScreenLoader.stopLoading();

      // If user is not admin, logout and return
      if(user.role != AppRole.admin){
        SLoggerHelper.info('admin login');
        await AuthenticationRepository.instance.logout();
        SLoaders.errorSnackBar(title: 'Not Authorized', message: 'Intruders');
      } else{
        // redirect
        AuthenticationRepository.instance.screenRedirect();
      }
      } catch (e) {
        SFullScreenLoader.stopLoading();
        print("Error during login: $e");
        SLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
      }
    }
  
/// Handles registration of admin user
  Future<void> registerAdmin() async {
    try {
      // Start Loading
      SFullScreenLoader.openLoadingDialog('Registering Admin Account...', SImages.defaultImage);

      // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }

      // Register user using Email & Password Authentication
      await AuthenticationRepository.instance.registerWithEmailAndPassword(STexts.adminEmail, STexts.adminPassword);

      // Create admin record in the Firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          firstName: 'App',
          lastName: 'Admin',
          email: STexts.adminEmail,
          role: AppRole.admin,
          createdAt: DateTime.now(),
        ),
      );

      // Create settings record in the Firestore
      final settingsRepository = Get.put(SettingsRepository());
      await settingsRepository.registerSettings(SettingsModel(appLogo: '', appName: 'SafeTrack'));

      // Remove Loader
      SFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  } 

Future<void> registerUser() async{
  try {
    // Loading
    SFullScreenLoader.openLoadingDialog('Register Teacher Account...', SImages.ridingIllustration);

    // Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        SFullScreenLoader.stopLoading();
        return;
      }
    
    await AuthenticationRepository.instance.registerWithEmailAndPassword('', '');

    // Create Teacher record in the Firestore
      final userRepository = Get.put(UserRepository());
      await userRepository.createUser(
        UserModel(
          id: AuthenticationRepository.instance.authUser!.uid,
          firstName: 'Teacher',
          lastName: 'Admin',
          email: '',
          role: AppRole.teacher,
          createdAt: DateTime.now(),
        ),
      );

       // Remove Loader
      SFullScreenLoader.stopLoading();

      // Redirect
      AuthenticationRepository.instance.screenRedirect();

  } catch (e) {
    SFullScreenLoader.stopLoading();
      SLoaders.errorSnackBar(title: 'Oh Snap, cannot create new user', message: e.toString());
  }
}     
      

Future<UserModel> fetchUserInformation() async {
   // Fetch user details and assign to UserController
    final controller = UserController.instance;
    UserModel user;
    if (controller.user.value.id == null || controller.user.value.id!.isEmpty) {
      user = await UserController.instance.fetchUserDetails();
    } else {
      user = controller.user.value;
    }

    return user;
}
fetchSettingsInformation() async{
  final controller = SettingsController.instance;
  if (controller.settings.value.id == null || controller.settings.value.id!.isEmpty) {
      await SettingsController.instance.fetchSettingDetails();
  }

}

}