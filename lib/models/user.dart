import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 1)
class User extends HiveObject {

  @HiveField(0)
  late int id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  int? age;
}