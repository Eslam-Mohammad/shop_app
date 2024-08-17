import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/bloc_file/state_page.dart';
import 'package:shop_app/classes/cart_mode.dart';
import 'package:shop_app/classes/search_model.dart';
import 'package:shop_app/classes/cache_memory/cache_memory_file.dart';
import 'package:shop_app/classes/categories_data_model.dart';
import 'package:shop_app/classes/favorites_model.dart';
import 'package:shop_app/classes/home_data_model.dart';
import 'package:shop_app/classes/login_class/login_class_file.dart';
import 'package:shop_app/screens_file/cart_screen.dart';
import 'package:shop_app/screens_file/categories_screen.dart';
import 'package:shop_app/screens_file/favorites_screen.dart';
import 'package:shop_app/screens_file/home_screen_in_navigationbar.dart';

import '../api_file/dio_file.dart';
import '../api_file/end_points.dart';


class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
 LoginInfo? loginUserInfo;
  int currentIndex = 0;

  int imageIndex = 0;

  List<dynamic>bottomScreens = [
   const HomeScreenInNavigationBar(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    const CartScreen(),

  ];

  void changeimage(index){
    imageIndex = index;
    emit(ChangeIndexState());
  }


  void changeIndex(int index){
    currentIndex = index;
    emit(ChangeIndexState());
  }

void userLogin({required String email, required String password}){
  emit(LoginLoadingState());
   DioHelper.postData(url:loginUrl,data:  {
    'email': email,
    'password': password,}).then((value)
   {
      loginUserInfo = LoginInfo.fromJson(value.data);

      emit(LoginSuccessState(loginUserInfo!));
      print(value.data);

   }).catchError((error)
   {
     print(error.toString());
    emit(LoginErrorState());

   });

}


HomeModel? homeModel;

  Map<int,bool>favoritesMap = {};


void getHomeData(){
  emit(HomeLoadingState());
  DioHelper.getData(url:homeUrl ).then((value) {
    homeModel = HomeModel.fromJson(value.data);

    homeModel!.data!.products.forEach((element) {
      favoritesMap.addAll({element.id!:element.inFavorites!});
    });

    emit(HomeSuccessState(homeModel!));
  }).catchError((error){
    emit(HomeErrorState());
    print(error.toString());
  });
}
CategoryModel? categoryModel;

void getCategoryData(){
  emit(CategoryLoadingState());
  DioHelper.getData(url:categoriesUrl ).then((value) {
    categoryModel = CategoryModel.fromJson(value.data);
    emit(CategorySuccessState(categoryModel!));
  }).catchError((error){
    emit(CategoryErrorState());
    print(error.toString());
  });
}

StatusModelForFavorites ? statusModelForFavorites;

Future<void>? addDeleteFavorites({required int productId}) {
emit(AddDeleteFavoritesLoadingState());
  DioHelper.postData(url: favoritesUrl, data: {
    'product_id': productId,
  }, token: CacheMemory.getData(key: 'token')).then((value) async{
    statusModelForFavorites = StatusModelForFavorites.fromJson(value.data);
    print(value.data);
    if(statusModelForFavorites!.status!){
      if(favoritesIdsSet.contains(productId))
      {
        favoritesIdsSet.remove(productId);
      }else
      {
        favoritesIdsSet.add(productId);
      }
    }
    await getFavoritesData();


    emit(AddDeleteFavoritesSuccessState());

  }).catchError((error) {
    print(error.toString());
  });
}

FavoritesModel ? favoritesModel;
Set<int>favoritesIdsSet = {};
 Future<void> getFavoritesData() async {
  emit(FavoritesLoadingState());
  try {
    final value = await DioHelper.getData(url: favoritesUrl, token: CacheMemory.getData(key: 'token'));
    for(var element in value.data['data']['data']){
      favoritesIdsSet.add(element['product']['id']);

    }

    favoritesModel =  FavoritesModel.fromJson(value.data);


    emit(FavoritesDataSuccessState(favoritesModel!));
  } catch (error) {
    print(error.toString());
  }
}

LoginInfo? userInfo;
 void getUserData(){
  emit(UserINfoLoadingState());
  DioHelper.getData(url:profileUrl, token:CacheMemory.getData(key: 'token')).then((value) {
    userInfo = LoginInfo.fromJson(value.data);

    emit(UserINfoSuccessState());
  }).catchError((error){
    emit(UserINfoErrorState());
    print(error.toString());
  });
 }


 LoginInfo? registerUserInfo;

void registerUser({required String name,required String email,required String phone,required String password}){
  emit(RegisterLoadingState());
  DioHelper.postData(url:registerUrl,data:  {
    'name': name,
    'email': email,
    'phone': phone,
    'password': password,}).then((value) {
    registerUserInfo = LoginInfo.fromJson(value.data);
    userInfo = registerUserInfo;
    emit(RegisterSuccessState());
    print(value.data);


  }).catchError((error){
    print(error.toString());
    emit(RegisterErrorState());

  });

}

void updateUser({required String name,required String email,required String phone}){
  emit(UpdateUserLoadingState());
  DioHelper.putData(url:updateProfileUrl,data:  {
    'name': name,
    'email': email,
    'phone': phone,
    },token: CacheMemory.getData(key: 'token')).then((value) {
    userInfo = LoginInfo.fromJson(value.data);
    emit(UpdateUserSuccessState());
    print(value.data);
  }).catchError((error){
    print(error.toString());
    emit(UpdateUserErrorState());

  });}

  SearchModel? searchModel;

void search({required String text}){
  emit(SearchLoadingState());
  DioHelper.postData(url:'products/search',data:  {
    'text': text,
  }).then((value) {
    searchModel = SearchModel.fromJson(value.data);
    emit(SearchSuccessState());
    print(value.data);
  }).catchError((error){
    print(error.toString());
    emit(SearchErrorState());

  });}

  CartMode ? cartModel;
  void getCartData(){
emit(CartLoadingState());
   DioHelper.getData(url:'carts', token: CacheMemory.getData(key: 'token')).then((value) {

    cartModel = CartMode.fromJson(value.data);
    print('${cartModel?.status}') ;
    emit(CartSuccessState());

  }).catchError((error){
    print(error.toString());
    emit(CartErrorState());

  });}

void addDeleteCart({required int productId}){
  emit(AddToCartLoadingState());
  DioHelper.postData(url:'carts',data:  {
    'product_id': productId,
  },token: CacheMemory.getData(key: 'token')).then((value) {
    getCartData();
    emit(AddToCartSuccessState());

  }).catchError((error){
    emit(AddToCartErrorState());
    print(error.toString());
  });}






}





