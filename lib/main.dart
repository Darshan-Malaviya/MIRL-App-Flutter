import 'package:easy_localization/easy_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/utils/app_theme.dart';
import 'package:mirl/mirl_app.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';

import 'ui/screens/schedule_screen/schedule_call_screen.dart';

Future<void> mainCommon(FlavorConfig flavorConfig) async {
  await MirlApp.initializeApp(flavorConfig);

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
            theme: AppTheme.setTheme(context),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            initialRoute: '/',
            onGenerateRoute: RouterConstant.generateRoute,
            navigatorKey: NavigationService.navigatorKey,
            // home: ScheduleCallScreen(callArgs: CallArgs()),
          );
        },
      ),
    );
  }
}
