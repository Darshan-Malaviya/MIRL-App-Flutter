import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/services/agora_service.dart';
import 'package:mirl/ui/screens/video_call_screen/arguments/video_call_arguments.dart';
import 'package:mirl/ui/screens/video_call_screen/widget/video_call_bottomsgeet_widget.dart';

class VideoCallScreen extends ConsumerStatefulWidget {
final VideoCallArguments arguments;
  const VideoCallScreen({super.key,required this.arguments});

  @override
  ConsumerState<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends ConsumerState<VideoCallScreen> {
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(callProvider).initVideoCallAgora(channelId: widget.arguments.agoraChannelId, token: widget.arguments.agoraToken);
    });
  }

  @override
  Widget build(BuildContext context) {
    final callWatch = ref.watch(callProvider);
    final callRead = ref.read(callProvider);

    return Scaffold(
      body: Stack(
        children: [
          AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: engine,
              canvas: const VideoCanvas(uid: 0, mirrorMode: VideoMirrorModeType.videoMirrorModeAuto),
            ),
          ),
         /* Image.asset(
            width: double.infinity,
            ImageConstants.videoCall,
            fit: BoxFit.cover,
          ),*/
          InkWell(
            onTap: () {
              callRead.visibleBottomSheet();
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: callWatch.visible,
              child: AnimatedContainer(
                duration: Duration(seconds: 2),
                child: VideoCallWidget(),
              ),
            ),
          ),
          Positioned(
            bottom: callWatch.visible ? 200 : 10,
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
                      BoxShadow(offset: Offset(0, 0), color: ColorConstants.whiteColor.withOpacity(0.2), spreadRadius: 1, blurRadius: 5),
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
