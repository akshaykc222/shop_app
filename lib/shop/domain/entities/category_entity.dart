import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  CategoryEntity(
      {required this.id,
      required this.name,
      required this.image,
      required this.productCount,
      this.enable});

  String? id;
  String? name;
  String image;
  bool? enable;
  int? productCount;

  @override
  List<Object?> get props => [id, name];
}
