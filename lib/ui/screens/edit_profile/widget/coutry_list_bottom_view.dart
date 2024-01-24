import 'dart:developer';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';


class CountryListBottomView extends ConsumerStatefulWidget {
  const CountryListBottomView({super.key});

  @override
  ConsumerState<CountryListBottomView> createState() => _CountryListBottomViewState();
}

class _CountryListBottomViewState extends ConsumerState<CountryListBottomView> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(editExpertProvider).clearSearchCountryController();
      ref.read(editExpertProvider).CountryListApiCall(isFullScreenLoader: true);
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(editExpertProvider).reachedLastPage;
        if (!isLoading) {
          ref.read(editExpertProvider).CountryListApiCall();
        } else {
          log('reach last page of country list api');
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
            title: "Select Country",
          ),
          16.0.spaceY,
          TextFormFieldWidget(
            isReadOnly: false,
            hintText: "Search here",
            suffixIcon: expertWatch.searchCountryController.text.isNotEmpty
                ? InkWell(
                onTap: () {
                  expertRead.clearCountryPaginationData();
                  expertRead.clearSearchCountryController();
                  expertRead.CountryListApiCall();
                  setState(() {});
                },
                child: Icon(Icons.close))
                : SizedBox.shrink(),
            onFieldSubmitted: (value) {
              context.unFocusKeyboard();
              expertRead.clearCountryPaginationData();
              expertRead.CountryListApiCall(searchName: expertWatch.searchCountryController.text);
            },
            height: 40,
            controller: expertWatch.searchCountryController,
            textInputAction: TextInputAction.done,
          ).addAllMargin(12),
          expertWatch.country.isNotEmpty ?
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: ListView.builder(
                controller: scrollController,
                itemCount: expertWatch.country.length + (expertWatch.reachedLastPage ? 0 : 1),
                itemBuilder: (context, index) {
                  if(index == expertWatch.country.length && expertWatch.country.isNotEmpty){
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                  return InkWell(
                    onTap: () {
                      expertRead.setSelectedCountry(value: expertWatch.country[index]);
                      Navigator.pop(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: BodyMediumText(title: expertWatch.country[index].country ?? ''),
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
