import 'package:assignmentapp/database/user.dart';
import 'package:assignmentapp/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';


class IsarServices {
  late Future<Isar> db;
  Users? currentUserTest;
  IsarServices() {
    db = openDB();
  }

  Future<void> saveUserDetail({email, password}) async {
    final isar = await db;
    isar.writeTxnSync<int>(() {
      var newUser = Users();
      newUser.email = email;
      newUser.password = password;
      print('added user');
      return isar.users.putSync(newUser);
    });
  }

  Future<bool> IsUserValid({email, password}) async {
    final isar = await db;
    final user =
        await isar.users.where().filter().emailEqualTo(email).findFirst();

    if (user != null && user.password == password) {
      return true;
    } else
      return false;
  }

  Future<List<Users>> GetAllUsers() async {
    final isar = await db;
    return await isar.users.where().findAll();
  }

  Future<Users?> GetCurrentUser({required String email}) async {
    final isar = await db;
    final currentUser =
        await isar.users.where().filter().emailEqualTo(email).findFirst();
    currentUserTest = currentUser;
    print('currentuserdefined: ${currentUserTest!.email}');
    final AuthProvider =
        ProviderContainer().read(currentUserProvider.notifier);
     AuthProvider.setCurrentUser(currentUser);

     return currentUser;
  }

  Future<Isar> openDB() async {
    final dir = await getApplicationDocumentsDirectory();
    if (Isar.instanceNames.isEmpty) {
      return await Isar.open([UsersSchema],
          inspector: true, directory: dir.path);
    }
    return Future.value(Isar.getInstance());
  }
}
