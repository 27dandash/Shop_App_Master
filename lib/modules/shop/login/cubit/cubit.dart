import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/login_model.dart';
import 'package:udemy_flutter/modules/shop/login/cubit/states.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/end_point.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userlogin({
    @required String email,
    @required String password,
  }) {
    emit(ShopLoginLoadState());
    DioHelper.postData(url: LOGIN, data: {
      'email': email,
      'password': password,
    }).then((value) {
    //  print(value.data);
     loginModel= ShopLoginModel.fromjson(value.data);
   //   print(loginModel.data.token);
  //    print(loginModel.message);


      emit(ShopLoginSuccessState(
        loginModel
      ));
    }).catchError((error) {
   //       print(error.toString());
   //       print('dddddddddddddddddddddddddddd');

      emit(ShopLoginErrorState(error.toString()));
    });
  }

  IconData suffix=Icons.visibility_off_outlined;
  bool isPassword=true;

  void changepasswordvisibility(){
     isPassword=!isPassword;
    suffix=isPassword ? Icons.visibility_off_outlined  : Icons.visibility_outlined ;
     emit(ShopPasswordVisibilityState());
  }
}
