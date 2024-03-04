import 'dart:developer';
import 'package:assignmentapp/UI/AllUsers.dart';
import 'package:assignmentapp/database/isar_services.dart';
import 'package:assignmentapp/providers/auth_provider.dart';
import 'package:assignmentapp/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserDetails extends ConsumerWidget {
  var currentUserDetails;
  UserDetails({this.currentUserDetails});

  var services = IsarServices();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var currentUser = ref.watch(currentUserProvider);
    print('Id : ${currentUser}');
    return  SafeArea(
          child: Scaffold(
        appBar: AppBar(actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllUser()));
              },
              icon: Icon(Icons.person))
        ]),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Id : ${currentUserDetails!.id}',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Text(
                  'User Email : ${currentUserDetails!.email}',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
                Text(
                  'User Password : ${currentUserDetails!.password}',
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),

                  Padding(
  padding: const EdgeInsets.only(top: 40.0),
  child: ElevatedButton(
    onPressed: () {
      final authprovider = AuthProvider();
      authprovider.logout(context);
    },
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue), 
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.all(16)), 
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8), 
        ),
      ),
    ),
    child: Text('LOGOUT'),
  ),
),

              ]),

             
        ),
      ));
    }
  }

