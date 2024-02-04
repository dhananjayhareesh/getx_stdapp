import 'package:hive/hive.dart';
part 'db_student.g.dart';

@HiveType(typeId: 0)
class Student extends HiveObject {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late String className;

  @HiveField(2)
  late String guardianName;

  @HiveField(3)
  late String mobileNumber;

  @HiveField(4)
  late String imagePath;
}
