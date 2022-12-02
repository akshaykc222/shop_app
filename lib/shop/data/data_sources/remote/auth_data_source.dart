import 'package:shop_app/core/api_provider.dart';
import 'package:shop_app/shop/data/models/login_response.dart';
import 'package:shop_app/shop/data/routes/app_remote_routes.dart';

abstract class AuthDataSource {
  Future<LoginResponse> login(
      {required String email, required String password});
  Future<void> forgotPassword();
  Future<void> getCurrentUser();
}

class AuthDataSourceImpl extends AuthDataSource {
  final ApiProvider apiProvider;

  AuthDataSourceImpl(this.apiProvider);

  @override
  Future<void> forgotPassword() {
    // TODO: implement forgotPassword
    throw UnimplementedError();
  }

  @override
  Future<void> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }

  @override
  Future<LoginResponse> login(
      {required String email, required String password}) async {
    final data = await apiProvider
        .post(AppRemoteRoutes.login, {'email': email, 'password': password});
    return LoginResponse.fromJson(data);
  }
}
