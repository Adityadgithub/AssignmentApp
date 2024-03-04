import 'package:isar/isar.dart';

part 'user.g.dart';

@Collection()
 class Users {
  Id id = Isar.autoIncrement;
  late String email;
  late String password;
 }