import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';

class ExpertsListView extends ConsumerStatefulWidget {
  const ExpertsListView({super.key});

  @override
  ConsumerState<ExpertsListView> createState() => _ExpertsListViewState();
}

class _ExpertsListViewState extends ConsumerState<ExpertsListView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipOval(
              child: SizedBox.fromSize(
                size: Size.fromRadius(60), // Image radius
                child: Image.asset(ImageConstants.expert, fit: BoxFit.cover),
              ),
            ),
            12.0.spaceX,
            Column(
              children: [
                BodyLargeText(
                  title: 'Preeti Tewari Serai',
                  fontFamily: FontWeightEnum.w700.toInter,
                ),
                10.0.spaceY,
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.green[200],
                      ),
                      child: BodyLargeText(
                        title: 'Preeti',
                        fontFamily: FontWeightEnum.w700.toInter,
                      ),
                    ),
                    4.0.spaceX,
                    BodyLargeText(
                      title: 'Preeti',
                      fontFamily: FontWeightEnum.w700.toInter,
                    ),
                    4.0.spaceX,
                    BodyLargeText(
                      title: 'Preeti',
                      fontFamily: FontWeightEnum.w700.toInter,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
