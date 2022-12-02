abstract class AccountRemoteDataSource {
  Future<void> getAccountDetails();
  Future<void> changeAccountDetails();
}
