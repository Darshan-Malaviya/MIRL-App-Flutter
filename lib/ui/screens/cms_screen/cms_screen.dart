import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/cms_screen/arguments/cms_arguments.dart';

class CmsScreen extends ConsumerStatefulWidget {
  final CmsArgs args;

  const CmsScreen({super.key, required this.args});

  @override
  ConsumerState<CmsScreen> createState() => _CmsScreenState();
}

class _CmsScreenState extends ConsumerState<CmsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(loginScreenProvider).cmsApiCall(widget.args.name ?? '');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginScreenProviderWatch = ref.watch(loginScreenProvider);
    return Scaffold(
      appBar: AppBarWidget(
        leading: InkWell(
          child: Image.asset(ImageConstants.backIcon),
          onTap: () => context.toPop(),
        ),
        centerTitle: true,
        appTitle: TitleLargeText(
          title: widget.args.title ?? '',
          titleColor: ColorConstants.bottomTextColor,
        ),
      ),
      body: loginScreenProviderWatch.cmsData?.content?.isNotEmpty ?? false
          ? SingleChildScrollView(
              child: Center(
                child: Html(
                  data: loginScreenProviderWatch.cmsData?.content ?? '',
                  style: {
                    'html': Style(textAlign: TextAlign.center),
                  },
                ),
              ),
            ).addAllPadding(20)
          : const Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                  fontSize: 20,
                  color: ColorConstants.blackColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
    );
  }
}
