import 'package:flutter_test/flutter_test.dart';
import 'package:shop_app/shop/data/models/category_response.dart';

void main() {
  CategoryModel testModel = CategoryModel(
      id: '1',
      name: '',
      image: '',
      parentId: 1,
      position: 1,
      status: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      priority: 1,
      moduleId: 1,
      productCount: 1);
  test('test should  return category model is subclass of category entity', () {
    // expect(testModel, )
  });
}
