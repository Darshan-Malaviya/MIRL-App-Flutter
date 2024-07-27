import 'dart:async';

import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_connect_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_timer_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/extra_service_model.dart';
import 'package:mirl/infrastructure/providers/call_provider.dart';
import 'package:mirl/infrastructure/services/agora_service.dart';
import 'package:mirl/ui/common/network_image/circle_netwrok_image.dart';
import 'package:mirl/ui/screens/video_call_screen/arguments/video_call_arguments.dart';
import 'package:mirl/ui/screens/video_call_screen/widget/video_call_bottomsgeet_widget.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class VideoCallScreen extends ConsumerStatefulWidget {
final VideoCallArguments arguments;
  const VideoCallScreen({super.key,required this.arguments});

  @override
  ConsumerState<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends ConsumerState<VideoCallScreen> {
  Future<void> instanceCallTimerFunction() async {
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ExtraResponseModel? model = ref.read(socketProvider).extraResponseModel;
      if (instanceCallDurationNotifier.value <= (ref.read(callProvider).callDuration ?? 0)) {
        instanceCallDurationNotifier.value = instanceCallDurationNotifier.value + 1;
        if (model?.callRoleEnum == CallRoleEnum.expert) {
          ref.read(socketProvider).timerEmit(
                userId: int.parse((model?.userId.toString() ?? '')),
                expertIdList: [int.parse((model?.expertId.toString() ?? ''))],
                callRoleEnum: CallRoleEnum.expert,
                timer: instanceCallDurationNotifier.value,
                timerType: CallTimerEnum.call,
                requestType: widget.arguments.callType ?? 0,
              );
        }
        instanceCallTimerFunction();
      } else {
        if (callConnectNotifier.value != CallConnectStatusEnum.completed) {
          if (instanceCallDurationNotifier.value >= (ref.read(callProvider).callDuration ?? 0)) {
            callConnectNotifier.value = CallConnectStatusEnum.completed;
            ref.read(socketProvider).updateCallStatusEmit(
                status: CallStatusEnum.completedCall, callRoleEnum: CallRoleEnum.user, callHistoryId: model?.callHistoryId ?? '');
          }
        }
      }
    }
  }

  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(callProvider).clearAllValue();
      ref.read(callProvider).getCallDuration();
      ref.read(callProvider).initVideoCallAgora(channelId: widget.arguments.agoraChannelId, token: widget.arguments.agoraToken);
      bool isLocalUserJoin = ref.watch(callProvider).localUserJoined;
      bool isExpert = (ref.watch(socketProvider).extraResponseModel?.callRoleEnum == CallRoleEnum.expert);
      instanceCallDurationNotifier.addListener(() {
        // if(ref.watch(callProvider).remoteUid != null){
          if(isExpert){
            if(instanceCallDurationNotifier.value == 0) {
              instanceCallTimerFunction();
            }
          // }
        }
      });
    });


  }

  @override
  void dispose() {
    if (isSocketConnected) {
      engine.leaveChannel();
      engine.release();
    }
    instanceCallDurationNotifier.value = 120;
    instanceCallDurationNotifier.removeListener(() { });
    instanceRequestTimerNotifier.dispose();

    //ref.read(callProvider).disposeCallDuration();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final callWatch = ref.watch(callProvider);


    return PopScope(
      canPop: false,
      child: Scaffold(
        body: ValueListenableBuilder(
          valueListenable: changeVideoCallView,
          builder: (BuildContext context, bool uiUpdate, Widget? mainChild) {
            return ValueListenableBuilder(
              valueListenable: callConnectNotifier,
              builder: (BuildContext context, CallConnectStatusEnum value, Widget? child) {
                return Stack(
                  children: [
                    /*AgoraVideoView(
                      controller: VideoViewController(
                        rtcEngine: engine,
                        canvas: const VideoCanvas(uid: 0, mirrorMode: VideoMirrorModeType.videoMirrorModeAuto),
                      ),
                    ),*/
                        if (value == CallConnectStatusEnum.ringing) ...[
                          Center(
                              child: _waitingView(
                                  title: LocaleKeys.startingYourCall.tr(),
                                  color: ColorConstants.yellowButtonColor.withOpacity(0.2),
                                  textColor: ColorConstants.yellowButtonColor))
                        ] else ...[
                          if (callWatch.isSwipeUser) ...[
                            _remoteUserAgoraView(remotId: callWatch.remoteUid ?? -1, callProvider: callWatch)
                          ] else ...[
                            _localUserAgoraView(callProvider: callWatch)
                          ],
                        ],
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
                              color: ColorConstants.primaryColor.withOpacity(0.3),
                              borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            ),
                                  child: callWatch.isSwipeUser
                                      ? _localUserAgoraView(callProvider: callWatch)
                                      : _remoteUserAgoraView(remotId: callWatch.remoteUid ?? -1, callProvider: callWatch)),
                          if(!callWatch.isRemoteMicOn)...[
                            Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(offset: Offset(0, 0), color: ColorConstants.whiteColor.withOpacity(0.2), spreadRadius: 1, blurRadius: 5),
                                ],
                              ),
                              child: Image.asset(ImageConstants.voiceOff).addAllPadding(8),
                            )
                          ]

                        ],
                      ).addAllPadding(20),
                    )
                  ],
                );
              }
            );
          }
        ),
      ),
    );
  }

  Widget _localUserAgoraView({required CallProvider callProvider}){
    ExtraResponseModel? extraResponseModel = ref.watch(socketProvider).extraResponseModel;
  //  UserData  _userData = UserData.fromJson(jsonDecode(SharedPrefHelper.getUserData.toString()));
    if (callProvider.localUserJoined) {
      if(callProvider.isLocalVideoOn){
        return  InkWell(
          onTap: (){
            if(callProvider.isSwipeUser){
              callProvider.swipeUser();
            } else {
              callProvider.visibleBottomSheet();
            }
          },
          child: AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: engine,
              canvas: const VideoCanvas(uid: 0, mirrorMode: VideoMirrorModeType.videoMirrorModeAuto),
            ),
          ),
        );
      } else {
        return Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorConstants.yellowButtonColor.withOpacity(0.3),
          child: Center(
            child: CircleNetworkImageWidget(
              imageURL: CallRoleEnum.user == extraResponseModel?.callRoleEnum
                  ? (extraResponseModel?.userProfile != "" && extraResponseModel?.userProfile != null
                      ? extraResponseModel!.userProfile!
                      : ImageConstants.mysteryImage)
                  : (extraResponseModel?.expertProfile != "" && extraResponseModel?.expertProfile != null
                      ? extraResponseModel!.expertProfile!
                      : ImageConstants.mysteryImage),
              radius: callProvider.isSwipeUser ? 30 : 40,
            ),
          ),
        );
      }
    } else {
      return Positioned(
          top: MediaQuery.of(context).size.height / 3,
          left: 20,
          right: 20,
          child: _waitingView(
              title: 'Connecting..',
              color: ColorConstants.yellowButtonColor.withOpacity(0.2),
              textColor: ColorConstants.yellowButtonColor));
    }

  }

  Widget _remoteUserAgoraView({required int remotId, required CallProvider callProvider}){
    ExtraResponseModel? extraResponseModel = ref.watch(socketProvider).extraResponseModel;
    if(callProvider.remoteUid != null){
      if(callProvider.isRemoteVideoOn){
        return InkWell(
          onTap: () {
            if(!callProvider.isSwipeUser){
              callProvider.swipeUser();
            } else {
              callProvider.visibleBottomSheet();
            }
          },
          child: AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: engine,
              canvas: VideoCanvas(uid: remotId, mirrorMode: VideoMirrorModeType.videoMirrorModeEnabled, view: 0),
              connection: RtcConnection(
                  channelId: widget.arguments.agoraChannelId
                //  channelId: "Mirl_CallToken"
                // channelId: "4_1707890211629"
              ),
            ),
          ),
        );
      } else {
        return Container(
          color: ColorConstants.primaryColor.withOpacity(0.3),
          child: Center(
            child: CircleNetworkImageWidget(
              imageURL: CallRoleEnum.user == extraResponseModel?.callRoleEnum
                  ? (extraResponseModel?.expertProfile != "" && extraResponseModel?.expertProfile != null
                      ? extraResponseModel!.userProfile!
                      : ImageConstants.mysteryImage)
                  : (extraResponseModel?.userProfile != "" && extraResponseModel?.userProfile != null
                      ? extraResponseModel!.expertProfile!
                      : ImageConstants.mysteryImage),
              radius: callProvider.isSwipeUser ? 60 : 30,
            ),
          ),
        );
      }
    } else {
      return Center(child: _waitingView(title: 'Waiting', color: ColorConstants.primaryColor.withOpacity(0.2)));
    }
  }

  Widget _waitingView({required String title, required Color color, Color? textColor}) {
    return Center(
      child: RippleAnimation(
        color: color,
        delay: const Duration(milliseconds: 300),
        repeat: true,
        minRadius: 75,
        ripplesCount: 6,
        duration: const Duration(milliseconds: 6 * 300),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TitleMediumText(
              titleTextAlign: TextAlign.start,
              title: title,
              titleColor:  textColor ?? ColorConstants.primaryColor,
              maxLine: 3,
            ),
          ],
        ),
      ),
    );
  }
}
