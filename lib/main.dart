import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/Core/cache_memory/cache_memory_file.dart';
import 'package:shop_app/views/home_screen.dart';
import 'package:shop_app/views/onboarding_screen.dart';



import 'Core/constant_variables_file.dart';
import 'Data/api_file/dio_file.dart';
import 'Presenter/bloc_file/bloc_observer.dart';
import 'Presenter/bloc_file/cubit_page.dart';
import 'Presenter/bloc_file/state_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = AppBlocObserver();
  DioHelper.init();
  await CacheMemory.init();
  Widget widget;
  token = CacheMemory.getData(key: 'token');
  if (token == null) {
    widget = OnboardingScreen();
  } else {
    print("token is $token");
    widget = HomeScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});
  final Widget startWidget;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()
        ..getHomeData()
        ..getFavoritesData()
        ..getUserData()
        ..getCartData(),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
