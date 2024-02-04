import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_getx/controller/home_controller.dart';
import 'package:student_getx/model/db_student.dart';
import 'package:student_getx/view/add_student.dart';
import 'package:student_getx/view/studen_details.dart';

class HomeScreen extends StatelessWidget {
  final HomeController _controller = Get.put(HomeController());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student App'),
      ),
      body: Center(
        child: Obx(() {
          if (_controller.students.isEmpty) {
            return const Center(
              child: Text('No Student data'),
            );
          } else {
            return GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: _controller.students.length,
              itemBuilder: (context, index) {
                final student = _controller.students[index];
                return GestureDetector(
                  onTap: () {
                    Get.to(() => StudentDetailsScreen(student: student));
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundImage: FileImage(File(student.imagePath)),
                          radius: 30,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          student.name,
                          style: const TextStyle(fontSize: 16),
                        ),
                        IconButton(
                            onPressed: () {
                              _delete(student);
                            },
                            icon: const Icon(Icons.delete_outline))
                      ],
                    ),
                  ),
                );
              },
            );
          }
        }),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            FloatingActionButton(
              onPressed: () {
                Get.to(() => const AddStudentScreen());
              },
              child: const Icon(Icons.add),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  void _delete(Student student) {
    Get.defaultDialog(
      title: 'Conform Deletion',
      middleText: 'Are you sure you want to delete',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      onConfirm: () {
        _controller.deleteStudent(student);
        Get.back();
      },
      onCancel: () {},
    );
  }
}
