import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/ui/screens/video_call_screen/widget/video_call_bottomsgeet_widget.dart';

class VideoCallScreen extends ConsumerStatefulWidget {
  const VideoCallScreen({super.key});

  @override
  ConsumerState<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends ConsumerState<VideoCallScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final videoCallWatch = ref.watch(videoCallProvider);
    final videoCallRead = ref.read(videoCallProvider);
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            width: double.infinity,
            ImageConstants.videoCall,
            fit: BoxFit.cover,
          ),
          InkWell(
            onTap: () {
              videoCallRead.visibleBottomSheet();
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: videoCallWatch.visible,
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                child: VideoCallWidget(),
              ),
            ),
          ),
          Positioned(
            bottom: videoCallWatch.visible ? 200 : 10,
            right: 2,
            child: Stack(
              children: [
                Container(
                  height: 150,
                  width: 120,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    color: ColorConstants.whiteColor.withOpacity(0.3),
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Image.asset(
                    ImageConstants.expertDetail,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          offset: Offset(0, 0),
                          color: ColorConstants.whiteColor.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 5),
                    ],
                  ),
                  child: Image.asset(ImageConstants.voiceOff).addAllPadding(8),
                )
              ],
            ).addAllPadding(20),
          )
        ],
      ),
    );
  }

// bottomShit() {
//   CommonBottomSheet.bottomSheet(
//     backgroundColor: Colors.transparent,
//     isDismissible: true,
//     context: context,
//     child: VideoCallWidget(),
//   );
// }
}
