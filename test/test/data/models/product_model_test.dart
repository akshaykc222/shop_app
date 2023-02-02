import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/shop/data/models/category_id.dart';
import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/data/models/product_model.dart';

import '../../presentation/fixture/fixture_reader/fixture_reader.dart';

void main() {
  final productModel = ProductModel(
      id: 1,
      name: '',
      description: '',
      image: '',
      categoryIds: CategoryId(
          category: CategoryModel(
              id: '',
              name: '',
              image: '',
              parentId: 1,
              position: 1,
              status: true,
              createdAt: DateTime.parse("2022-11-24T00:00:57.000000Z"),
              updatedAt: DateTime.parse("2022-11-24T00:00:57.000000Z"),
              priority: 1,
              moduleId: 1,
              productCount: 1),
          subCategory: CategoryModel(
              id: '1',
              name: '',
              image: '',
              parentId: 1,
              position: 1,
              status: true,
              createdAt: DateTime.parse("2022-11-24T00:00:57.000000Z"),
              updatedAt: DateTime.parse("2022-11-24T00:00:57.000000Z"),
              priority: 1,
              moduleId: 1,
              productCount: 1)),
      variations: [],
      addOns: [],
      attributes: [],
      choiceOptions: [],
      images: [],
      tags: []);

  group('fromJson', () {
    test('should return a valid json ', () async {
      final Map<String, dynamic> jsonMap =
          jsonDecode(fixture('product_json.json'));
      var result = ProductModel.fromJson(jsonMap);

      expect(result, productModel);
    });
  });
}
