import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layout/social_app/cubit/cubit.dart';
import 'package:social_app/layout/social_app/social_layout.dart';
import 'package:social_app/shared/constants/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/network/remote/dio_helper.dart';
import 'layout/social_app/cubit/states.dart';
import 'modules/social_app/login/social_login_screen.dart';
import 'shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  

  await Firebase.initializeApp();
  await CacheHelper.init();

  bool isDark = CacheHelper.getData(key: 'isDark') ?? false;

  Widget widget;

  DioHelper.init();

  bool onBoarding = CacheHelper.getData(key: 'onBoarding');

  uId = CacheHelper.getData(key: 'uId');
  if (uId != null) {
    widget = SocialLayout();
  } else {
    widget = SocialLoginScreen();
  }

  runApp(MyApp(isDark, widget));
}

class MyApp extends StatelessWidget {
  bool isDark;
  Widget startWidget;
  MyApp(this.isDark, this.startWidget);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => SocialCubit()
              ..getUserData()
              ..getPosts()),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              title: 'Shop App',
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
              home: Directionality(
                textDirection: TextDirection.ltr,
                child: startWidget,
                // child: startWidget,
              ),
            );
          }),
    );
  }
}
