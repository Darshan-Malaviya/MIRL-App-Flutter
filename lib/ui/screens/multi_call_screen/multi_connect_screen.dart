import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class MultiConnectScreen extends ConsumerStatefulWidget {
  const MultiConnectScreen({super.key});

  @override
  ConsumerState createState() => _MultiConnectScreenState();
}

class _MultiConnectScreenState extends ConsumerState<MultiConnectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TitleSmallText(
            title: LocaleKeys.multiConnectScreenDesc.tr(),
            fontFamily: FontWeightEnum.w400.toInter,
            titleTextAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
