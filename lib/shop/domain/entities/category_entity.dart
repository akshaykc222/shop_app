import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  CategoryEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.parentId,
    required this.position,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.priority,
    required this.moduleId,
  });

  int id;
  String name;
  String image;
  int parentId;
  int position;
  bool status;
  DateTime createdAt;
  DateTime updatedAt;
  int priority;
  int moduleId;

  @override
  List<Object?> get props => [id, name];
}
