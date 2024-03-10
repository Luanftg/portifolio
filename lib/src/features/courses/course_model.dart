import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class CourseModel {
  final String title;
  final String titlePath;
  final String description;
  final String minister;
  final String institution;
  final String workload;
  final String imagePath;
  final DateTime startDate;
  final DateTime endDate;

  CourseModel({
    required this.title,
    required this.titlePath,
    required this.description,
    required this.minister,
    required this.institution,
    required this.workload,
    required this.imagePath,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'title_path': titlePath,
      'description': description,
      'minister': minister,
      'institution': institution,
      'workload': workload,
      'image_path': imagePath,
    };
  }

  factory CourseModel.fromMap(Map<String, dynamic> map) {
    return CourseModel(
      title: map['title'] ?? '',
      titlePath: map['title_path'],
      description: map['description'] ?? '',
      minister: map['minister'] ?? '',
      institution: map['institution'] ?? '',
      workload: map['workload'] ?? '',
      imagePath: map['image_path'] ?? '',
      startDate: (map['start_date'] as Timestamp).toDate(),
      endDate: (map['end_date'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source));
}
