import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/schedule_screen/widget/start_call_widget.dart';
import 'package:mirl/ui/screens/schedule_screen/widget/time_out_widget.dart';
import 'package:mirl/ui/screens/schedule_screen/widget/try_again_widget.dart';

class PaymentCompletedScreen extends ConsumerStatefulWidget {
  const PaymentCompletedScreen({super.key});

  @override
  ConsumerState createState() => _PaymentCompletedScreenState();
}

class _PaymentCompletedScreenState extends ConsumerState<PaymentCompletedScreen> {
  List<Widget> _list = [StartCallWidget(), TryAgainWidget(), TimeOutWidget()];
  PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final scheduleWatch = ref.watch(scheduleCallProvider);
    final scheduleRead = ref.read(scheduleCallProvider);

    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
      ),
      body: Stack(
        children: [
          NetworkImageWidget(
            imageURL:
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            isNetworkImage: true,
            boxFit: BoxFit.cover,
          ),
          PageView.builder(
            itemCount: _list.length,
            pageSnapping: false,
            controller: controller,
            physics: NeverScrollableScrollPhysics(),
            onPageChanged: (value) {},
            itemBuilder: (context, index) {
              return DraggableScrollableSheet(
                initialChildSize: 0.6,
                minChildSize: 0.6,
                maxChildSize: 0.86,
                builder: (BuildContext context, myScrollController) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
                      color: ColorConstants.whiteColor,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          HeadlineMediumText(
                            title: 'Preeti Tewari Serai',
                            fontSize: 30,
                            titleColor: ColorConstants.bottomTextColor,
                          ),
                          22.0.spaceY,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  BodySmallText(
                                    title: LocaleKeys.overAllRating.tr(),
                                    fontFamily: FontWeightEnum.w400.toInter,
                                    titleTextAlign: TextAlign.center,
                                  ),
                                  10.0.spaceX,
                                  HeadlineMediumText(
                                    fontSize: 30,
                                    title: '-',
                                    titleColor: ColorConstants.overallRatingColor,
                                    shadow: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  BodySmallText(
                                    title: LocaleKeys.feesPerMinute.tr(),
                                    fontFamily: FontWeightEnum.w400.toInter,
                                    titleTextAlign: TextAlign.center,
                                  ),
                                  10.0.spaceX,
                                  HeadlineMediumText(
                                    fontSize: 30,
                                    title: '\$${20}',
                                    titleColor: ColorConstants.overallRatingColor,
                                    shadow: [Shadow(offset: Offset(0, 3), blurRadius: 4, color: ColorConstants.blackColor.withOpacity(0.3))],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          20.0.spaceY,
                          BodyMediumText(
                            title: LocaleKeys.durationOfBooking.tr(),
                            fontSize: 15,
                            titleColor: ColorConstants.blueColor,
                          ),
                          20.0.spaceY,
                          PrimaryButton(
                            height: 45,
                            width: 148,
                            title: '${20} ${LocaleKeys.minutes.tr()}',
                            buttonColor: ColorConstants.buttonColor,
                            onPressed: () {
                              // controller.nextPage(duration: Duration(milliseconds: 500), curve: Curves.easeIn);
                            },
                          ),
                          _list[index]
                        ],
                      ).addAllPadding(28),
                    ),
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
