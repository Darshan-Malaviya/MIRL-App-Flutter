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
      appBar: AppBarWidget(
        // leading: InkWell(
        //   child: Image.asset(ImageConstants.backIcon),
        //   onTap: () => context.toPop(),
        // ),
        trailingIcon: InkWell(
          onTap: () {},
          child: TitleMediumText(
            title: StringConstants.done,
          ).addPaddingRight(14),
        ),
      ),
      body: Center(
          child: PrimaryButton(
        onPressed: () {
          //ref.read(callProvider).callRequestEmit();
        },
        title: 'Tap',
      ) /*PageView(

          children: [
       */ /*     RatingWidget(
              onRatingChanged: (value) {},
            )*/ /*
            ReviewSlider(onChange: (value){})
          ],
        ),*/
          ),
    );
  }
}
