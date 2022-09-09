import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/shared/components/components.dart';

import '../../modules/shop/products/search/search_screen.dart';
import '../../shared/cubit/cubit.dart';
import '../../shared/cubit/states.dart';
import '../../shared/network/local/cache_helper.dart';

class Shoplayout extends StatelessWidget {
  const Shoplayout({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, Shopstates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit =ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('ShopApp'),
actions: [
IconButton(onPressed: (){
  navigateTo(context, Search_Screen());
}, icon: Icon(Icons.search)),
],
          ),
      body: cubit.bottomScreen[cubit.currentindex],
          bottomNavigationBar:BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentindex,
            items: [
            BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Home',),
            BottomNavigationBarItem(icon: Icon(Icons.apps),label: 'Categories',),
            BottomNavigationBarItem(icon: Icon(Icons.favorite),label: 'favorite',),
            BottomNavigationBarItem(icon: Icon(Icons.settings),label: 'settings',),

          ],),
        );
      },
    );
  }
}

//log out
// ElevatedButton(onPressed: () {
// CacheHelper.removeData(key: 'token').then((value) {
// if (value) {
// navigateand(context, LoginScreen());
// }
// });
// }, child: Icon(Icons.ac_unit),),