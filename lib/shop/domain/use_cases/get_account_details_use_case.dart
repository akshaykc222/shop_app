import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/entities/account_detail_enitity.dart';
import 'package:shop_app/shop/domain/repositories/auth_remote_data_repository.dart';

class GetAccountDetailUseCase extends UseCase<AccountDetailEntity, NoParams> {
  final AuthRemoteDataRepository repository;

  GetAccountDetailUseCase(this.repository);

  @override
  Future<AccountDetailEntity> call(NoParams params) {
    return repository.getAccountDetail();
  }
}
