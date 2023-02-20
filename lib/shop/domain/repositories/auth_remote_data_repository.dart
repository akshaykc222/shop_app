import 'package:shop_app/shop/data/models/requests/change_account_detail_model.dart';
import 'package:shop_app/shop/domain/entities/account_detail_enitity.dart';

import '../../data/models/login_response.dart';

abstract class AuthRemoteDataRepository {
  Future<LoginResponse> login(
      {required String email, required String password, int? type});
  Future<AccountDetailEntity> getAccountDetail();
  Future<String> changePassword(String password);
  Future<String> changeAccountDetails(ChangeAccountDetailsModel request);
}
