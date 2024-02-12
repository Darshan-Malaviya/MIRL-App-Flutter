import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/string_extention.dart';
import 'package:mirl/ui/common/network_image/circle_netwrok_image.dart';

class ExpertsListView extends ConsumerStatefulWidget {
  const ExpertsListView({super.key});

  @override
  ConsumerState<ExpertsListView> createState() => _ExpertsListViewState();
}

class _ExpertsListViewState extends ConsumerState<ExpertsListView> {
  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        20.0.spaceY,
        BodySmallText(
          title: LocaleKeys.experts.tr(),
          titleTextAlign: TextAlign.start,
          fontFamily: FontWeightEnum.w700.toInter,
        ),
        20.0.spaceY,
        if (homeProviderWatch.homeSearchData?.users?.isNotEmpty ?? false) ...[
          ListView.builder(
              itemCount: homeProviderWatch.homeSearchData?.users?.length ?? 0,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.toPushNamed(RoutesConstants.expertDetailScreen,
                        args: homeProviderWatch.homeSearchData?.users?[index].id.toString());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleNetworkImageWidget(
                          imageURL: homeProviderWatch.homeSearchData?.users?[index].expertProfile ?? '',
                          isNetworkImage: true,
                          radius: 30,
                          key: UniqueKey()),
                      12.0.spaceX,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyMediumText(
                            title: homeProviderWatch.homeSearchData?.users?[index].expertName ?? '',
                            fontFamily: FontWeightEnum.w700.toInter,
                          ),
                          2.0.spaceY,
                          if (homeProviderWatch.homeSearchData?.users?[index].categoris?.isNotEmpty ?? false) ...[
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 120,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children:
                                    List.generate(homeProviderWatch.homeSearchData?.users?[index].categoris?.length ?? 0, (i) {
                                      String color = homeProviderWatch.homeSearchData?.users?[index].categoris?[i].colorCode?.substring(1) ?? "D97CF0";
                                      int colorConcat = int.parse('0xff$color');

                                  return Container(
                                    color: Color(colorConcat),
                                    //color: ColorConstants.primaryColor.withOpacity(0.4),
                                    child: BodyMediumText(
                                      maxLine: 3,
                                      title: (homeProviderWatch.homeSearchData?.users?[index].categoris?[i].name
                                              ?.toLowerCase()
                                              .toCapitalizeAllWord() ??
                                          ''),
                                      fontFamily: FontWeightEnum.w700.toInter,
                                    ).addAllPadding(10),
                                  ).addPaddingXY(paddingX: 6, paddingY: 6);
                                }),
                              ),
                            )
                          ]
                        ],
                      )
                    ],
                  ).addMarginY(8),
                );
              })
        ] else ...[
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
