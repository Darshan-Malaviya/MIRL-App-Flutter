import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_status_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/extensions/time_extension.dart';
import 'package:mirl/infrastructure/commons/utils/value_notifier_utils.dart';
import 'package:tap_debouncer/tap_debouncer.dart';

class VideoCallWidget extends ConsumerStatefulWidget {
  const VideoCallWidget({super.key});

  @override
  ConsumerState<VideoCallWidget> createState() => _VideoCallWidgetState();
}

class _VideoCallWidgetState extends ConsumerState<VideoCallWidget> {
  @override
  Widget build(BuildContext context) {
    final callWatch = ref.watch(callProvider);
    final callRead = ref.read(callProvider);

    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.whiteColor.withOpacity(0.35),
        borderRadius: BorderRadius.only(topRight: Radius.circular(50.0), topLeft: Radius.circular(50.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  callRead.onCameraSwitch();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: callWatch.isFrontCameraOn
                          ? ColorConstants.whiteColor.withOpacity(0.25)
                          : ColorConstants.whiteColor.withOpacity(0.7),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            color: ColorConstants.whiteColor.withOpacity(0.25),
                            spreadRadius: 1,
                            blurRadius: 4),
                      ],
                      shape: BoxShape.circle),
                  child: Image.asset(ImageConstants.cameraON),
                ),
              ),
              InkWell(
                onTap: () {
                  callRead.changeLocalVideo();
                  //engine.enableLocalVideo(callWatch.videoOn);
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: callWatch.isLocalVideoOn
                          ? ColorConstants.whiteColor.withOpacity(0.25)
                          : ColorConstants.whiteColor.withOpacity(0.7),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            color: ColorConstants.whiteColor.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4),
                      ],
                      shape: BoxShape.circle),
                  child: Image.asset(ImageConstants.videoOff),
                ),
              ),
              InkWell(
                onTap: () {
                  callRead.changeLocalMic();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: BoxDecoration(
                      color: callWatch.isLocalMicOn
                          ? ColorConstants.whiteColor.withOpacity(0.25)
                          : ColorConstants.whiteColor.withOpacity(0.7),
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0, 0),
                            color: ColorConstants.whiteColor.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 4),
                      ],
                      shape: BoxShape.circle),
                  child: Image.asset(ImageConstants.voiceOff),
                ),
              ),
              TapDebouncer(
                  cooldown: const Duration(milliseconds: 2500),
                  onTap: () async {
                    if(callWatch.remoteUid == null && (instanceCallDurationNotifier.value <= 0)
                      && ((ref.watch(socketProvider).extraResponseModel?.userId.toString() ?? '') == SharedPrefHelper.getUserId.toString())){
                      await ref.read(socketProvider).updateCallStatusEmit(status: CallStatusEnum.cancelCall,
                          callRoleEnum: CallRoleEnum.user,
                          callHistoryId: ref.watch(socketProvider).extraResponseModel?.callHistoryId.toString() ?? '');

                    } else {
                      bool isUser =  ref.read(socketProvider).extraResponseModel?.userId.toString() == SharedPrefHelper.getUserId.toString();
                      await ref.read(socketProvider).updateCallStatusEmit(status: CallStatusEnum.completedCall,
                          callRoleEnum: isUser ? CallRoleEnum.user : CallRoleEnum.expert,
                          callHistoryId: ref.watch(socketProvider).extraResponseModel?.callHistoryId.toString() ?? '');
                    }
                  },
                  builder: (BuildContext context, Future<void> Function()? onTap) {
                    return InkWell(
                      onTap: onTap,
                      child: Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: ColorConstants.whiteColor.withOpacity(0.2),
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0, 0),
                                  color: ColorConstants.whiteColor.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 4),
                            ],
                            shape: BoxShape.circle),
                        child: Image.asset(ImageConstants.callCut),
                      ),
                    );
                  }),
            ],
          ),
          30.0.spaceY,
          ValueListenableBuilder(
              valueListenable: instanceCallDurationNotifier,
              builder: (BuildContext context, int value, Widget? child) {
              return ShadowContainer(
                height: 42,
                width: double.infinity,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                isShadow: false,
                offset: Offset(0, 0),
                backgroundColor: ColorConstants.whiteColor.withOpacity(0.2),
                shadowColor: ColorConstants.whiteColor.withOpacity(0.2),
                blurRadius: 4,
                spreadRadius: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.watch_later_outlined),
                    6.0.spaceX,
                    TitleLargeText(
                      title: Duration(seconds: instanceCallDurationNotifier.value).toTimeString(),
                      fontFamily: FontWeightEnum.w400.toInter,
                      titleTextAlign: TextAlign.center,
                      titleColor: ColorConstants.blackColor,
                      fontSize: 20,
                    ),
                  ],
                ),
              );
            }
          ),
        ],
      ).addAllPadding(20),
    );
  }
}
