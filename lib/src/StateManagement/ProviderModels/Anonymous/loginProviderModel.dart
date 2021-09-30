import 'package:flutter/cupertino.dart';
import '../../../SendHttpCalls/Models/userModel.dart';
import '../Addresses/addAddressProviderModel.dart';
import '../Notifications/notificationProviderModel.dart';
import 'package:provider/provider.dart';
import '../../../SendHttpCalls/anonymousApis.dart';
import '../../../database/sharedPreference.dart';
import '../cartProviderModel.dart';
import '../favoriteProductProviderModel.dart';

class LoginProviderModel extends ChangeNotifier {
  String userName;
  String password;
  bool isLogin;
  bool isLoading = false;
  String errorMessage;
  final _userNameController = TextEditingController(text: "");
  TextEditingController getUserNameController() => _userNameController;
  final _passwordController = TextEditingController(text: "");
  TextEditingController getPasswordController() => _passwordController;
  LoginProviderModel() {
    // this._userNameController.text = "customer@gmail.com";
    // this._passwordController.text = "customer@gmail.com";
  }
  login(BuildContext context) async {
    userName = _userNameController.text;
    password = _passwordController.text;

    isLoading = true;
    notifyListeners();
    var responseData = await getUser(userName, password);

    if (responseData == null) {
      isLogin = false;
      errorMessage = "Error occurred, please try again!";
    } else {
      if (responseData.success) {
        var user = UserModel.fromJSON(responseData.data);
        await saveInSharePrefernece('LoggedInUser', user.toJson());
        loggedInUser = user;
        isLogin = true;
        _userNameController.text = "";
        _passwordController.text = "";
        errorMessage = '';

        Provider.of<AddAddressProviderModel>(context, listen: false)
            .getUserAddressFromAPI(context);

        Provider.of<CartProviderModel>(context, listen: false)
            .fetchFromStorage(context);

        Provider.of<FavoriteProductProviderModel>(context, listen: false)
            .fetchFavoriteFromStorage();

        Provider.of<NotificationProviderModel>(context, listen: false)
            .saveUserNotificationToken();
      } else if (responseData.data == "VERIFYOTP") {
        return "Error, your account is not verified, please contact us.";
      } else {
        errorMessage = "Error occurred, please try again!";
      }
    }
    isLoading = false;
    notifyListeners();
  }
}
