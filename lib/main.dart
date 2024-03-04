import 'package:assignmentapp/UI/Auth_page.dart';
import 'package:assignmentapp/UI/UserDetails.dart';
import 'package:assignmentapp/UI/AllUsers.dart';
import 'package:assignmentapp/providers/auth_provider.dart';
import 'package:assignmentapp/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      title: 'Login & Signup Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: AuthPage(),
       routes: {
          '/user_details': (context) => UserDetails(),
          '/home_page': (context) => AllUser(),
        }
    );
  }
}
