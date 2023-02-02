import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_app/shop/data/models/product_adding_request.dart';
import 'package:shop_app/shop/data/models/product_list_request.dart';
import 'package:shop_app/shop/data/models/product_listing_response.dart';
import 'package:shop_app/shop/domain/use_cases/add_product_request_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/delete_product_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/product_status_update_usecase.dart';
import 'package:shop_app/shop/domain/use_cases/product_use_case.dart';

import 'add_category_test_use_case.dart';

@GenerateMocks([MockProductRepository])
void main() {
  late ProductListUseCase productListUseCase;
  late AddProductUseCase addProductUseCase;
  late DeleteProductUseCase deleteProductUseCase;
  late ProductStatusUpdateUseCase productStatusUpdateUseCase;
  late MockProductRepository repository;
  final productResponse = ProductResponse(
      tags: [],
      products: Products(
        totalSize: 1,
        totalPages: 1,
        currentPageNo: 1,
        products: [],
      ));
  setUp(() {
    repository = MockProductRepository();
    productListUseCase = ProductListUseCase(repository);
    addProductUseCase = AddProductUseCase(repository);
    deleteProductUseCase = DeleteProductUseCase(repository);
    productStatusUpdateUseCase = ProductStatusUpdateUseCase(repository);
  });
  group('product curd operation', () {
    test('should return product list', () async {
      when(repository.getProducts(page: 1))
          .thenAnswer((realInvocation) async => productResponse);
      var result = await productListUseCase.call(ProductListRequest(page: 1));

      expect(result, productResponse);
      verify(repository.getProducts(page: 1));
      verifyNoMoreInteractions(repository);
    });
    test('should add product ', () async {
      when(repository.addProducts(ProductAddingRequest(
              image: '',
              status: 1,
              name: '',
              tags: '',
              categoryId: 1,
              subCategoryId: 1,
              price: 1,
              discount: 1,
              discountType: '',
              stock: 1,
              unitId: 1,
              description: '')))
          .thenAnswer((realInvocation) async => 'test');
      var result = await addProductUseCase.call(ProductAddingRequest(
          image: '',
          status: 1,
          name: '',
          tags: '',
          categoryId: 1,
          subCategoryId: 1,
          price: 1,
          discount: 1,
          discountType: '',
          stock: 1,
          unitId: 1,
          description: ''));

      expect(result, 'test');
      verify(repository.getProducts(page: 1));
      verifyNoMoreInteractions(repository);
    });
    test('should delete product', () async {
      when(repository.deleteProduct(1))
          .thenAnswer((realInvocation) async => 'test');
      var result = await deleteProductUseCase.call(1);

      expect(result, 'test');
      verify(repository.deleteProduct(1));
      verifyNoMoreInteractions(repository);
    });
  });
}
