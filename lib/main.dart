import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  await AppPathProvider.initPath();
  await EasyLocalization.ensureInitialized();
  // await Firebase.initializeApp(
  //     options: DefaultFirebaseOptions.firebaseOptionConfig(appId: flavorConfig.appId, iosBundleId: flavorConfig.iosBundleId));
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarIconBrightness: Brightness.light,
  ));

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(
        EasyLocalization(
            supportedLocales: const [Locale('en', ''), Locale('ar', '')],
            path: 'assets/translations',
            // <-- change the path of the translation files
            fallbackLocale: const Locale('en', ''),
            child: const ProviderScope(child: MyApp())),
      ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        title: "Flutter Boilerplate 2023",
        theme: ThemeData(
          fontFamily: 'MuseoSans',
          useMaterial3: true,
          colorSchemeSeed: ColorConstants.primaryColor,
          scaffoldBackgroundColor: ColorConstants.whiteColor,
          appBarTheme: AppBarTheme(color: ColorConstants.primaryColor, elevation: 0, scrolledUnderElevation: 0),
          dividerColor: ColorConstants.greyLightColor,
          textSelectionTheme: TextSelectionThemeData(
            cursorColor: ColorConstants.primaryColor,
            selectionColor: ColorConstants.primaryColor.withOpacity(0.4),
            selectionHandleColor: ColorConstants.primaryColor,
          ),
        ),
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        initialRoute: '/',
        onGenerateRoute: RouterConstant.generateRoute,
        // home: SplashScreen(),
      ),
    );
  }
}
