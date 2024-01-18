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
      ref.read(editExpertProvider).CountryListApiCall();
    });
    scrollController.addListener(() async {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        bool isLoading = ref.watch(editExpertProvider).reachedLastPage;
        if (!isLoading) {
          log("this is called");
          // await Future.delayed(const Duration(seconds: 2));
          ref.read(editExpertProvider).CountryListApiCall();
        } else {
          log('reach last page');
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
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.45,
            child: ListView.builder(
                controller: scrollController,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      expertWatch.country[index].id ?? '';
                      expertWatch.country[index].country ?? '';
                      expertRead.setSelectedCountry(value: expertWatch.country[index]);
                      expertRead.displayCountry(value: expertWatch.country[index]);
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
                itemCount: expertWatch.country.length),
          ),
          16.0.spaceY,
        ],
      ),
    );
  }
}
