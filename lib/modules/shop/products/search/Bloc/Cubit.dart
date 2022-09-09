import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy_flutter/models/search.dart';
import 'package:udemy_flutter/modules/shop/products/search/Bloc/states.dart';
import 'package:udemy_flutter/shared/components/components.dart';
import 'package:udemy_flutter/shared/network/end_point.dart';
import 'package:udemy_flutter/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

SearchModel model;

void getSearch(String text){
  emit(SearchLoadingState());
  DioHelper.postData(url: Search,
      token: token,
      data: {
    'text':text,
  }).then((value) {
   model=SearchModel.fromJson(value.data);
    emit(SearchSuccessState());
  }).catchError((onError){
    print(onError);
    emit(SearchErrorState());
  });

}
}