import 'package:shop_app/core/usecase.dart';
import 'package:shop_app/shop/domain/repositories/auth_remote_data_repository.dart';
class ChangePasswordUseCase extends UseCase<String,String>{
  final AuthRemoteDataRepository repository;

  ChangePasswordUseCase(this.repository);

  @override
  Future<String> call(String params) {
   return repository.changePassword(params);
  }

}