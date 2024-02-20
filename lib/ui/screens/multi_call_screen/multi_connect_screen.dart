import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/common/shimmer_widgets/home_page_shimmer.dart';
import 'package:mirl/ui/common/shimmer_widgets/multiconnect_shimmer.dart';
import 'package:mirl/ui/screens/multi_call_screen/widget/multi_connect_category_widget.dart';

class MultiConnectScreen extends ConsumerStatefulWidget {
  const MultiConnectScreen({super.key});

  @override
  ConsumerState createState() => _MultiConnectScreenState();
}

class _MultiConnectScreenState extends ConsumerState<MultiConnectScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await ref.read(multiConnectProvider).categoryListApiCall(isLoaderVisible: true);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(multiConnectProvider).reachedCategoryLastPage;
        if (!isLoading) {
          await ref.read(multiConnectProvider).categoryListApiCall();
        } else {
          log('reach last page on all category list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final multiProviderWatch = ref.watch(multiConnectProvider);

    return Scaffold(
      backgroundColor: ColorConstants.greyLightColor,
      appBar: AppBarWidget(
        appBarColor: ColorConstants.greyLightColor,
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleLargeText(
            title: LocaleKeys.multipleConnect.tr(),
            maxLine: 2,
            titleTextAlign: TextAlign.center,
          ),
          20.0.spaceY,
          TitleSmallText(
            title: LocaleKeys.multiConnectScreenDesc.tr(),
            fontFamily: FontWeightEnum.w400.toInter,
            titleTextAlign: TextAlign.center,
            maxLine: 10,
          ),
          30.0.spaceY,
          BodySmallText(
            title: LocaleKeys.instantlyConnectWithLiveExpert.tr(),
            titleTextAlign: TextAlign.center,
            maxLine: 2,
            letterSpacing: 1.1,
          ),
          30.0.spaceY,
          if (multiProviderWatch.isLoading) ...[
            MultiConnectShimmerWidget(),
            20.0.spaceY,
            MultiConnectShimmerWidget(),
            20.0.spaceY,
            MultiConnectShimmerWidget()
          ] else ...[
            Expanded(child: MultiConnectCategoryWidget()),
          ]
        ],
      ).addPaddingX(20),
    );
  }
}
