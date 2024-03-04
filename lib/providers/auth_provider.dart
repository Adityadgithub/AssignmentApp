import 'package:assignmentapp/UI/Auth_page.dart';
import 'package:assignmentapp/database/user.dart';
import 'package:assignmentapp/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:assignmentapp/UI/UserDetails.dart';
import 'package:assignmentapp/database/isar_services.dart';
import 'package:flutter/material.dart';
class AuthProvider extends StateNotifier<Users?> {
  AuthProvider() : super(null);

  void setCurrentUser(Users? user) {
    state = user;
    print('state changed: ${state!.email}');
  }

 Future<void> login(
      BuildContext context, String email, String password) async {
    final services = IsarServices();

    final isValidUser =
        await services.IsUserValid(email: email, password: password);
    if (isValidUser) {
      final currentUser = await services.GetCurrentUser(email: email);
      print('user logged in - ${currentUser!.email}');

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => UserDetails(
                    currentUserDetails: currentUser,
                  )));
    } else {
      print('not found');
    }
  }

  Future<void> signUp(
      BuildContext context, String email, String password) async {
    final services = IsarServices();
    services.saveUserDetail(email: email, password: password);

    final currentUser = await services.GetCurrentUser(email: email);
    print('user signed up - ${currentUser!.email}');
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => UserDetails(
                  currentUserDetails: currentUser,
                )));
  }

  // Method to simulate logout
  void logout( BuildContext context,) {
    state = null;
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => AuthPage()));

  }


}

final currentUserProvider = StateNotifierProvider<AuthProvider, Users?>((ref) {
  return AuthProvider();
});