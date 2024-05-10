import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/expert_category_screen/widget/expert_details_widget.dart';
import 'package:mirl/ui/screens/selected_topic_screen/arguments/selected_topic_arguments.dart';

class SelectedTopicScreen extends ConsumerStatefulWidget {
  final SelectedTopicArgs args;

  const SelectedTopicScreen({super.key, required this.args});

  @override
  ConsumerState<SelectedTopicScreen> createState() => _SelectedTopicScreenState();
}

class _SelectedTopicScreenState extends ConsumerState<SelectedTopicScreen> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      ref.read(selectedTopicProvider).clearData();
      ref.read(selectedTopicProvider).selectedTopicApiCall(isFullScreenLoader: true,topicId: widget.args.topicId?? 0);
    });

    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(selectedTopicProvider).reachedCategoryLastPage;
        if (!isLoading) {
          await ref.read(selectedTopicProvider).selectedTopicApiCall();
        } else {
          log('reach last page on selected topic list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final selectedTopicWatch = ref.watch(selectedTopicProvider);
    return PopScope(
        child: Scaffold(
      backgroundColor: ColorConstants.scaffoldBg,
      appBar: AppBarWidget(
        appTitle: TitleLargeText(
          title: widget.args.topicName ?? '',
          fontSize: 20,
          maxLine: 2,
        ),
        appBarColor: ColorConstants.scaffoldBg,
        leading: InkWell(
            child: Image.asset(ImageConstants.backIcon),
            onTap: () {
              context.toPop();
            }),
      ),
      body: selectedTopicWatch.isLoading
          ? Center(
              child: CupertinoActivityIndicator(radius: 16, color: ColorConstants.primaryColor),
            )
          : SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (selectedTopicWatch.categoryList?.expertData?.isNotEmpty ?? false) ...[
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        itemBuilder: (context, i) {
                          if (i == (selectedTopicWatch.categoryList?.expertData?.length ?? 0) &&
                              (selectedTopicWatch.categoryList?.expertData?.isNotEmpty ?? false)) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                            );
                          }
                          return ExpertDetailWidget(
                            expertData: selectedTopicWatch.categoryList?.expertData?[i],
                          );
                        },
                        separatorBuilder: (context, index) => 30.0.spaceY,
                        itemCount: (selectedTopicWatch.categoryList?.expertData?.length ?? 0) +
                            (selectedTopicWatch.reachedCategoryLastPage ? 0 : 1))
                  ] else ...[
                    Center(
                      child: BodySmallText(
                        title: LocaleKeys.noResultFound.tr(),
                        fontFamily: FontWeightEnum.w600.toInter,
                        titleTextAlign: TextAlign.center,
                      ),
                    ),
                    20.0.spaceY,
                    40.0.spaceY,
                  ]
                ],
              ),
            ),
    ));
  }
}
