import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/shimmer_widgets/home_page_shimmer.dart';
import 'package:mirl/ui/screens/home_screen/widget/category_and_topic_list_view.dart';
import 'package:mirl/ui/screens/home_screen/widget/favorite_experts_view.dart';
import 'package:mirl/ui/screens/home_screen/widget/past_conversation_view.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeProvider).homePageApi();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    return Scaffold(
      backgroundColor: ColorConstants.grayLightColor,
      appBar: AppBarWidget(
        preferSize: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryButton(
              title: StringConstants.logOut,
              onPressed: () async {
                SharedPrefHelper.clearPrefs();
                context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
              },
            ),
            10.0.spaceY,
            InkWell(
              onTap: () {
                context.toPushNamed(RoutesConstants.searchScreen);
              },
              child: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.0), border: Border.all(color: ColorConstants.dropDownBorderColor)),
                child: BodySmallText(
                  maxLine: 2,
                  title: LocaleKeys.searchTypeAnyKeyword.tr(),
                ).addAllMargin(12),
              ),
            ),
            30.0.spaceY,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Container(
                      decoration: BoxDecoration(color: ColorConstants.whiteColor, borderRadius: BorderRadius.circular(6.0), boxShadow: [
                        BoxShadow(
                          color: Color(0x33000000),
                          blurRadius: 2,
                          offset: Offset(0, 2),
                          spreadRadius: 0,
                        )
                      ]),
                      child: Column(
                        children: [
                          BodySmallText(
                            fontWeight: FontWeight.w700,
                            title: LocaleKeys.exploreExperts.tr().toUpperCase(),
                          ),
                          10.0.spaceY,
                          Image.asset(
                            ImageConstants.expert,
                            height: 100,
                            width: 100,
                          ),
                          10.0.spaceY,
                          BodySmallText(
                            title: LocaleKeys.browseExpertsFields.tr(),
                            titleTextAlign: TextAlign.center,
                            maxLine: 3,
                          ),
                        ],
                      ).addAllMargin(12)),
                ),
                40.0.spaceX,
                Flexible(
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                        decoration: BoxDecoration(color: ColorConstants.whiteColor, borderRadius: BorderRadius.circular(6.0), boxShadow: [
                          BoxShadow(
                            color: Color(0x33000000),
                            blurRadius: 2,
                            offset: Offset(0, 2),
                            spreadRadius: 0,
                          )
                        ]),
                        child: Column(
                          children: [
                            BodySmallText(
                              fontWeight: FontWeight.w700,
                              title: LocaleKeys.multipleConnect.tr().toUpperCase(),
                            ),
                            10.0.spaceY,
                            Image.asset(
                              ImageConstants.multipleConnect,
                              height: 100,
                              width: 100,
                            ),
                            10.0.spaceY,
                            BodySmallText(
                              title: LocaleKeys.inviteMultipleExpertsAndSelectOne.tr(),
                              titleTextAlign: TextAlign.center,
                              maxLine: 3,
                            ),
                          ],
                        ).addAllMargin(12)),
                  ),
                )
              ],
            ),
            40.0.spaceY,
            if (homeProviderWatch.isHomeLoading) ...[
              CategoryListShimmerWidget(),
              20.0.spaceY,
              CategoryListShimmerWidget()
            ] else ...[
              CategoryAndTopicListView(),
              20.0.spaceY,
              FavoriteExpertsView(),
              20.0.spaceY,
              PastConversationsView(),
              20.0.spaceY,
            ]
          ],
        ).addPaddingXY(paddingX: 16, paddingY: 16),
      ),
    );
  }
}
