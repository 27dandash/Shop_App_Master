import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/categories_model.dart';
import 'package:udemy_flutter/models/home_model.dart';
import 'package:udemy_flutter/modules/shop/products/categoris/catigors_screen.dart';
import 'package:udemy_flutter/modules/shop/products/favirot/favirot_screen.dart';
import 'package:udemy_flutter/modules/shop/products/products/products_screen.dart';
import 'package:udemy_flutter/modules/shop/products/search/search_screen.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';
import 'package:udemy_flutter/shared/network/end_point.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';
import '../../../modules/shop/products/setting/setting_screen.dart';
import '../../../shared/components/components.dart';
import '../../models/add_favorites.dart';
import '../../models/get_favorite.dart';
import '../../models/login_model.dart';
import '../network/local/cache_helper.dart';

class ShopCubit extends Cubit<Shopstates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(AppChangeModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }
  }

  int currentindex = 0;

  List<Widget> bottomScreen = [
    ProductsScreen(),
    Categors_Screen(),
    Favirot_Screen(),
    Setting_Screen(),
  ];

  void changeBottom(index) {
    currentindex = index;
    emit(ShopcurrentindexState());
  }

  HomeModel homeModel;

  Map<int, bool> favariot = {};

  void getHomeData() {
    emit(ShopLoadingHomeDataState());

    DioHelper.getData(
      url: Home,
      token: token,
    ).then((value) {
      // printFullText(homeModel.data.banners[0].image);

      homeModel = HomeModel.fromJson(value.data);
   //   printFullText(homeModel.data.banners[0].image);
      homeModel.data.products.forEach((element) {
        favariot.addAll({
          element.id: element.inFavorites,
        });
      });
  //    print(favariot.toString());
  //    print(token);
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
   //   print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }

  CategoriesModel CategorsModel;

  void getCategoriesdata() {
    DioHelper.getData(
      url: Categories,
      token: token,
    ).then((value) {
      // printFullText(homeModel.data.banners[0].image);

      CategorsModel = CategoriesModel.fromJson(value.data);

      emit(ShopSuccessCategoriesState());
    }).catchError((error) {
   //   print(error.toString());
      emit(ShopErrorHomeCategoriesState());
    });
  }

  FavModel favModel;

  void changefavorites(int id) {
    favariot[id] = !favariot[id];
    emit(ShopfavoritesState());

    DioHelper.postData(
            url: favorites,
            data: {
              "product_id": id,
            },
            token: token)
        .then((value) {
      favModel = FavModel.fromJson(value.data);
    //  print('Valueis${value.data}');
      if (!favModel.status) {
        favariot[id] = !favariot[id];
      } else {
        getFavoritedata();
      }
      emit(ShopSuccessfavoritesState(favModel));
    }).catchError((onError) {
      favariot[id] = !favariot[id];
      emit(ShopErrorHomefavoritesState());
    });
  }

  FavoriteModel favoriteModel;

  void getFavoritedata() {
    emit(ShopLoadingGetFavoriteState());
    DioHelper.getData(
      url: favorites,
      token: token,
    ).then((value) {
      favoriteModel = FavoriteModel.fromJson(value.data);

      emit(ShopSuccessGetFavoriteState());
    }).catchError((error) {
   //   print(error.toString());
      emit(ShopErrorGetFavoriteState());
    });
  }

  ShopLoginModel shopLoginModel;

  void getProfiledata() {
    emit(ShopLoadingProfileState());
    DioHelper.getData(
      url: Profile,
      token: token,
    ).then((value) {
      shopLoginModel = ShopLoginModel.fromjson(value.data);
      print(shopLoginModel.data.name);
      emit(ShopSuccessProfileState(shopLoginModel));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorProfileState());
    });
  }

  void updateuserdata({
    @required String name,
    @required String email,
    @required String phone,
  }) {
    emit(ShopLoadingupdateuserState());
    DioHelper.putData(url: UpdateProfile, token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      shopLoginModel = ShopLoginModel.fromjson(value.data);
   //   print(shopLoginModel.data.name);
      emit(ShopSuccessupdateuserState(shopLoginModel));
    }).catchError((error) {
    //  print(error.toString());
      emit(ShopErrorupdateuserState());
    });
  }
}
