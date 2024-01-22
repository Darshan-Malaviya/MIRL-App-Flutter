import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/font_family_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/padding_extension.dart';
import 'package:mirl/infrastructure/commons/extensions/ui_extensions/size_extension.dart';
import 'package:mirl/ui/common/appbar/appbar_widget.dart';
import 'package:mirl/ui/common/text_widgets/base/text_widgets.dart';
import 'package:mirl/ui/common/text_widgets/textfield/textformfield_widget.dart';
import 'package:mirl/ui/screens/search_screen/widget/experts_list_view.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: TextFormFieldWidget(
                    // width: 100,
                    textAlign: TextAlign.start,
                    hintText: LocaleKeys.typeSomethingHere.tr(),
                  ),
                ),
                8.0.spaceX,
                BodySmallText(
                  title: LocaleKeys.cancel.tr().toUpperCase(),
                  fontFamily: FontWeightEnum.w700.toInter,
                ),
              ],
            ),
            30.0.spaceY,
            BodySmallText(
              title: LocaleKeys.experts.tr(),
              titleTextAlign: TextAlign.start,
              fontFamily: FontWeightEnum.w700.toInter,
            ),
            40.0.spaceY,
            ExpertsListView()
          ],
        ).addAllPadding(20),
      ),
    );
  }
}
