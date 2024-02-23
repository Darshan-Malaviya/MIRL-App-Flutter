import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/country_response_model.dart';

class CountryListBottomView extends ConsumerStatefulWidget {
  final Function(CountryModel item) onTapItem;
  final TextEditingController searchController;
  final VoidCallback clearSearchTap;

  const CountryListBottomView({super.key, required this.onTapItem, required this.searchController, required this.clearSearchTap});

  @override
  ConsumerState<CountryListBottomView> createState() => _CountryListBottomViewState();
}

class _CountryListBottomViewState extends ConsumerState<CountryListBottomView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.clearSearchTap();
      ref.read(commonAppProvider).clearCountryPaginationData();
      ref.read(commonAppProvider).CountryListApiCall(isFullScreenLoader: true);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(commonAppProvider).reachedLastPage;
        if (!isLoading) {
          ref.read(commonAppProvider).CountryListApiCall();
        } else {
          log('reach last page of country list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final commonWatch = ref.watch(commonAppProvider);
    final commonRead = ref.read(commonAppProvider);

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            TitleMediumText(title: LocaleKeys.selectCountry.tr().toUpperCase(), titleColor: ColorConstants.sheetTitleColor),
            16.0.spaceY,
            TextFormFieldWidget(
              isReadOnly: false,
              hintText: LocaleKeys.searchHere.tr(),
              suffixIcon: widget.searchController.text.isNotEmpty
                  ? InkWell(
                      onTap: () {
                        commonRead.clearCountryPaginationData();
                        commonRead.CountryListApiCall();
                        widget.clearSearchTap();
                      },
                      child: Icon(Icons.close))
                  : SizedBox.shrink(),
              onFieldSubmitted: (value) {
                context.unFocusKeyboard();
              },
              onChanged: (value) {
                commonRead.clearCountryPaginationData();
                commonRead.CountryListApiCall(searchName: value.trim());
              },
              height: 40,
              controller: widget.searchController,
              textInputAction: TextInputAction.done,
            ).addAllMargin(12),
            Expanded(
              child: commonWatch.isSearchCountryBottomSheetLoading
                  ? Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                    )
                  : commonWatch.country.isNotEmpty
                      ? ListView.builder(
                          controller: scrollController,
                          itemCount: commonWatch.country.length + (commonWatch.reachedLastPage ? 0 : 1),
                          itemBuilder: (context, index) {
                            if (index == commonWatch.country.length && commonWatch.country.isNotEmpty) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 12),
                                child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                              );
                            }
                            return InkWell(
                              onTap: () {
                                widget.onTapItem(commonWatch.country[index]);
                              },
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(vertical: 5),
                                child: BodyMediumText(title: commonWatch.country[index].country ?? '', titleColor: ColorConstants.bottomTextColor),
                              ),
                            );
                          },
                        )
                      : Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(
                            child: BodyLargeText(
                              title: StringConstants.noDataFound,
                              fontFamily: FontWeightEnum.w600.toInter,
                            ),
                          ),
                        ),
            ),
            16.0.spaceY,
          ],
        ),
      ),
    );
  }
}
