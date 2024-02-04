import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:student_getx/model/db_student.dart';

class HomeController extends GetxController {
  late final Box<Student> _studentBox;

  final RxList<Student> students = <Student>[].obs;

  @override
  void onInit() {
    super.onInit();
    _studentBox = Hive.box<Student>('students');
    _loadStudents();
  }

  void _loadStudents() {
    students.assignAll(_studentBox.values.toList());

    _studentBox.watch().listen((event) {
      students.assignAll(_studentBox.values.toList());
    });
  }

  void deleteStudent(Student student) {
    _studentBox.delete(student.key);
    students.remove(student);
  }
}
