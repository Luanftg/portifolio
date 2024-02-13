import 'dart:convert';

class CourseModel {
  final String title;
  final String description;
  final String minister;
  final String institution;
  final String workload;
  final String imagePath;

  CourseModel({
    required this.title,
    required this.description,
    required this.minister,
    required this.institution,
    required this.workload,
    required this.imagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
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
