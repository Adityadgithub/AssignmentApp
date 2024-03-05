import 'package:assignmentapp/database/isar_services.dart';
import 'package:assignmentapp/database/user.dart';
import 'package:flutter/material.dart';

class AllUser extends StatefulWidget {
  AllUser({currentUser});
  @override
  State<AllUser> createState() => _AllUserState();
}

class _AllUserState extends State<AllUser> {
  final users = IsarServices();
  var _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = users.GetAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    
    return  SafeArea(
        child: Scaffold(
          appBar: AppBar(title: Text('All Users')),
          body: FutureBuilder<List<Users>>(
            future: _usersFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<Users>? users = snapshot.data;
                return ListView.builder(
                  itemCount: users!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(users[index].email),
                      subtitle: Text(users[index].password),
                      // Add more user details to display as needed
                    );
                  },
                );
              }
            },
          ),
        ),
    
    );
  }
}
