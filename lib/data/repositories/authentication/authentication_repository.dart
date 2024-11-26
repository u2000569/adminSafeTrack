import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../routes/routes.dart';
import '../../../utils/exceptions/firebase_auth_exceptions.dart';
import '../../../utils/exceptions/firebase_exceptions.dart';
import '../../../utils/exceptions/format_exceptions.dart';
import '../../../utils/exceptions/platform_exceptions.dart';
import '../../../utils/logging/logger.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  //Variables
  final _auth = FirebaseAuth.instance;

  // Get Authenticated User Data
  User? get authUser => _auth.currentUser;

  // Get IsAuthencticated User
  bool get isAuthencticated => _auth.currentUser !=null;

  // Called from main.dart on app launch
  @override
  void onReady(){
    _auth.setPersistence(Persistence.LOCAL);
    screenRedirect();
  }

  // Function to determine the relevant screen and redirect accordingly.
  void screenRedirect() async {
    final user = _auth.currentUser;

    // If the user is logged in
    if (user != null) {
      // Navigate to the Home
      Get.offAllNamed(SRoutes.dashboard);
      SLoggerHelper.info('User Log In');
    } else {
      Get.offAllNamed(SRoutes.login);
      SLoggerHelper.info('No User Log In');
    }
  }

  // Email & Password sign-in

  // LOGIN
Future<UserCredential> loginWithEmailAndPassword(String email, String password) async {
  try {
    return await _auth.signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    SLoggerHelper.error('FirebaseAuthException: ${e.code} - ${e.message}');
    throw SFirebaseAuthException(e.code).message;
  } on FirebaseException catch (e) {
    SLoggerHelper.error('FirebaseException: ${e.code} - ${e.message}');
    throw SFirebaseException(e.code).message;
  } on FormatException catch (_) {
    SLoggerHelper.error('FormatException caught');
    throw const SFormatException();
  } on PlatformException catch (e) {
    SLoggerHelper.error('PlatformException: ${e.code} - ${e.message}');
    throw SPlatformException(e.code).message;
  } catch (e) {
    SLoggerHelper.error('Unknown error during login: $e');
    throw 'Something went wrong. Please try again';
  }
}


  // REGISTER
  Future<UserCredential> registerWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      throw const SFormatException();
    } on PlatformException catch (e) {
      throw SPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again';
    }
  }

  // Logout User
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(SRoutes.login);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) print(e);
      throw SFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      if (kDebugMode) print(e);
      throw SFirebaseException(e.code).message;
    } on FormatException catch (_) {
      if (kDebugMode) print('Format Exception Caught');
      throw const SFormatException();
    } on PlatformException catch (e) {
      if (kDebugMode) print(e);
      throw SPlatformException(e.code).message;
    } catch (e) {
      if (kDebugMode) print(e);
      throw 'Something went wrong. Please try again';
    }
  }
  
}