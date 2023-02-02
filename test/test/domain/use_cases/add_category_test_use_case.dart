import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shop_app/shop/data/models/category_request_model.dart';
import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/data/models/product_adding_request.dart';
import 'package:shop_app/shop/data/models/product_listing_response.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';
import 'package:shop_app/shop/domain/use_cases/add_category_use_case.dart';
import 'package:shop_app/shop/domain/use_cases/category_usecase.dart';
import 'package:shop_app/shop/domain/use_cases/delete_category_usecase.dart';

class MockProductRepository extends Mock implements ProductRepository {
  @override
  Future<String> addCategory(CategoryRequestModel request) {
    return super.noSuchMethod(Invocation.method(#getWorkers, null),
        returnValue: Future.value("test"));
  }

  @override
  Future<CategoryResponse> getCategories({String? searchKey, int? page}) {
    return super.noSuchMethod(Invocation.method(#getWorkers, null),
        returnValue: Future.value(CategoryResponse(
            totalSize: 1,
            totalPages: 1,
            currentPageNo: 1,
            categories: <CategoryModel>[])));
  }

  @override
  Future<String> deleteCategory(int id) {
    return super.noSuchMethod(Invocation.method(#getWorkers, null),
        returnValue: Future.value("test"));
  }

  @override
  Future<ProductResponse> getProducts({String? searchKey, required int page}) {
    return super.noSuchMethod(Invocation.method(#getWorkers, null),
        returnValue: Future.value(ProductResponse(
            tags: [],
            products: Products(
              totalSize: 1,
              totalPages: 1,
              currentPageNo: 1,
              products: [],
            ))));
  }

  @override
  Future<String> addProducts(ProductAddingRequest request) {
    return super.noSuchMethod(Invocation.method(#getWorkers, null),
        returnValue: Future.value('test'));
  }

  @override
  Future<String> deleteProduct(int id) {
    return super.noSuchMethod(Invocation.method(#getWorkers, null),
        returnValue: Future.value('test'));
  }
}

@GenerateMocks([MockProductRepository])
void main() {
  late AddCategoryUseCase categoryUseCase;
  late CategoryUseCase getCategoryUseCase;
  late DeleteCategoryUseCase deleteCategoryUseCase;
  late MockProductRepository mockProductRepository;
  final categoryRequestModel =
      CategoryRequestModel(name: 'test', image: 'test.png');
  final getResponse = CategoryResponse(
      totalSize: 1,
      totalPages: 1,
      currentPageNo: 1,
      categories: <CategoryModel>[]);
  String response = "Passed";

  setUp(() {
    mockProductRepository = MockProductRepository();
    categoryUseCase = AddCategoryUseCase(mockProductRepository);
    getCategoryUseCase = CategoryUseCaseImpl(mockProductRepository);
    deleteCategoryUseCase = DeleteCategoryUseCase(mockProductRepository);
  });
  group("running curd in categories", () {
    test('should add category', () async {
      when(mockProductRepository.addCategory(categoryRequestModel))
          .thenAnswer((_) async => response);
      final result = await categoryUseCase.call(categoryRequestModel);

      expect(result, response);
      verify(mockProductRepository.addCategory(categoryRequestModel));
      verifyNoMoreInteractions(mockProductRepository);
    });
    test('should get category', () async {
      when(mockProductRepository.getCategories())
          .thenAnswer((_) async => getResponse);
      final result = await getCategoryUseCase.get();

      expect(result, getResponse);
      verify(mockProductRepository.getCategories());
      verifyNoMoreInteractions(mockProductRepository);
    });
    test('should delete category', () async {
      when(mockProductRepository.deleteCategory(1))
          .thenAnswer((_) async => response);
      final result = await deleteCategoryUseCase.call(1);

      expect(result, response);
      verify(mockProductRepository.deleteCategory(1));
      verifyNoMoreInteractions(mockProductRepository);
    });
  });
}
