import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/city_response_model.dart';

class CityListBottomView extends ConsumerStatefulWidget {
  final Function(CityModel item) onTapItem;
  final TextEditingController searchController;
  final VoidCallback clearSearchTap;
  final String countryId;

  const CityListBottomView({super.key, required this.onTapItem, required this.searchController, required this.clearSearchTap, required this.countryId});

  @override
  ConsumerState<CityListBottomView> createState() => _CityListBottomViewState();
}

class _CityListBottomViewState extends ConsumerState<CityListBottomView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      widget.clearSearchTap();
      ref.read(commonAppProvider).cityListApiCall(isFullScreenLoader: true, id: widget.countryId);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(commonAppProvider).reachedCityLastPage;
        if (!isLoading) {
          ref.read(commonAppProvider).cityListApiCall(id: widget.countryId);
        } else {
          log('reach last page on city list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final commonWatch = ref.watch(commonAppProvider);
    final commonRead = ref.read(commonAppProvider);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          TitleMediumText(title: "Select City", titleColor: ColorConstants.sheetTitleColor),
          16.0.spaceY,
          TextFormFieldWidget(
            isReadOnly: false,
            hintText: "Search here",
            suffixIcon: widget.searchController.text.isNotEmpty
                ? InkWell(
                    onTap: () {
                      commonRead.clearCityPaginationData();
                      widget.clearSearchTap();
                      commonRead.cityListApiCall(id: widget.countryId);
                    },
                    child: Icon(Icons.close))
                : SizedBox.shrink(),
            onFieldSubmitted: (value) {
              context.unFocusKeyboard();
              commonRead.clearCityPaginationData();
              commonRead.cityListApiCall(searchName: value.trim(), id: widget.countryId);
            },
            height: 40,
            controller: widget.searchController,
            textInputAction: TextInputAction.done,
          ).addAllMargin(12),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: commonWatch.city.isNotEmpty
                ? ListView.builder(
                    controller: scrollController,
                    itemCount: commonWatch.city.length + (commonWatch.reachedCityLastPage ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index == commonWatch.city.length && commonWatch.city.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                        );
                      }
                      return InkWell(
                        onTap: () {
                          widget.onTapItem(commonWatch.city[index]);
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: BodyMediumText(title: commonWatch.city[index].city ?? '', titleColor: ColorConstants.bottomTextColor),
                        ),
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Center(child: CircularProgressIndicator(color: ColorConstants.bottomTextColor)),
                  ),
          ),
          16.0.spaceY,
        ],
      ),
    );
  }
}
