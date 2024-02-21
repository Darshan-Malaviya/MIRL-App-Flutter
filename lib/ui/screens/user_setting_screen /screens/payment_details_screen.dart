import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class PaymentDetailsScreen extends ConsumerStatefulWidget {
  const PaymentDetailsScreen({super.key});

  @override
  ConsumerState<PaymentDetailsScreen> createState() => _PaymentDetailsScreenState();
}

class _PaymentDetailsScreenState extends ConsumerState<PaymentDetailsScreen> {
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
        children: [
          Center(
            child: TitleLargeText(
              title: LocaleKeys.paymentDetails.tr(),
              titleColor: ColorConstants.bottomTextColor,
              titleTextAlign: TextAlign.center,
            ),
          ),
        ],
      ).addAllPadding(20),
    );
  }
}
