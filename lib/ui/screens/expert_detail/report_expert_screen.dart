import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/block_user/widget/report_this_user_widget.dart';

class ReportExpertScreen extends ConsumerStatefulWidget {
  //final int roleId;

  const ReportExpertScreen({super.key, /*required this.roleId*/});

  @override
  ConsumerState<ReportExpertScreen> createState() => _ReportExpertScreenState();
}

class _ReportExpertScreenState extends ConsumerState<ReportExpertScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        preferSize: 40,
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
        trailingIcon: InkWell(onTap: () {}, child: Icon(Icons.more_horiz)).addPaddingRight(14),
      ),
      body: Stack(
        children: [
          NetworkImageWidget(
            imageURL:
                'https://images.unsplash.com/photo-1494790108377-be9c29b29330?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            isNetworkImage: true,
            boxFit: BoxFit.cover,
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.45,
            minChildSize: 0.45,
            maxChildSize: 0.86,
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
        child: ReportThisUserWidget(),
      ),
    );
  }
}
