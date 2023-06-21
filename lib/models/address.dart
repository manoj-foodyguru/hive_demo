import 'package:hive/hive.dart';

part 'address.g.dart';

@HiveType(typeId: 2)
class Address extends HiveObject {

  @HiveField(1)
  String? country;
}