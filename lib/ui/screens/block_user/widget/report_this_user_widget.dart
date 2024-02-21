import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/block_user/arguments/block_user_arguments.dart';

class ReportThisUserWidget extends ConsumerStatefulWidget {
  final BlockUserArgs args;

  const ReportThisUserWidget({super.key, required this.args});

  @override
  ConsumerState<ReportThisUserWidget> createState() => _ReportThisUserWidgetState();
}

class _ReportThisUserWidgetState extends ConsumerState<ReportThisUserWidget> {
  @override
  void initState() {
    ref
        .read(reportUserProvider)
        .changeReportAndThanksScreen(roleId: widget.args.userRole ?? 0, reportName: widget.args.reportName ?? '',expertId: widget.args.expertId ?? '');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reportUserWatch = ref.watch(reportUserProvider);
    return reportUserWatch.pages[reportUserWatch.currentView];
  }
}
