import 'dart:developer';

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
  // @override
  // void initState() {
  //   ref.read(reportUserProvider).changeReportAndThanksScreen(
  //       roleId: widget.args.userRole ?? 0, reportName: widget.args.reportName ?? '', expertId: widget.args.expertId ?? '');
  //   super.initState();
  // }

  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    //   ref.read(reportUserProvider).getAllReportListApiCall(role: widget.args.userRole ?? 0, isFullScreenLoader: true);
    // });
    ref.read(reportUserProvider).changeReportAndThanksScreen(
        roleId: widget.args.userRole ?? 0, reportName: widget.args.reportName ?? '', expertId: widget.args.expertId ?? '');
    if (widget.args.controller != null) {
      widget.args.controller?.addListener(() async {
        if (widget.args.controller?.position.pixels == widget.args.controller?.position.maxScrollExtent) {
          bool isLoading = ref.watch(reportUserProvider).reachedCategoryLastPage;
          if (!isLoading) {
            ref.read(reportUserProvider).getAllReportListApiCall(role: widget.args.userRole ?? 0);
          } else {
            log('reach last page on get report list api');
          }
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reportUserWatch = ref.watch(reportUserProvider);
    return reportUserWatch.pages[reportUserWatch.currentView];
  }
}
