import 'package:app_links/app_links.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/shimmer_widgets/home_page_shimmer.dart';
import 'package:mirl/ui/screens/dashboard_screen/dashboard_screen.dart';
import 'package:mirl/ui/screens/home_screen/widget/category_and_topic_list_view.dart';
import 'package:mirl/ui/screens/home_screen/widget/favorite_experts_view.dart';
import 'package:mirl/ui/screens/home_screen/widget/past_conversation_view.dart';

import '../explore_expert_screen/explore_expert_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  //final ScrollController scrollController;
  HomeScreen({
    super.key,
    required this.context,
    /*required this.scrollController*/
  });
  final BuildContext context;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  ScrollController scrollController = ScrollController();
  AppLinks _applinks = AppLinks();

  @override
  void initState() {
    initiateAppLinks();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      debugPrint('Token=================${SharedPrefHelper.getFirebaseToken}');
      ref.read(homeProvider).homePageApi();
      instanceRequestTimerNotifier = ValueNotifier<int>(120);
      instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
    });
    // Future.delayed(Duration(seconds: 2)).then((value) {
    //   context.toPushNamed(RoutesConstants.mirlConnectScreen, args: "hello");
    // });
    super.initState();
  }

  Future<void> initiateAppLinks() async {
    _applinks.uriLinkStream.listen((uri) {
      String path = uri.path;
      Map<String, String> queryParameters = uri.queryParameters;
      if (path == "/invite" && queryParameters['referralCode'] != null && queryParameters['referralCode']!.isNotEmpty) {
        // navigate to referral programme screen
        String referralCode = queryParameters['referralCode']!;
        Future.delayed(Duration(seconds: 2)).then((value) {
          context.toPushNamed(RoutesConstants.mirlConnectScreen, args: referralCode);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    return GestureDetector(
      onVerticalDragDown: (tap) {
        Future.delayed(Duration(milliseconds: 200)).then((value) => HapticFeedback.heavyImpact());
      },
      child: RefreshIndicator(
        color: ColorConstants.primaryColor,
        onRefresh: () async {
          ref.read(homeProvider).homePageApi();
        },
        child: Scaffold(
          backgroundColor: ColorConstants.greyLightColor,
          appBar: AppBarWidget(
            appBarColor: ColorConstants.greyLightColor,
            preferSize: 0,
          ),
          body: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => context.toPushNamed(RoutesConstants.searchScreen),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: ColorConstants.dropDownBorderColor),
                      color: ColorConstants.whiteColor,
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                    child: BodySmallText(
                      maxLine: 1,
                      fontFamily: FontWeightEnum.w400.toInter,
                      title: LocaleKeys.searchTypeAnyKeyword.tr(),
                      titleColor: ColorConstants.blackColor,
                    ),
                  ),
                ),
                30.0.spaceY,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => ExploreExpertScreen(isFromHomePage: false,scrollController: expertScrollController,)));
                           // context.toPushNamed(RoutesConstants.exploreExpertScreen, args: false,);
                          // Navigator.pushNamed(context,RoutesConstants.exploreExpertScreen, arguments: false);
                          // NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 1);
                        },
                        child: Container(
                            height: 178,
                            decoration: BoxDecoration(
                                color: ColorConstants.whiteColor,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
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
                                  title: LocaleKeys.exploreExperts.tr().toUpperCase(),
                                  maxLine: 2,
                                ),
                                10.0.spaceY,
                                Expanded(
                                  child: Image.asset(
                                    ImageConstants.expert,
                                    height: 80,
                                    width: 80,
                                  ),
                                ),
                                10.0.spaceY,
                                BodySmallText(
                                  title: LocaleKeys.browseExpertsFields.tr(),
                                  titleTextAlign: TextAlign.center,
                                  maxLine: 2,
                                  fontFamily: FontWeightEnum.w400.toInter,
                                ),
                              ],
                            ).addAllMargin(12)),
                      ),
                    ),
                    40.0.spaceX,
                    Flexible(
                      child: GestureDetector(
                        onTap: () => context.toPushNamed(RoutesConstants.multiConnectScreen),
                        // onTap: (){
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(builder: (context) => MultiConnectScreen(), allowSnapshotting: false),
                        //   );
                        // },
                        child: Container(
                            height: 178,
                            decoration: BoxDecoration(
                                color: ColorConstants.whiteColor,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
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
                                  title: LocaleKeys.multipleConnect.tr().toUpperCase(),
                                  maxLine: 1,
                                  titleTextAlign: TextAlign.center,
                                ),
                                10.0.spaceY,
                                Expanded(
                                  child: Image.asset(
                                    ImageConstants.multipleConnect,
                                    height: 70,
                                    width: 80,
                                  ),
                                ),
                                10.0.spaceY,
                                BodySmallText(
                                  title: LocaleKeys.inviteMultipleExpertsAndSelectOne.tr(),
                                  titleTextAlign: TextAlign.center,
                                  fontFamily: FontWeightEnum.w400.toInter,
                                  maxLine: 2,
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
        ),
      ),
    );
  }
}
