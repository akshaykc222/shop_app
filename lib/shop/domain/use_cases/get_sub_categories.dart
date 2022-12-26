import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/category_request_model.dart';
import 'package:shop_app/shop/data/models/category_response.dart';
import 'package:shop_app/shop/domain/repositories/product_repository.dart';

class GetSubCategoriesUseCase
    extends UseCase<CategoryResponse, CategoryRequestModel> {
  final ProductRepository repository;

  GetSubCategoriesUseCase(this.repository);

  @override
  Future<CategoryResponse> call(CategoryRequestModel params) {
    assert(params.parentId != null, "parent id is required");
    return repository.getSubCategories(
        parentId: params.parentId!,
        page: params.page,
        searchKey: params.searchKey);
  }
}
