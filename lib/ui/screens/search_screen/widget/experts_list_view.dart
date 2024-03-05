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
        ),
        if (homeProviderWatch.homeSearchData?.users?.isNotEmpty ?? false) ...[
          20.0.spaceY,
          ListView.builder(
              itemCount: homeProviderWatch.homeSearchData?.users?.length ?? 0,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    context.toPushNamed(RoutesConstants.expertDetailScreen, args: homeProviderWatch.homeSearchData?.users?[index].id.toString());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleNetworkImageWidget(imageURL: homeProviderWatch.homeSearchData?.users?[index].expertProfile ?? '', isNetworkImage: true, radius: 30, key: UniqueKey()),
                      12.0.spaceX,
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BodyMediumText(
                            title: homeProviderWatch.homeSearchData?.users?[index].expertName ?? '',
                          ),
                          2.0.spaceY,
                          if (homeProviderWatch.homeSearchData?.users?[index].categories?.isNotEmpty ?? false) ...[
                            SizedBox(
                              width: MediaQuery.of(context).size.width - 120,
                              child: Wrap(
                                alignment: WrapAlignment.start,
                                children: List.generate(homeProviderWatch.homeSearchData?.users?[index].categories?.length ?? 0, (i) {
                                  String color = homeProviderWatch.homeSearchData?.users?[index].categories?[i].colorCode?.substring(1) ?? "D97CF0";
                                  int colorConcat = int.parse('0xff$color');

                                  return Container(
                                    color: Color(colorConcat),
                                    margin: EdgeInsets.only(right: 8,top: 5,bottom: 5),
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    child: BodyMediumText(
                                      maxLine: 3,
                                      title: (homeProviderWatch.homeSearchData?.users?[index].categories?[i].name?.toLowerCase().toCapitalizeAllWord() ?? ''),
                                      fontFamily: FontWeightEnum.w400.toInter,
                                    ),
                                  );
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
          10.0.spaceY,
          BodySmallText(
            fontFamily: FontWeightEnum.w400.toInter,
            titleTextAlign: TextAlign.start,
            maxLine: 4,
            title: LocaleKeys.noResultsFoundTypeSomethingElse.tr(),
          ),
        ]
      ],
    );
  }
}
