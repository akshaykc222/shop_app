class SubCategoryModel {
  String name;
  String? image;
  int id;
  int categoryId;

  SubCategoryModel(
      {required this.name,
      this.image,
      required this.id,
      required this.categoryId});

  factory SubCategoryModel.fromJson(Map<String, dynamic> json) =>
      SubCategoryModel(
          name: json['name'],
          id: int.parse(json['id']),
          categoryId: int.parse(json['category_id']));

  Map<String, dynamic> toJson() =>
      {'name': name, 'image': image, 'id': id, 'categoryId': categoryId};
}
