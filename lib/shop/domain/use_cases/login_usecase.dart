import '../../data/models/login_response.dart';
import '../repositories/auth_remote_data_repository.dart';

class LoginUseCase {
  final AuthRemoteDataRepository repository;

  LoginUseCase(this.repository);

  Future<LoginResponse> call(
      {required String email, required String password, int? type}) {
    return repository.login(email: email, password: password, type: type);
  }
}
