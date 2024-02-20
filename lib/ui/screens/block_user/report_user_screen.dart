import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';
import 'package:mirl/ui/screens/block_user/widget/report_this_user_widget.dart';

class ReportUserScreen extends ConsumerStatefulWidget {
  final BlockUserArgs args;

  const ReportUserScreen({
    super.key,
    required this.args,
  });

  @override
  ConsumerState<ReportUserScreen> createState() => _ReportUserScreenState();
}

class _ReportUserScreenState extends ConsumerState<ReportUserScreen> {
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
      body: SingleChildScrollView(
        child: ReportThisUserWidget(args: BlockUserArgs(userRole: widget.args.userRole, reportName: widget.args.reportName)),
      ),
    );
  }
}
