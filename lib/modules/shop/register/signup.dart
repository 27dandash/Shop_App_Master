import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter/modules/shop/login/login_screen.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../login/cubit/cubit.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class Signup extends StatefulWidget {
  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if(state is ShopRegisterSuccessState){
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
        //      print(state.RegisterModel.message);
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
          }        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Signup',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 40.0,
                        ),
                        defaultFormField(
                          controller: _nameController,
                          label: 'User Name',
                          prefix: Icons.person,
                          type: TextInputType.name,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'User Name must not be empty';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: _emailController,
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
                          controller: _phoneController,
                          label: 'Phone Number',
                          prefix: Icons.phone,
                          type: TextInputType.phone,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Phone Number must not be empty';
                            }

                            return null;
                          },
                        ),
                        SizedBox(
                          height: 15.0,
                        ),
                        defaultFormField(
                          controller: _passwordController,
                          onSubmit: (value) {
                            // if (formKey.currentState.validate()) {
                            //   ShopLoginCubit.get(context).userlogin(
                            //       email: _nameController.text,
                            //       password: _passwordController.text);
                            // }
                          },
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
                              return 'You have To enter Password';
                            }

                            return null;
                            //'You Password is wrong';
                          },
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        ConditionalBuilder(
                            condition: state is ! ShopRegisterLoadState,
                            builder: (context) => defaultButton(
                                  function: () {
                                    if (formKey.currentState.validate()) {
                                      ShopRegisterCubit.get(context)
                                          .userRegister(
                                              email: _emailController.text,
                                              name: _nameController.text,
                                              phone: _phoneController.text,
                                              password:
                                                  _passwordController.text);
                                    }
                                  },
                                  text: 'Register',
                                  isUpperCase: true,
                                ),
                            fallback: (context) =>
                                Center(child: CircularProgressIndicator())),
                        SizedBox(
                          height: 20.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                            ),
                            TextButton(
                              onPressed: () {
                                navigateTo(context, LoginScreen());
                              },
                              child: Text(
                                'Login Now',
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
