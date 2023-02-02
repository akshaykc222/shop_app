import 'package:shop_app/shop/data/data_sources/remote/auth_data_source.dart';
import 'package:shop_app/shop/data/models/login_response.dart';
import 'package:shop_app/shop/data/models/requests/change_account_detail_model.dart';
import 'package:shop_app/shop/domain/entities/account_detail_enitity.dart';
import 'package:shop_app/shop/domain/repositories/auth_remote_data_repository.dart';

class AuthRemoteDataRepositoryImpl extends AuthRemoteDataRepository {
  final AuthDataSource dataSource;

  AuthRemoteDataRepositoryImpl(this.dataSource);

  @override
  Future<LoginResponse> login(
      {required String email, required String password}) {
    return dataSource.login(email: email, password: password);
  }

  @override
  Future<AccountDetailEntity> getAccountDetail() {
    return dataSource.getAccountDetail();
  }

  @override
  Future<String> changePassword(String password) {
    return dataSource.changePassword(password);
  }

  @override
  Future<String> changeAccountDetails(ChangeAccountDetailsModel request) {
    return dataSource.changeAccountDetails(request);
  }
}
