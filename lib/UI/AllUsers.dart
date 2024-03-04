import 'package:assignmentapp/UI/UserDetails.dart';
import 'package:assignmentapp/database/isar_services.dart';
import 'package:assignmentapp/database/user.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
    final HttpLink httpLink =
        HttpLink('https://inspect.isar.dev/3.1.0+1/#/60358/H51Ty3stzOI');
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
        GraphQLClient(link: httpLink, cache: GraphQLCache()));
    return GraphQLProvider(
      client: client,
      child: SafeArea(
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
      ),
    );
  }
}
