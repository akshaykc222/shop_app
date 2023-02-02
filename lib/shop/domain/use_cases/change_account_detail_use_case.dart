import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/data/models/requests/change_account_detail_model.dart';
import 'package:shop_app/shop/domain/repositories/auth_remote_data_repository.dart';

class ChangeAccountDetailUseCase
    extends UseCase<String, ChangeAccountDetailsModel> {
  final AuthRemoteDataRepository repository;

  ChangeAccountDetailUseCase(this.repository);

  @override
  Future<String> call(ChangeAccountDetailsModel params) {
    return repository.changeAccountDetails(params);
  }
}
