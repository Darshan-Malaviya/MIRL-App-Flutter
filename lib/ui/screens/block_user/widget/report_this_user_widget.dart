import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ReportThisUserWidget extends ConsumerStatefulWidget {
  const ReportThisUserWidget({super.key});

  @override
  ConsumerState<ReportThisUserWidget> createState() => _ReportThisUserWidgetState();
}

class _ReportThisUserWidgetState extends ConsumerState<ReportThisUserWidget> {
  @override
  void initState() {
    ref.read(reportUserProvider).changeReportAndThanksScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reportUserWatch = ref.watch(reportUserProvider);
    return reportUserWatch.pages[reportUserWatch.currentView];
  }
}
