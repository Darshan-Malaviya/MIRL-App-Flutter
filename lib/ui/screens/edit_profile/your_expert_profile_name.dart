import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/constants/string_constants.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';

class YourExpertProfileNameScreen extends ConsumerStatefulWidget {
  const YourExpertProfileNameScreen({super.key});

  @override
  ConsumerState<YourExpertProfileNameScreen> createState() => _YourExpertProfileNameScreenState();
}

class _YourExpertProfileNameScreenState extends ConsumerState<YourExpertProfileNameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        trailingIcon: TitleMediumText(
          title: StringConstants.done,
          fontFamily: FontWeightEnum.w700.toInter,
        ).addPaddingRight(14),
        appTitle: TitleLargeText(
          title: StringConstants.yourExpertProfileName,
          titleColor: ColorConstants.bottomTextColor,
          fontFamily: FontWeightEnum.w700.toInter,
        ),
      ),
    );
  }
}
