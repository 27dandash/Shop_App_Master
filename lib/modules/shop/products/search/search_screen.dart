import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/search.dart';
import 'package:udemy_flutter/modules/shop/products/search/Bloc/Cubit.dart';
import 'package:udemy_flutter/shared/cubit/cubit.dart';
import 'package:udemy_flutter/shared/cubit/states.dart';

import '../../../../shared/components/components.dart';
import 'Bloc/states.dart';

class Search_Screen extends StatefulWidget {
  Search_Screen({Key key}) : super(key: key);

  @override
  State<Search_Screen> createState() => _Search_ScreenState();
}

class _Search_ScreenState extends State<Search_Screen> {
  var formkey = GlobalKey<FormState>();
  var searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //SearchCubit.get(context).getSearch;

    //searchmodel = SearchCubit.get(context).model;
  }

  SearchModel searchmodel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
              appBar: AppBar(),
              body: Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      defaultFormField(
                          controller: searchController,
                          type: TextInputType.text,
                          validate: (String value) {
                            if (value.isEmpty) {
                              return 'Enter Text To Search';
                            }
                            return null;
                          },
                          onSubmit: (String text) {
                            SearchCubit.get(context).getSearch(text);
                          },
                          label: 'Search',
                          prefix: Icons.search),
                      SizedBox(
                        height: 10,
                      ),
                      if (state is SearchLoadingState)
                        LinearProgressIndicator(),
                      if(state is SearchSuccessState)
                        Expanded(
                          child:  ListView.separated(
                              physics: BouncingScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return FavItem(SearchCubit.get(context).model.data.data[index],context,isoldprice: false);
                              },
                              separatorBuilder: (context, index) {
                                return myDivider();
                              },
                              itemCount: SearchCubit.get(context).model.data.data.length),
                        ),


                    ],
                  ),
                ),
              ));
        },
      ),
    );
  }
}
/*

 */