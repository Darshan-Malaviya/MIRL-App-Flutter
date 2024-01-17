import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/infrastructure/providers/provider_registration.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';

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
      ref.read(cityCountryProvider).AreaCategoryListApiCall();
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(cityCountryProvider).reachedLastPage;
        if (!isLoading) {
          log("this is called");
          // await Future.delayed(const Duration(seconds: 2));
          ref.read(cityCountryProvider).AreaCategoryListApiCall();
        } else {
          log('reach last page');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cityCountryWatch = ref.read(cityCountryProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          const TitleMediumText(
            title: "Select City",
          ),
          16.0.spaceY,
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: BodyMediumText(title: cityCountryWatch.country[index].country ?? ''),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: cityCountryWatch.country.length),
          ),
          16.0.spaceY,
        ],
      ),
    );
  }
}
