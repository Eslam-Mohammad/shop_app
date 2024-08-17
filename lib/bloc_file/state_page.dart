import 'package:shop_app/classes/categories_data_model.dart';
import 'package:shop_app/classes/favorites_model.dart';

import '../classes/home_data_model.dart';
import '../classes/login_class/login_class_file.dart';

abstract class AppStates {}

class InitialState extends AppStates {}
class ChangeIndexState extends AppStates {}

class LoginState extends AppStates {}
class LoginLoadingState extends AppStates {}
class LoginSuccessState extends AppStates {
  final LoginInfo loginInfo;

  LoginSuccessState(this.loginInfo);
}
class LoginErrorState extends AppStates {}

class HomeState extends AppStates {}

class HomeLoadingState extends AppStates {}
class HomeSuccessState extends AppStates {
  final HomeModel homeModel;

  HomeSuccessState(this.homeModel);
}
class HomeErrorState extends AppStates {}
class CategoryLoadingState extends AppStates {}
class CategorySuccessState extends AppStates {
  final CategoryModel categoryModel;

  CategorySuccessState(this.categoryModel);
}
class CategoryErrorState extends AppStates {}


class AddDeleteFavoritesSuccessState extends AppStates {}
class BeforeAddDeleteFavoritesState extends AppStates {}
class AddDeleteFavoritesLoadingState extends AppStates {}


class FavoritesDataSuccessState extends AppStates {
  final FavoritesModel favoritesModel;

  FavoritesDataSuccessState(this.favoritesModel);
}

class FavoritesLoadingState extends AppStates {}
class UserINfoLoadingState extends AppStates {}
class UserINfoSuccessState extends AppStates {}
class UserINfoErrorState extends AppStates {}

class RegisterLoadingState extends AppStates {}
class RegisterSuccessState extends AppStates {}
class RegisterErrorState extends AppStates {}


class UpdateUserLoadingState extends AppStates {}
class UpdateUserSuccessState extends AppStates {}
class UpdateUserErrorState extends AppStates {}


class SearchLoadingState extends AppStates {}
class SearchSuccessState extends AppStates {}
class SearchErrorState extends AppStates {}

class CartLoadingState extends AppStates {}
class CartSuccessState extends AppStates {}
class CartErrorState extends AppStates {}

class AddToCartLoadingState extends AppStates {}
class AddToCartSuccessState extends AppStates {}
class AddToCartErrorState extends AppStates {}