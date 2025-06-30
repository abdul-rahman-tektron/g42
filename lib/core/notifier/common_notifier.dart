import 'package:smartcards/core/base/base_change_notifier.dart';

class CommonNotifier extends BaseChangeNotifier{
  CommonNotifier() {
    // loadUserFromStorage();
  }

  // Initialize user from local storage
  // Future<void> loadUserFromStorage() async {
  //   final userString = await SecureStorageHelper.getUser();
  //   if (userString != null) {
  //     user = LoginTokenUserResponse.fromJson(jsonDecode(userString));
  //     notifyListeners();
  //   }
  // }

  // Optional: update user from API or any source
  // void updateUser(LoginTokenUserResponse user) {
  //   this.user = user;
  //   notifyListeners();
  // }
  //
  // void clearUser() {
  //   user = null;
  //   notifyListeners();
  // }
}