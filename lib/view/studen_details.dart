import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_getx/model/db_student.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Student student;
  const StudentDetailsScreen({Key? key, required this.student})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Profile Picture',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            CircleAvatar(
              backgroundImage: FileImage(File(student.imagePath)),
              radius: 80,
            ),
            const SizedBox(height: 40),
            const Divider(color: Colors.grey),
            const SizedBox(height: 20),
            const Text(
              'Details',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            _buildDetailRow('Name', student.name),
            _buildDetailRow('Class', student.className),
            _buildDetailRow('Guardian', student.guardianName),
            _buildDetailRow('Mobile Number', student.mobileNumber),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '$label:',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[700]),
          ),
          Text(
            value,
            style: TextStyle(fontSize: 18, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}
