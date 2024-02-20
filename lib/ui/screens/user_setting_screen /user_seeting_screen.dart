import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class UserSettingScreen extends ConsumerStatefulWidget {
  const UserSettingScreen({super.key});

  @override
  ConsumerState<UserSettingScreen> createState() => _UserSettingScreenState();
}

class _UserSettingScreenState extends ConsumerState<UserSettingScreen> {
  @override
  Widget build(BuildContext context) {
    final providerWatch = ref.watch(callProvider);

    return Scaffold(
      appBar: AppBarWidget(),
      body: Center(
        child: PrimaryButton(
          title: StringConstants.logOut,
          onPressed: () async {
            SharedPrefHelper.clearPrefs();
            context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
          },
        ),
      ).addAllPadding(20),
      /* body: Center(
          child: PrimaryButton(
        onPressed: () {
          //ref.read(callProvider).callRequestEmit();
        },
        title: 'Tap',
      )
          PageView(

          children: [
             RatingWidget(
              onRatingChanged: (value) {},
            )
            ReviewSlider(onChange: (value){})
          ],
        ),
          ),*/
    );
  }
}
