import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter/layout/shop_app/shop_layout.dart';
import 'package:udemy_flutter/modules/shop/register/signup.dart';

import 'package:udemy_flutter/shared/components/components.dart';
import 'package:conditional_builder/conditional_builder.dart';

import '../../../shared/network/local/cache_helper.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';


// reusable components

// 1. timing
// 2. refactor
// 3. quality
// 4. clean code

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          if(state is ShopLoginSuccessState){
            if(state.loginModel.status){
              CacheHelper.savedata(key: 'token', value: state.loginModel.data.token).then((value) {
                token=state.loginModel.data.token;
                navigateand(context, Shoplayout());
              });
              Fluttertoast.showToast(
                  msg: state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.SNACKBAR,
                  timeInSecForIosWeb:3,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);

            }
            else{
      //        print(state.loginModel.message);
              Fluttertoast.showToast(
                  msg:state.loginModel.message,
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 5,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0
              );
            }
          }

          if(state is ShopLoginErrorState){

            Fluttertoast.showToast(
                msg: 'Email Or Password are wring',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);

          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultFormField(
                          controller: emailController,
                          label: 'Email',
                          prefix: Icons.email,
                          type: TextInputType.emailAddress,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'email must not be empty';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: passwordController,
                          onSubmit: (value){ if (formKey.currentState.validate()) {
                            ShopLoginCubit.get(context).userlogin(
                                email:  emailController.text,
                                password: passwordController.text);
                          }},
                          label: 'Password',
                          prefix: Icons.lock,
                          // isPassword: ShopLoginCubit.get(context).isPassword,
                          // suffix: ShopLoginCubit.get(context).suffix,
                          // suffixPressed: (){
                          // ShopLoginCubit.get(context).changepasswordvisibility();
                          // },
                          suffix: isPassword
                              ? Icons.visibility
                              : Icons.visibility_off,
                          isPassword: isPassword,
                          suffixPressed: () {
                            setState(() {
                              isPassword = !isPassword;
                            });
                          },
                          type: TextInputType.visiblePassword,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'You have enter Password';
                            }

                            return null;
                              //'You Password is wrong';
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                            condition: state is ! ShopLoginLoadState,
                            builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState.validate()) {
                                      ShopLoginCubit.get(context).userlogin(
                                        email:  emailController.text,
                                        password: passwordController.text);
                                    }
                                  },
                                  text: 'login',
                                  isUpperCase: true,
                                ),
                            fallback: (context) => Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 20.0,
                        ),

                        SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Don\'t have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, Signup());
                              },
                              child: Text(
                                'Register Now',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
