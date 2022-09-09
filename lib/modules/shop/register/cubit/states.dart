import 'package:udemy_flutter/models/login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitialState extends ShopRegisterStates {}

class ShopRegisterLoadState extends ShopRegisterStates {}

class ShopRegisterSuccessState extends ShopRegisterStates {

  final ShopLoginModel loginModel;

  ShopRegisterSuccessState(this.loginModel);
}

class ShopRegisterErrorState extends ShopRegisterStates {
  final String error;

  ShopRegisterErrorState(this.error);
}
class ShopPasswordVisState extends ShopRegisterStates {}
