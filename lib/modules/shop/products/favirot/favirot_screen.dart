import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:udemy_flutter/models/get_favorite.dart';
import 'package:udemy_flutter/shared/components/components.dart';

import '../../../../shared/cubit/cubit.dart';
import '../../../../shared/cubit/states.dart';

class Favirot_Screen extends StatefulWidget {
   Favirot_Screen({Key key}) : super(key: key);

  @override
  State<Favirot_Screen> createState() => _Favirot_ScreenState();
}

class _Favirot_ScreenState extends State<Favirot_Screen> {
  initState() {
    ShopCubit
        .get(context)
        .getFavoritedata;

    // fav=ShopCubit.get(context).favoriteModel;

  }

  // FavoriteModel fav;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
      listener: (context, state) {
        if (state is ShopSuccessfavoritesState) {
          if (state.model.status == true) {
            Fluttertoast.showToast(
                msg: state.model.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.green,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
        if (state is ShopSuccessfavoritesState) {
          if (state.model.status == false) {
            Fluttertoast.showToast(
                msg: state.model.message,
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.SNACKBAR,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoriteState,
            builder: (context) =>
                ListView.separated(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      return FavItem(ShopCubit
                          .get(context)
                          .favoriteModel
                          .data
                          .data[index].product, context);
                    },
                    separatorBuilder: (context, index) {
                      return myDivider();
                    },
                    itemCount: ShopCubit
                        .get(context)
                        .favoriteModel
                        .data
                        .data
                        .length),
            fallback: (context) => Center(child: CircularProgressIndicator()));
      },
    );
  }

}