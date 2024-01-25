import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/network_image/circle_netwrok_image.dart';

class ExpertsListView extends ConsumerStatefulWidget {
  const ExpertsListView({super.key});

  @override
  ConsumerState<ExpertsListView> createState() => _ExpertsListViewState();
}

class _ExpertsListViewState extends ConsumerState<ExpertsListView> {
  @override
  Widget build(BuildContext context) {
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
        ListView.builder(
            itemCount: 4,
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleNetworkImageWidget(
                      imageURL:
                          "https://images.pexels.com/photos/709552/pexels-photo-709552.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
                      isNetworkImage: true,
                      radius: 30,
                      key: UniqueKey()),
                  12.0.spaceX,
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyMediumText(
                        title: 'Preeti Tewari Serai',
                        fontFamily: FontWeightEnum.w700.toInter,
                      ),
                      2.0.spaceY,
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 120,
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          children: List.generate(3, (index) {
                            return Container(
                              color: ColorConstants.primaryColor.withOpacity(0.4),
                              child: BodyMediumText(
                                maxLine: 3,
                                title: index % 3 == 0 ? 'Preeti' : "User name Mirl",
                                fontFamily: FontWeightEnum.w700.toInter,
                              ).addAllPadding(10),
                            ).addPaddingXY(paddingX: 6, paddingY: 6);
                          }),
                        ),
                      )
                    ],
                  )
                ],
              ).addMarginY(8);
            })
      ],
    );
  }
}
