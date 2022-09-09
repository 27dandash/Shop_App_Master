import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/login_model.dart';
import 'package:udemy_flutter/modules/shop/login/cubit/states.dart';
import 'package:udemy_flutter/modules/shop/register/cubit/states.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

import '../../../../shared/network/end_point.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel loginModel;

  void userRegister({
    @required String email,
    @required String name,
    @required String phone,
    @required String password,
  }) {
    emit(ShopRegisterLoadState());
    DioHelper.postData(url: Register, data: {
      'email': email,
      'name': name,
      'phone': phone,
      'password': password,
    }).then((value) {
     // print(value.data);
      loginModel = ShopLoginModel.fromjson(value.data);
  //    print(loginModel.data.token);
   //   print(loginModel.message);

      emit(ShopRegisterSuccessState(loginModel));
    }).catchError((error) {
     // print(error.toString());
    //  print('dddddddddddddddddddddddddddd');

      emit(ShopRegisterErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_off_outlined;
  bool isPassword = true;

  void changepasswordvisibility(){
    isPassword=!isPassword;
    suffix=isPassword ? Icons.visibility_off_outlined  : Icons.visibility_outlined ;
    emit(ShopPasswordVisState());
  }
}
