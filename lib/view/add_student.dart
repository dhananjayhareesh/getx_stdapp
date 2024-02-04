import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:student_getx/model/db_student.dart';

class AddStudentFormController extends GetxController {
  Rx<File?> selectedImage = Rx<File?>(null);
}

class AddStudentScreen extends StatelessWidget {
  const AddStudentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: AddStudentForm(),
      ),
    );
  }
}

class AddStudentForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _classController = TextEditingController();
  final TextEditingController _guardianController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final AddStudentFormController _controller =
      Get.put(AddStudentFormController());

  AddStudentForm({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() {
              return Center(
                child: GestureDetector(
                  onTap: () => _pickImage(_controller),
                  child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.withOpacity(0.5),
                      ),
                      child: _controller.selectedImage.value != null
                          ? ClipOval(
                              child: Image.file(
                                _controller.selectedImage.value!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : const Icon(
                              Icons.add_photo_alternate,
                              size: 60,
                              color: Colors.white,
                            )),
                ),
              );
            }),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: _nameController,
              labelText: 'Name',
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter the student name';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: _classController,
                labelText: 'Class',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the class';
                  }
                  return null;
                }),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: _guardianController,
                labelText: 'Guardian',
                keyboardType: TextInputType.text,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter guardian name';
                  }
                  return null;
                }),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
                controller: _mobileController,
                labelText: 'Mobile Number',
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter the mobile number';
                  }
                  if (value.length != 10) {
                    return 'Mobile number must be 10 digits';
                  }
                  return null;
                }),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: SizedBox(
                height: 50,
                width: 100,
                child: ElevatedButton(
                  onPressed: () {
                    if (_controller.selectedImage.value == null) {
                      Get.snackbar('Error', 'Please select a photo',
                          backgroundColor: Colors.red,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM);
                    } else {
                      if (_formKey.currentState!.validate()) {
                        Student student = Student()
                          ..name = _nameController.text
                          ..className = _classController.text
                          ..guardianName = _guardianController.text
                          ..mobileNumber = _mobileController.text
                          ..imagePath = _controller.selectedImage.value!.path;
                        saveStudent(student);
                        Get.back();
                      }
                    }
                  },
                  child: const Text('Save'),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

void _pickImage(AddStudentFormController controller) async {
  final pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    controller.selectedImage.value = File(pickedImage.path);
  }
}

void saveStudent(Student student) async {
  final box = Hive.box<Student>('students');
  await box.add(student);
  print('Student details saved to Hive: $student');
  Get.snackbar('Success', 'Student detials saved Successfully',
      snackPosition: SnackPosition.BOTTOM);
}

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboardType;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.keyboardType,
    required this.validator,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey,
      ),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: labelText,
            border: InputBorder.none,
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0)),
        keyboardType: keyboardType,
        validator: validator,
      ),
    );
  }
}
