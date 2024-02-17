import 'dart:developer';

import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/enums/call_connect_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_timer_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/utils/value_notifier_utils.dart';
import 'package:mirl/infrastructure/models/common/extra_service_model.dart';
import 'package:mirl/ui/screens/instant_call_screen/arguments/instance_call_dialog_arguments.dart';
import 'package:mirl/ui/screens/video_call_screen/arguments/video_call_arguments.dart';
import 'package:uuid/uuid.dart';

class SocketProvider extends ChangeNotifier {

  ChangeNotifierProviderRef<SocketProvider> ref;

  SocketProvider(this.ref);

  ExtraResponseModel? extraResponseModel;

  void listenAllMethods(BuildContext context) {
    if (socketListen.value) {
      return;
    }
    updateSocketIdListener();
    instanceCallResponse();
    instanceCallListener();
    updateRequestStatusResponse();
    updateRequestStatusListener();
    connectCallResponse();
    updateCallStatusListener();
    updateCallStatusResponse();
    timerResponse();
    timerListener();
    socketListen.value = true;
  }

  Future<void> listenerEvent() async {
    try {
      FlutterCallkitIncoming.onEvent.listen((CallEvent? event) async {
        log('Incoming:- $event');

        switch (event!.event) {
          case Event.actionCallIncoming:
          // TODO: received an incoming call
            log('ACTION_CALL_INCOMING');
            String value = jsonEncode(event.body['extra']);
            Map<String, dynamic> data = jsonDecode(value);
            log("extra data: ${data.toString()}");
            extraResponseModel = ExtraResponseModel.fromJson(data);
            extraResponseModel?.callRoleEnum = CallRoleEnum.expert;
            notifyListeners();
            break;
          case Event.actionCallStart:
            log('ACTION_CALL_START');
            // TODO: started an outgoing call
            // TODO: show screen calling in Flutter
            break;
          case Event.actionCallAccept:
          // TODO: accepted an incoming call
          // TODO: show screen calling in Flutter
            log('ACTION_CALL_ACCEPT');
            callConnectNotifier.value = CallConnectStatusEnum.accepted;
            updateCallStatusEmit(status: 2, callRoleEnum: CallRoleEnum.expert, callHistoryId: extraResponseModel?.callHistoryId ?? '');
            break;
          case Event.actionCallDecline:
          // TODO: declined an incoming call
            log('ACTION_CALL_DECLINE');
            callConnectNotifier.value = CallConnectStatusEnum.declined;
            instanceRequestTimerNotifier.value = - 1;
            instanceRequestTimerNotifier.removeListener(() { });
            await updateCallStatusEmit(status: 3, callRoleEnum: CallRoleEnum.expert,callHistoryId: extraResponseModel?.callHistoryId ?? '');
            break;
          case Event.actionCallEnded:
          // TODO: ended an incoming/outgoing call
            log('ACTION_CALL_ENDED');
            if(callConnectNotifier.value != CallConnectStatusEnum.completed){
              callConnectNotifier.value = CallConnectStatusEnum.completed;
              updateCallStatusEmit(status: 6, callRoleEnum: CallRoleEnum.expert,callHistoryId: extraResponseModel?.callHistoryId ?? '');
            }
            break;
          case Event.actionCallTimeout:
            if (callConnectNotifier.value != CallConnectStatusEnum.timeout) {
              callConnectNotifier.value = CallConnectStatusEnum.timeout;
              updateCallStatusEmit(
                  status: 4, callRoleEnum: CallRoleEnum.expert, callHistoryId: extraResponseModel?.callHistoryId ?? '');
            }
            break;
          case Event.actionDidUpdateDevicePushTokenVoip:
          // TODO: Handle this case.
            break;
          case Event.actionCallCallback:
          // TODO: Handle this case.
            break;
          case Event.actionCallToggleHold:
          // TODO: Handle this case.
            break;
          case Event.actionCallToggleMute:
          // TODO: Handle this case.
            break;
          case Event.actionCallToggleDmtf:
          // TODO: Handle this case.
            break;
          case Event.actionCallToggleGroup:
          // TODO: Handle this case.
            break;
          case Event.actionCallToggleAudioSession:
          // TODO: Handle this case.
            break;
          case Event.actionCallCustom:
          // TODO: Handle this case.
            break;
        }
      });
    } catch (e) {
      log(e.toString());
    }
  }

