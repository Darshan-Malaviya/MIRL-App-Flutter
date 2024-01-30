import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/string_extention.dart';

class TopicSearchView extends ConsumerStatefulWidget {
  const TopicSearchView({super.key});

  @override
  ConsumerState<TopicSearchView> createState() => _ExpertCategorySearchViewState();
}

class _ExpertCategorySearchViewState extends ConsumerState<TopicSearchView> {
  @override
  Widget build(BuildContext context) {

    final homeProviderWatch = ref.watch(homeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        20.0.spaceY,
        BodySmallText(
          title: LocaleKeys.topicsWithCategories.tr(),
          titleTextAlign: TextAlign.start,
          fontFamily: FontWeightEnum.w700.toInter,
        ),
        20.0.spaceY,
        if (homeProviderWatch.homeSearchData?.topics?.isNotEmpty ?? false) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(homeProviderWatch.homeSearchData?.topics?.length ?? 0, (index) {
              return Container(
                decoration: ShapeDecoration(
                  color: ColorConstants.whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x19000000),
                      blurRadius: 2,
                      offset: Offset(0, 2),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: TitleMediumText(
                  maxLine: 2,
                  softWrap: true,
                  title: homeProviderWatch.homeSearchData?.topics?[index].name?.toLowerCase().toCapitalizeAllWord() ?? '',
                  fontFamily: FontWeightEnum.w500.toInter,
                ).addPaddingXY(paddingX: 10, paddingY: 2),
              ).addPaddingXY(paddingX: 6, paddingY: 6);
            }),
          ),
          30.0.spaceY,
          ]  else ...[
          BodySmallText(
            fontWeight: FontWeight.w400,
            titleTextAlign: TextAlign.start,
            fontFamily: AppConstants.fontFamily,
            maxLine: 4,
            fontSize: 12,
            title: LocaleKeys.noResultsFoundTypeSomethingElse.tr(),
          ),
        ]

      ],
    );
  }
}
