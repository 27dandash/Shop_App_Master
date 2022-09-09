import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/login_model.dart';
import 'package:udemy_flutter/modules/shop/login/login_screen.dart';
import '../../../../shared/components/components.dart';
import '../../../../shared/cubit/cubit.dart';
import '../../../../shared/cubit/states.dart';
import '../../../../shared/network/local/cache_helper.dart';

class Setting_Screen extends StatefulWidget {
  Setting_Screen({Key key}) : super(key: key);

  @override
  State<Setting_Screen> createState() => _Setting_ScreenState();
}

class _Setting_ScreenState extends State<Setting_Screen> {
  initState() {
    ShopCubit.get(context).getProfiledata;

    model = ShopCubit.get(context).shopLoginModel;
   ShopCubit.get(context).updateuserdata(
       name: nameController.text,
       email: emailController.text,
       phone: phoneController.text);

  }
  ShopLoginModel fgcgf;

  ShopLoginModel model;
  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();

  var emailController = TextEditingController();

  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ShopCubit, Shopstates>(
        listener: (context, state) {
          if (state is ShopSuccessProfileState) {
            nameController.text = state.loginModel.data.name;
            emailController.text = state.loginModel.data.email;
            phoneController.text = state.loginModel.data.phone;
          }
        },
        builder: (context, state) {
     //     print(model.data.name);
          nameController.text = model.data.name;
          emailController.text = model.data.email;
          phoneController.text = model.data.phone;

          return ConditionalBuilder(
            condition: ShopCubit.get(context).shopLoginModel != null,
            builder: (context) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Form(
                  key: formkey,
                  child: Column(children: [
                    defaultFormField(
                        controller: nameController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Name must Not be empty';
                          }
                          return null;
                        },
                        label: 'Name',
                        prefix: Icons.person),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: emailController,
                        type: TextInputType.name,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Email must Not be empty';
                          }
                          return null;
                        },
                        label: 'Email',
                        prefix: Icons.person),
                    SizedBox(
                      height: 15,
                    ),
                    defaultFormField(
                        controller: phoneController,
                        type: TextInputType.emailAddress,
                        validate: (String value) {
                          if (value.isEmpty) {
                            return 'Phone must Not be empty';
                          }
                          return null;
                        },
                        label: 'Phone',
                        prefix: Icons.phone),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {

                            ShopCubit.get(context).updateuserdata(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text);

                        },
                        text: 'Update profile'),
                    SizedBox(
                      height: 20,
                    ),
                    defaultButton(
                        function: () {
                          CacheHelper.removeData(key: 'token');
                          navigateand(context, LoginScreen());
                        },
                        text: 'Logout'),
                  ]),
                )),
            fallback: (context) => Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
