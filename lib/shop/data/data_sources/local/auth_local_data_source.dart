abstract class AuthLocalDataSource {
  Future<void> saveUserDetails();
  Future<void> getUserDetails();
}
