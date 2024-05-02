import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:shop_app/core/api_provider.dart';
import 'package:shop_app/shop/data/models/login_response.dart';
import 'package:shop_app/shop/data/models/requests/change_account_detail_model.dart';
import 'package:shop_app/shop/data/routes/app_remote_routes.dart';
import 'package:shop_app/shop/domain/entities/account_detail_enitity.dart';

import '../../models/account_detail_model.dart';

abstract class AuthDataSource {
  Future<LoginResponse> login(
      {required String email, required String password, int? type});

  Future<void> forgotPassword();
  Future<String> changePassword(String password);
  Future<void> getCurrentUser();
  Future<String> changeAccountDetails(ChangeAccountDetailsModel request);

  Future<AccountDetailEntity> getAccountDetail();
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
      {required String email, required String password, int? type}) async {
    var token = await FirebaseMessaging.instance.getToken();
    final data = await apiProvider.post(AppRemoteRoutes.login,
        {'mobile': email, 'password': password, 'token': token});
    return LoginResponse.fromJson(data);
  }

  @override
  Future<AccountDetailEntity> getAccountDetail() async {
    final data = await apiProvider.get(AppRemoteRoutes.accountDetails);
    return AccountDetailModel.fromJson(data);
  }

  @override
  Future<String> changePassword(String password) async {
    final data = await apiProvider.post(
      AppRemoteRoutes.changePassword,
      {'password': password},
    );
    return data.toString();
  }

  @override
  Future<String> changeAccountDetails(ChangeAccountDetailsModel request) async {
    final data = await apiProvider.post(AppRemoteRoutes.changeAccountDetail, {},
        formBody: FormData.fromMap(await request.toJson()));
    return data.toString();
  }
}
