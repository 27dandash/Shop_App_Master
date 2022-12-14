import 'package:udemy_flutter/models/login_model.dart';

abstract class ShopLoginStates {}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {

  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  final String error
  ;

  ShopLoginErrorState(this.error);
}
class ShopPasswordVisibilityState extends ShopLoginStates {}
