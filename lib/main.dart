import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/services/app_path_provider.dart';
import 'package:mirl/infrastructure/services/shared_pref_helper.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

late StateProvider<FlavorConfig> flavorConfigProvider;

FlavorConfig? flavorConfig;

Future<void> mainCommon(FlavorConfig flavorConfig) async {
  await WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.init();
  await AppPathProvider.initPath();
  await EasyLocalization.ensureInitialized();
  flavorConfigProvider = StateProvider<FlavorConfig>((ref) => flavorConfig);

  await Firebase.initializeApp(
      options:
          DefaultFirebaseOptions.firebaseOptionConfig(appId: flavorConfig.appIdForIOS, iosBundleId: flavorConfig.iosBundleId));

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
      child: Consumer(
        builder: (BuildContext context, WidgetRef ref, Widget? child) {
          flavorConfig = ref.read(flavorConfigProvider);
          return MaterialApp(
            builder: FToastBuilder(),
            title: flavorConfig?.appTitle ?? 'Mirl',
            theme: ThemeData(
              fontFamily: AppConstants.fontFamily,
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
            navigatorKey: NavigationService.navigatorKey,
            // home: SplashScreen(),
          );
        },
      ),
    );
  }
}
