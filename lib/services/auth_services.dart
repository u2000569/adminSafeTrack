import 'package:adminpickready/models/newuser.dart';
import 'package:adminpickready/services/database_services.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adminpickready/screens/navrail.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  TextEditingController adminPassword = TextEditingController();
  TextEditingController adminEmail = TextEditingController();


  Future signInWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      User user = result.user!;

      // Fetch user data from Firestore
      DocumentSnapshot userDoc =
          await _firestore.collection('Admin').doc('adminLogin').get();

      if (userDoc.exists && userDoc['role'] == 'admin') {
        _logger.i('Login Success in auth service');

        // Navigate to NavRail screen after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const NavRail(),
          ),
        );
        return [0, 'Logged in successfully'];
      } else {
        await _auth.signOut();
        _logger.i('Account not admin');
        return [1, 'Your account is not admin.'];
      }
    } catch (e) {
      return [1, e.toString()];
    }
  }

  void adminLogin(context) async {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
    try {
      final docSnapshot =
          await FirebaseFirestore.instance.collection("Admin").doc("adminLogin").get();
      if (docSnapshot.exists) {
        final data = docSnapshot.data()!;
        _logger.i("Document snapshot exists. Checking credentials.");
        if (data['adminEmail'] == adminEmail.text.trim() &&
            data['adminPassword'] == adminPassword.text.trim()) {
          _logger.i("Admin login successful for email: ${adminEmail.text}");
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const NavRail(),
            ),
            (route) => false,
          );
        } else {
          _logger.w("Invalid email or password");
          _showErrorDialog(context, 'Invalid email or password');
        }
      } else {
        _showErrorDialog(context, 'Admin credentials not found');
      }
    } catch (e) {
      _showErrorDialog(context, 'An error occurred: $e');
    } finally {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (Navigator.canPop(context)) {
          Navigator.of(context).pop(); // Close the loading dialog
        }
      });
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Error Message"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void signOut() async {
    await _auth.signOut();
  }

  Future<NewUserData?> _newUserDataFromFirebaseUser(User? user) async {
    var snap = await DatabaseService().getNewUserDataSnapshot(user);
    return snap == null
        ? null
        : NewUserData.fromMap(snap.data() as Map<String, dynamic>);
  }

  Stream<NewUserData?> get newUserData {
    return _auth.authStateChanges().asyncMap(_newUserDataFromFirebaseUser);
  }
}
