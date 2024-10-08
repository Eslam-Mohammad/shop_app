import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shop_app/Core/cache_memory/cache_memory_file.dart';
import 'package:shop_app/generated/l10n.dart';
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
  currentLanguageCode = CacheMemory.getData(key: 'lang');
  appMode = (CacheMemory.getData(key: 'isDark')??false)  ? ThemeMode.dark : ThemeMode.light ;
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
            themeMode: appMode,
           darkTheme: darkTheme,
            theme:ThemeData(
              appBarTheme:  AppBarTheme(
                titleTextStyle: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,color:Theme.of(context).colorScheme.primary,
                    fontFamily: 'Playwrite'),
                backgroundColor: Colors.white,
                elevation: 0.0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              brightness: Brightness.light,
              colorScheme: colorScheme,
            ),
            locale: Locale(currentLanguageCode??'en'),
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            home: startWidget,
          );
        },
      ),
    );
  }
}
