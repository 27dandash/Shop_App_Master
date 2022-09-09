import 'package:udemy_flutter/models/add_favorites.dart';
import 'package:udemy_flutter/models/login_model.dart';
import 'package:udemy_flutter/modules/shop/login/cubit/states.dart';

abstract class SearchStates {}


class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {}

class SearchErrorState extends SearchStates {}