  void updateSocketIdListener() {
    try {
      socket?.on(AppConstants.updateSocketIdResponse, (data) {
        Logger().d('updateSocketIdListener=====${data.toString()}');
      });
    } catch (e) {
      Logger().d('updateSocketIdListener====$e');
    }
  }

  void instanceCallRequestEmit({required String expertId}) {
    try {
      String userId = SharedPrefHelper.getUserId.toString();
      socket?.emit(AppConstants.requestCallEmit, {
        AppConstants.expertId: expertId,
        AppConstants.userId: userId,
        AppConstants.requestType: 1,
        AppConstants.time: DateTime.now().toUtc().toString()
      });
    } catch (e) {
      Logger().d('instanceCallRequestEmit====$e');
    }
  }

  void instanceCallResponse() {
    try {
      socket?.on(AppConstants.requestCallSend, (data) {
        Logger().d('instanceCallResponse=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            SharedPrefHelper.saveCallRequestId(data['data']['callRequestId'].toString());
            instanceCallEnumNotifier.value = CallTypeEnum.requestWaiting;
            instanceRequestTimerNotifier.value = 120;
          } else {
            FlutterToast().showToast(msg: data['message'].toString());
          }
        }
      });
    } catch (e) {
      Logger().d('instanceCallResponse====$e');
    }
  }

  void instanceCallListener() {
    try {
      socket?.on(AppConstants.requestCallReceived, (data) {
        Logger().d('instanceCallListener=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            if(data['data'].toString().isNotEmpty){
              instanceCallEnumNotifier.value = CallTypeEnum.receiverRequested;
              //bgCallEndTrigger.value = 20;
              //instanceRequestTimerNotifier.value = 120;


              /// This is call receiver (Expert) side.
              NavigationService.context.toPushNamed(RoutesConstants.instantCallRequestDialogScreen,
                  args: InstanceCallDialogArguments(
                    name: data['data']['userDetails']['userName'].toString(),
                   secondBtnColor: ColorConstants.yellowButtonColor,
                    onFirstBtnTap: () {
                      updateRequestStatusEmit(userId: data['data']['userDetails']['id'].toString(), callStatusEnum: CallStatusEnum.accept,
                          callRoleEnum: CallRoleEnum.expert, expertId: data['data']['expertId'].toString());
                      NavigationService.context.toPop();
                      },
                    onSecondBtnTap: (){
                      updateRequestStatusEmit(expertId: data['data']['expertId'].toString(), callStatusEnum: CallStatusEnum.decline,
                          callRoleEnum: CallRoleEnum.expert, userId: data['data']['userDetails']['id'].toString());
                      NavigationService.context.toPop();
                    },
                    image: data['data']['userDetails']['userProfile'].toString(),
                    expertId: data['data']['expertId'].toString(),
                    userID: data['data']['userDetails']['id'].toString(),
                  ));
            }
          }
        }

      });
    } catch (e) {
      Logger().d('instanceCallListener====$e');
    }
  }


  void updateRequestStatusEmit({required String expertId,required String userId,required CallStatusEnum callStatusEnum, required CallRoleEnum callRoleEnum}) {
    try {
      Logger().d('updateRequestStatusEmit==== Success');
      String callRequestId = SharedPrefHelper.getCallRequestId.toString();
      Logger().d("callRequestId on from pref $callRequestId");
      socket?.emit(AppConstants.updateRequestStatus, {
        AppConstants.expertId: expertId,
        AppConstants.userId: userId,
        AppConstants.role: callRoleEnum.roleToNumber,
        AppConstants.callStatus: callStatusEnum.callStatusToNumber,
        AppConstants.callRequestId: callRequestId,
        AppConstants.time: DateTime.now().toUtc().toString()
      });
    } catch (e) {
      Logger().d('updateRequestStatusEmit====$e');
    }
  }


  void updateRequestStatusResponse() {
    try {
      socket?.on(AppConstants.updateRequestSend, (data) {
        Logger().d('updateRequestStatusResponse=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {

          }
        }
      });
    } catch (e) {
      Logger().d('updateRequestStatusResponse====$e');
    }
  }


  void updateRequestStatusListener() {
    try {
      socket?.on(AppConstants.updateRequestReceived, (data) {
        Logger().d('updateRequestStatusListener=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            if(data['data']['userId'].toString() == SharedPrefHelper.getUserId.toString()){
              if(data['data']['status'].toString() == '2'){
                instanceCallEnumNotifier.value = CallTypeEnum.requestApproved;
              } else if (data['data']['status'].toString() == '3'){
                instanceCallEnumNotifier.value = CallTypeEnum.requestDeclined;
              }
            } else {
              if(data['data']['expertId'].toString() == SharedPrefHelper.getUserId.toString()){
                if((data['data']['status'].toString() == '4' || (data['data']['status'].toString() == '5')
                 && (instanceCallEnumNotifier.value == CallTypeEnum.receiverRequested))) {
                  NavigationService.context.toPop();
                }
              }
              /// Call emit from here

            }
          }
        }
      });
    } catch (e) {
      Logger().d('updateRequestStatusListener====$e');
    }
  }

  void connectCallEmit({required String expertId}) {
    try {
      Logger().d('connectCallEmit ==== Success');
      String userId = SharedPrefHelper.getUserId.toString();
      socket?.emit(AppConstants.connectCall, {
        AppConstants.expertId: expertId,
        AppConstants.userId: userId,
        AppConstants.uuid : const Uuid().v4().toString(),
        AppConstants.isVideo: "true",
        AppConstants.callRequestId: SharedPrefHelper.getCallRequestId.toString(),

      });
    } catch (e) {
      Logger().d('connectCallEmit====$e');
    }
  }

  void connectCallResponse() {
    try {
      socket?.on(AppConstants.connectCallResponse, (data) {
        Logger().d('connectCallResponse=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            callConnectNotifier.value == CallConnectStatusEnum.ringing;
            if(isSocketConnected){
             extraResponseModel = ExtraResponseModel.fromJson(data['data']);
             extraResponseModel?.callRoleEnum = CallRoleEnum.user;
              NavigationService.context.toPushNamed(RoutesConstants.videoCallScreen,
                  args: VideoCallArguments(agoraChannelId: data['data']['channelCode'].toString(),
                      agoraToken: data['data']['agoraToken'].toString()));

            }

          }
        }
      });
    } catch (e) {
      Logger().d('connectCallResponse====$e');
    }
  }

  Future<void> updateCallStatusEmit({required int status, required CallRoleEnum callRoleEnum, required String callHistoryId}) async {
    try {
      Logger().d('updateCallStatusEmit ==== Success');
      socket?.emit(AppConstants.updateConnectCallStatus, {
        AppConstants.callStatus: status,
        AppConstants.role: callRoleEnum.roleToNumber,
        AppConstants.callHistoryId: callHistoryId,
      });
    } catch (e) {
      Logger().d('updateCallStatusEmit====$e');
    }
  }

  void updateCallStatusResponse() {
    try {
      socket?.on(AppConstants.updateConnectCallStatusSent, (data) async {
        Logger().d('updateCallStatusResponse=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            if(data['data']['status'].toString() == '2'){
              callConnectNotifier.value = CallConnectStatusEnum.accepted;
              /// accept
              if(isSocketConnected){
                NavigationService.context.toPushNamed(RoutesConstants.videoCallScreen,
                    args: VideoCallArguments(agoraChannelId: extraResponseModel?.channelCode.toString() ?? '',
                        agoraToken: extraResponseModel?.agoraToken.toString() ?? ''));
              }
            } else if (data['data']['status'].toString() == '3'){
              /// decline
              callConnectNotifier.value = CallConnectStatusEnum.declined;
            }  else if (data['data']['status'].toString() == '4'){
              /// time out
              NavigationService.context.toPop();
            }  if(data['data']['status'].toString() == '5'){
              /// cancelled
              callConnectNotifier.value = CallConnectStatusEnum.cancelled;
              instanceCallDurationNotifier.value = int.parse(extraResponseModel?.instantCallSeconds ?? "0") + 1;
              instanceCallDurationNotifier.removeListener(() { });
              if(data['data']['userId'].toString() == SharedPrefHelper.getUserId.toString()) {
                NavigationService.context.toPop();
                NavigationService.context.toPop();
              }
            } if(data['data']['status'].toString() == '6') {
              /// completed
               callConnectNotifier.value = CallConnectStatusEnum.completed;

              if(data['data']['userId'].toString() == SharedPrefHelper.getUserId.toString()) {
                NavigationService.context.toPop();
                NavigationService.context.toPop();
              } else {
                await FlutterCallkitIncoming.endAllCalls();
                NavigationService.context.toPop();
              }

               instanceCallDurationNotifier.value = int.parse(extraResponseModel?.instantCallSeconds ?? "0") + 1;
               instanceCallDurationNotifier.removeListener(() { });
            }

          } else {
            FlutterToast().showToast(msg: data['message'].toString());

          }
        }
      });
    } catch (e) {
      Logger().d('updateCallStatusResponse====$e');
    }
  }


  void updateCallStatusListener() {
    try {
      socket?.on(AppConstants.updateConnectCallStatusReceived, (data) async {
        Logger().d('updateCallStatusListener=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            if(data['data']['status'].toString() == '2'){
              callConnectNotifier.value = CallConnectStatusEnum.accepted;
              /// accept
            } else if (data['data']['status'].toString() == '3'){
              /// decline
              /// This decline listen in user side always
              callConnectNotifier.value = CallConnectStatusEnum.declined;
              FlutterToast().showToast(msg: "Call decline by expert");
              instanceRequestTimerNotifier.value = - 1;
              instanceRequestTimerNotifier.removeListener(() {});
              NavigationService.context.toPop();
              NavigationService.context.toPop();

            }  else if (data['data']['status'].toString() == '4'){
              /// time out

              NavigationService.context.toPop();

            }  if(data['data']['status'].toString() == '5'){
              /// cancelled
              callConnectNotifier.value = CallConnectStatusEnum.cancelled;
              /// Expert not receive call from call kit and user cut call .
              await FlutterCallkitIncoming.endAllCalls();
            } if(data['data']['status'].toString() == '6'){
              /// completed
              callConnectNotifier.value = CallConnectStatusEnum.completed;

              if(data['data']['expertId'].toString() == SharedPrefHelper.getUserId.toString()) {
                /// Call cut by user and listen in expert side so pop the screen and cut call kit call also
                NavigationService.context.toPop();
                await FlutterCallkitIncoming.endAllCalls();
              } else {
                NavigationService.context.toPop();
                NavigationService.context.toPop();
              }
              instanceCallDurationNotifier.value = int.parse(extraResponseModel?.instantCallSeconds ?? "0") + 1;
              instanceCallDurationNotifier.removeListener(() { });
            }

          }
        }
      });
    } catch (e) {
      Logger().d('updateCallStatusListener====$e');
    }
  }

  Future<void> timerEmit({required int userId, required int expertId, required CallRoleEnum callRoleEnum, required int timer, required CallTimerEnum timerType}) async {
    try {
      Logger().d('timerEmit ==== Success');
      socket?.emit(AppConstants.getTime, {
        AppConstants.userId: userId,
        AppConstants.expertId: expertId,
        AppConstants.role: callRoleEnum.roleToNumber,
        AppConstants.time: timer,
        AppConstants.requestType: 1,
        AppConstants.timerType : timerType.callTimerToString
      });
    } catch (e) {
      Logger().d('timerEmit====$e');
    }
  }

  void timerResponse() {
    try {
      socket?.on(AppConstants.timeSend, (data) {
        Logger().d('timerResponse=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {

          }
        }
      });
    } catch (e) {
      Logger().d('timerResponse====$e');
    }
  }

  void timerListener() {
    try {
      socket?.on(AppConstants.timeReceived, (data) {
        Logger().d('timerListener=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            if(data['data']['timerType'].toString() == CallTimerEnum.call.name) {
              if(data['data']['time'].toString() !=  extraResponseModel?.instantCallSeconds.toString()){
                instanceCallDurationNotifier.value = int.parse(data['data']['time'].toString());
              } else {
              }
            } else {
              instanceRequestTimerNotifier.value = int.parse(data['data']['time'].toString());
            }
          }
        }
      });
    } catch (e) {
      Logger().d('timerListener====$e');
    }
  }



}