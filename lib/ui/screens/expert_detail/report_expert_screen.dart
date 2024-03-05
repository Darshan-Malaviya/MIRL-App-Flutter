
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';
import 'package:mirl/ui/screens/block_user/widget/report_this_user_widget.dart';

class ReportExpertScreen extends ConsumerStatefulWidget {
  final BlockUserArgs args;

  const ReportExpertScreen({super.key, required this.args});

  @override
  ConsumerState<ReportExpertScreen> createState() => _ReportExpertScreenState();
}

class _ReportExpertScreenState extends ConsumerState<ReportExpertScreen> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
        //  trailingIcon: InkWell(onTap: () {}, child: Icon(Icons.more_horiz)).addPaddingRight(14),
      ),
      body: Stack(
        children: [
          NetworkImageWidget(
            imageURL: widget.args.imageURL ?? '',
            isNetworkImage: true,
            boxFit: BoxFit.cover,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.65,
            minChildSize: 0.55,
            maxChildSize: 0.90,
            builder: (BuildContext context, myScrollController) {
              return bottomSheetView(controller: myScrollController);
            },
          ),
        ],
      ),
    );
  }

  Widget bottomSheetView({required ScrollController controller}) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(30), topLeft: Radius.circular(30)),
        color: ColorConstants.whiteColor,
      ),
      child: SingleChildScrollView(
        controller: controller,
        child: ReportThisUserWidget(
            args: BlockUserArgs(
          userRole: widget.args.userRole,
          reportName: widget.args.reportName,
          expertId: widget.args.expertId,
          controller: controller,
        )),
      ),
    );
  }
}
