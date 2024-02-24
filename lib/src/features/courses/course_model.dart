import 'dart:convert';

class CourseModel {
  final String title;
  final String titlePath;
  final String description;
  final String minister;
  final String institution;
  final String workload;
  final String imagePath;

  CourseModel({
    required this.title,
    required this.titlePath,
    required this.description,
    required this.minister,
    required this.institution,
    required this.workload,
    required this.imagePath,
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
    );
  }

  String toJson() => json.encode(toMap());

  factory CourseModel.fromJson(String source) =>
      CourseModel.fromMap(json.decode(source));
}
