import '../../data/models/login_response.dart';

abstract class AuthRemoteDataRepository {
  Future<LoginResponse> login(
      {required String email, required String password});
}
