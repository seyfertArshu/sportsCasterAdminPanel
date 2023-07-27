import 'package:agriappadmin/provider/create_article_provider.dart';
import 'package:agriappadmin/provider/get_articles_provider.dart';
import 'package:agriappadmin/provider/image_uploader_provider.dart';
import 'package:agriappadmin/provider/login_provider.dart';
import 'package:agriappadmin/provider/signup_provider.dart';
import 'package:agriappadmin/screen/NBHomeScreen.dart';
import 'package:agriappadmin/screen/NBSignInScreen.dart';
import 'package:agriappadmin/screen/NBSplashScreen.dart';
import 'package:agriappadmin/screen/NBWalkThroughScreen.dart';
import 'package:agriappadmin/store/AppStore.dart';
import 'package:agriappadmin/utils/AppTheme.dart';
import 'package:agriappadmin/utils/NBDataProviders.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

AppStore appStore = AppStore();

Widget defualtHome = NBWalkThroughScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final entrypoint = prefs.getBool('entrypoint') ?? false;

  final loggedIn = prefs.getBool('loggedIn') ?? false;

  if (entrypoint & !loggedIn) {
    defualtHome = NBSignInScreen();
  } else if (entrypoint && loggedIn) {
    defualtHome = NBHomeScreen();
  }
  await initialize(aLocaleLanguageList: languageList());

  appStore.toggleDarkMode(value: getBoolAsync('isDarkModeOnPref'));

  defaultRadius = 10;
  defaultToastGravityGlobal = ToastGravity.BOTTOM;

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => LoginNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => signupNotifier(),
      ),
      ChangeNotifierProvider(
        create: (context) => ImageUploaderProvier(),
      ),
      ChangeNotifierProvider(
        create: (context) => CreateArticleProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => getArticleProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: '${'News Blog'}${!isMobile ? ' ${platformName()}' : ''}',
      home: defualtHome,
      //NBSplashScreen(),
      theme: !appStore.isDarkModeOn
          ? AppThemeData.lightTheme
          : AppThemeData.darkTheme,
      scrollBehavior: SBehavior(),
      supportedLocales: LanguageDataModel.languageLocales(),
      localeResolutionCallback: (locale, supportedLocales) => locale,
    );
  }
}
