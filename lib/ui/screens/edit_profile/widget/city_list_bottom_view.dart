import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';


class CityListBottomView extends ConsumerStatefulWidget {
  const CityListBottomView({super.key});

  @override
  ConsumerState<CityListBottomView> createState() => _CityListBottomViewState();
}

class _CityListBottomViewState extends ConsumerState<CityListBottomView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(editExpertProvider).clearSearchCityController();
      ref.read(editExpertProvider).cityListApiCall(isFullScreenLoader: true);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(editExpertProvider).reachedCityLastPage;
        if (!isLoading) {
          ref.read(editExpertProvider).cityListApiCall();
        } else {
          log('reach last page on city list api');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final expertWatch = ref.watch(editExpertProvider);
    final expertRead = ref.read(editExpertProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const TitleMediumText(
            title: "Select City",
          ),
          16.0.spaceY,
          TextFormFieldWidget(
            isReadOnly: false,
            hintText: "Search here",
            suffixIcon: expertWatch.searchCityController.text.isNotEmpty
                ? InkWell(
                    onTap: () {
                      expertRead.clearCityPaginationData();
                      expertRead.clearSearchCityController();
                      expertRead.cityListApiCall();
                      setState(() {});
                    },
                    child: Icon(Icons.close))
                : SizedBox.shrink(),
            onFieldSubmitted: (value) {
              context.unFocusKeyboard();
              expertRead.clearCityPaginationData();
              expertRead.cityListApiCall(searchName: expertWatch.searchCityController.text);
            },
            height: 40,
            controller: expertWatch.searchCityController,
            textInputAction: TextInputAction.done,
          ).addAllMargin(12),
          expertWatch.city.isNotEmpty ?
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: ListView.builder(
                controller: scrollController,
                itemCount: expertWatch.city.length + (expertWatch.reachedCityLastPage ? 0 : 1),
                itemBuilder: (context, index) {
                  if(index == expertWatch.city.length && expertWatch.city.isNotEmpty){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      expertWatch.city[index].city ?? '';
                      expertRead.displayCity(value: expertWatch.city[index]);
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: BodyMediumText(title: expertWatch.city[index].city ?? ''),
                        ),
                      ],
                    ),
                  );
                },
                ),
          ) : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Center(child: CircularProgressIndicator()),
                ),
          16.0.spaceY,
        ],
      ),
    );
  }
}
