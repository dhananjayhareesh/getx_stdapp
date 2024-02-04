import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/controller/home_controller.dart';
import 'package:student_getx/model/db_student.dart';
import 'package:student_getx/view/homescreen.dart';

class EditStudentScreen extends StatelessWidget {
  final Student student;
  final HomeController _controller = Get.find<HomeController>();
  EditStudentScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController =
        TextEditingController(text: student.name);
    TextEditingController classController =
        TextEditingController(text: student.className);
    TextEditingController guardianController =
        TextEditingController(text: student.guardianName);
    TextEditingController mobileController =
        TextEditingController(text: student.mobileNumber);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Student'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: classController,
              decoration: const InputDecoration(labelText: 'Class'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: guardianController,
              decoration: const InputDecoration(labelText: 'Guardian'),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              controller: mobileController,
              decoration: const InputDecoration(labelText: 'Mobile Number'),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  _controller.updateStudent(
                      student,
                      nameController.text,
                      classController.text,
                      guardianController.text,
                      mobileController.text);
                  Get.snackbar(
                    'Success',
                    'Student details updated',
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                    snackPosition: SnackPosition.BOTTOM,
                  );
                  Get.to(() => HomeScreen());
                },
                child: const Text('Update'))
          ],
        ),
      ),
    );
  }
}
