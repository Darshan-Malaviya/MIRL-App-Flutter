import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class PastConversationsView extends ConsumerWidget {
  const PastConversationsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeProviderWatch = ref.watch(homeProvider);
    final homeProviderRead = ref.read(homeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodySmallText(
          title: LocaleKeys.yourPastConversations.tr(),
        ),
        10.0.spaceY,
        BodySmallText(
          titleColor: ColorConstants.emptyTextColor,
          fontFamily: FontWeightEnum.w400.toInter,
          maxLine: 2,
          title: LocaleKeys.cricketsTalkToSomeone.tr(),
        ),
        /*  SizedBox(
          height: 120,
          child: ListView.builder(
              itemCount: 10,
              padding: EdgeInsets.zero,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, builder) {
                return InkWell(
                  onTap: () {},
                  child: ShadowContainer(
                    padding: EdgeInsets.only(bottom: 8, top: 4, left: 8, right: 8),
                    shadowColor: ColorConstants.blackColor.withOpacity(0.1),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 37.5,
                          backgroundImage: NetworkImage(
                              "https://images.pexels.com/photos/709552/pexels-photo-709552.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
                        ),
                        10.0.spaceY,
                        LabelSmallText(
                          fontSize: 9,
                          title: 'Experts',
                          maxLine: 2,
                          titleColor: ColorConstants.blackColor,
                          fontFamily: FontWeightEnum.w700.toInter,
                          titleTextAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    width: 96,
                    height: 116,
                    isShadow: true,
                  ).addPaddingLeft(10),
                );
              }),
        ),
        10.0.spaceY,
        Center(
          child: TitleMediumText(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            titleTextAlign: TextAlign.center,
            title: LocaleKeys.seeAllPastConversations.tr().toUpperCase(),
          ),
        ),*/
      ],
    );
  }
}
