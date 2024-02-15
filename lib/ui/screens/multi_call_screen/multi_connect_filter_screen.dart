import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/request/expert_data_request_model.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';

class MultiConnectFilterScreen extends ConsumerStatefulWidget {
  final FilterArgs args;

  const MultiConnectFilterScreen({super.key, required this.args});

  @override
  ConsumerState createState() => _MultiConnectFilterScreenState();
}

class _MultiConnectFilterScreenState extends ConsumerState<MultiConnectFilterScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref
          .read(multiConnectProvider)
          .getSingleCategoryApiCall(categoryId: widget.args.categoryId ?? '', context: context, requestModel: ExpertDataRequestModel(userId: SharedPrefHelper.getUserId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final multiProviderWatch = ref.watch(multiConnectProvider);
    final multiProviderRead = ref.read(multiConnectProvider);

    return Scaffold(
      backgroundColor: ColorConstants.grayLightColor,
      appBar: AppBarWidget(
        appBarColor: ColorConstants.grayLightColor,
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: multiProviderWatch.isLoading
          ? Center(
              child: CupertinoActivityIndicator(
                animating: true,
                color: ColorConstants.primaryColor,
                radius: 16,
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ShadowContainer(
                  shadowColor: ColorConstants.categoryListBorder,
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: NetworkImageWidget(
                          boxFit: BoxFit.cover,
                          imageURL: multiProviderWatch.singleCategoryData?.categoryData?.image ?? '',
                          isNetworkImage: true,
                          height: 50,
                          width: 50,
                        ),
                      ),
                      4.0.spaceY,
                      LabelSmallText(
                        fontSize: 9,
                        title: multiProviderWatch.singleCategoryData?.categoryData?.name ?? '',
                        titleColor: ColorConstants.blackColor,
                        fontFamily: FontWeightEnum.w700.toInter,
                        titleTextAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  height: 90,
                  width: 90,
                  isShadow: true,
                ),
                20.0.spaceY,
                if (multiProviderWatch.singleCategoryData?.categoryData?.topic?.isNotEmpty ?? false) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: ColorConstants.scaffoldBg,
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 0),
                          color: ColorConstants.blackColor.withOpacity(0.1),
                          spreadRadius: 2.0,
                          blurRadius: 2.0,
                        ),
                      ],
                    ),
                    child: Wrap(
                      children: List.generate(multiProviderWatch.singleCategoryData?.categoryData?.topic?.length ?? 0, (index) {
                        final data = multiProviderWatch.singleCategoryData?.categoryData?.topic?[index];
                        int topicIndex = multiProviderWatch.allTopic.indexWhere((element) => element.id == data?.id);
                        return OnScaleTap(
                          onPress: () {},
                          child: ShadowContainer(
                            shadowColor: (topicIndex != -1 && (multiProviderWatch.allTopic[topicIndex].isCategorySelected ?? false))
                                ? ColorConstants.primaryColor
                                : ColorConstants.blackColor.withOpacity(0.1),
                            backgroundColor: ColorConstants.whiteColor,
                            isShadow: true,
                            spreadRadius: 1,
                            blurRadius: 2,
                            margin: EdgeInsets.only(bottom: 10, right: 10),
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: BodyMediumText(
                              title: data?.name ?? '',
                              fontFamily: FontWeightEnum.w500.toInter,
                              maxLine: 5,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                  20.0.spaceY,
                  BodyMediumText(
                    title: StringConstants.topicText,
                    fontFamily: FontWeightEnum.w400.toInter,
                  ),
                ],
                BodyMediumText(
                  title: StringConstants.descriptionText,
                  fontFamily: FontWeightEnum.w400.toInter,
                  maxLine: 5,
                  titleTextAlign: TextAlign.center,
                ).addPaddingX(20),
                20.0.spaceY,
              ],
            ),
    );
  }
}
