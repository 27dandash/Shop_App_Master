import 'package:udemy_flutter/models/add_favorites.dart';
import 'package:udemy_flutter/models/login_model.dart';
import 'package:udemy_flutter/modules/shop/login/cubit/states.dart';

abstract class Shopstates {}

class AppChangeModeState extends Shopstates {}

class ShopInitialState extends Shopstates {}

class ShopcurrentindexState extends Shopstates {}

class ShopLoadingHomeDataState extends Shopstates {}

class ShopSuccessHomeDataState extends Shopstates {}

class ShopErrorHomeDataState extends Shopstates {}

class ShopSuccessCategoriesState extends Shopstates {}

class ShopErrorHomeCategoriesState extends Shopstates {}

class ShopSuccessfavoritesState extends Shopstates {
  final FavModel model;

  ShopSuccessfavoritesState(this.model);
}
class ShopfavoritesState extends Shopstates {}

class ShopErrorHomefavoritesState extends Shopstates {}

class ShopSuccessGetFavoriteState extends Shopstates {}

class ShopLoadingGetFavoriteState extends Shopstates {}

class ShopErrorGetFavoriteState extends Shopstates {}

class ShopSuccessProfileState extends Shopstates {
  final ShopLoginModel loginModel;

  ShopSuccessProfileState(this.loginModel);
}

class ShopLoadingProfileState extends Shopstates {}

class ShopErrorProfileState extends Shopstates {}

class ShopSuccessupdateuserState extends Shopstates {
  final ShopLoginModel loginModel;

  ShopSuccessupdateuserState(this.loginModel);
}

class ShopLoadingupdateuserState extends Shopstates {}

class ShopErrorupdateuserState extends Shopstates {}
