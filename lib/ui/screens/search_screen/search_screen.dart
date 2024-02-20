import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/search_screen/widget/expert_category_search_view.dart';
import 'package:mirl/ui/screens/search_screen/widget/experts_list_view.dart';
import 'package:mirl/ui/screens/search_screen/widget/topic_list_search_view.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeProvider).clearSearchData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final homeProviderWatch = ref.watch(homeProvider);
    final homeProviderRead = ref.read(homeProvider);

    return Scaffold(
      backgroundColor: ColorConstants.greyLightColor,
      appBar: AppBarWidget(
        preferSize: 0,
      ),
      body: CustomScrollView(
        primary: true,
        physics: AlwaysScrollableScrollPhysics(),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Row(
              children: [
                8.0.spaceX,
                Flexible(
                  child: TextFormFieldWidget(
                    textAlign: TextAlign.start,
                    suffixIcon: homeProviderRead.homeSearchController.text.isNotEmpty
                        ? InkWell(
                            onTap: () => homeProviderRead.clearSearchData(),
                            child: Icon(Icons.close),
                          )
                        : SizedBox.shrink(),
                    controller: homeProviderWatch.homeSearchController,
                    onChanged: (value) {
                      if (homeProviderWatch.homeSearchController.text.isNotEmpty) {
                        homeProviderRead.homeSearchApi();
                      }
                    },
                    onFieldSubmitted: (value) {
                      context.unFocusKeyboard();
                    },
                    textInputAction: TextInputAction.done,
                    hintText: LocaleKeys.typeSomethingHere.tr(),
                  ),
                ),
                8.0.spaceX,
                OnScaleTap(onPress: () => context.toPop(), child: BodySmallText(title: LocaleKeys.cancel.tr())).addMarginY(5)
              ],
            ),
          ),
          if (homeProviderWatch.isHomeSearchLoading) ...[
            SliverToBoxAdapter(
              child: Center(
                  child: CupertinoActivityIndicator(
                animating: true,
                color: ColorConstants.primaryColor,
                radius: 16,
              ).addPaddingY(20)),
            ),
          ] else ...[
            if (homeProviderWatch.homeSearchData != null) ...[
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ExpertsListView();
                  },
                  childCount: 1,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return ExpertCategorySearchView();
                  },
                  childCount: 1,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return TopicSearchView();
                  },
                  childCount: 1,
                ),
              ),
            ],
          ],
        ],
      ).addAllPadding(16),
    );
  }
}
