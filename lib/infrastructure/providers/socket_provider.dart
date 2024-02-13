import 'dart:developer';

import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_status_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/commons/utils/value_notifier_utils.dart';
import 'package:mirl/ui/screens/instant_call_screen/arguments/instance_call_dialog_arguments.dart';
import 'package:mirl/ui/screens/video_call_screen/arguments/video_call_arguments.dart';
import 'package:uuid/uuid.dart';

class SocketProvider extends ChangeNotifier {

  ChangeNotifierProviderRef<SocketProvider> ref;

  SocketProvider(this.ref);

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
    socketListen.value = true;
  }

  Future<void> listenerEvent() async {
    try {
      FlutterCallkitIncoming.onEvent.listen((CallEvent? event) {
        log('Incoming:- $event');

        switch (event!.event) {
          case Event.actionCallIncoming:
          // TODO: received an incoming call
            log('ACTION_CALL_INCOMING');
            String value = jsonEncode(event.body['extra']);
            Map<String, dynamic> data = jsonDecode(value);
           /* extraResponseModel = ExtraResponseModel();
            extraResponseModel?.appointmentId = data['appointmentId'];*/
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
            /*log('extraResponseModel?.channelName====${extraResponseModel?.channelName}');
            if (extraResponseModel?.channelName == null) {
              setExtraParamsForCall(event);
              serviceStatusUpdate(
                  id: extraResponseModel?.appointmentId ?? '',
                  sessionType: (extraResponseModel?.isVideo ?? false) ? AppointmentSessionType.videoCall : AppointmentSessionType.audioCall,
                  serviceStatus: AppointmentServiceType.accepted);
            }*/
            break;
          case Event.actionCallDecline:
          // TODO: declined an incoming call
            log('ACTION_CALL_DECLINE');
          /*  serviceStatusUpdate(
                id: extraResponseModel?.appointmentId ?? '',
                sessionType: (extraResponseModel?.isVideo ?? false) ? AppointmentSessionType.videoCall : AppointmentSessionType.audioCall,
                serviceStatus: AppointmentServiceType.declined);*/

            break;
          case Event.actionCallEnded:
          // TODO: ended an incoming/outgoing call
            log('ACTION_CALL_ENDED');
           // log('extraResponseModel==============${extraResponseModel?.toJson()}');
            /*       serviceStatusUpdate(
                id: extraResponseModel?.appointmentId ?? '',
                sessionType: (extraResponseModel?.isVideo ?? false) ? AppointmentSessionType.videoCall : AppointmentSessionType.audioCall,
                serviceStatus: AppointmentServiceType.completed);*/
            break;
          case Event.actionCallTimeout:
          // TODO: missed an incoming call
            /*serviceStatusUpdate(
                id: extraResponseModel?.appointmentId ?? '',
                sessionType: (extraResponseModel?.isVideo ?? false) ? AppointmentSessionType.videoCall : AppointmentSessionType.audioCall,
                serviceStatus: AppointmentServiceType.timeout);*/
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
            print("CallReId");
            print(data['data']['callRequestId'].toString());
            SharedPrefHelper.saveCallRequestId(data['data']['callRequestId'].toString());
            instanceCallEnumNotifier.value = CallTypeEnum.requestWaiting;
            bgCallEndTrigger.value = 20;
          } else {
          }
        }
      });
    } catch (e) {
      Logger().d('instanceCallResponse====$e');
    }
  }

  void instanceCallListener() {
    try {
      String userId = SharedPrefHelper.getUserId.toString();
      socket?.on(AppConstants.requestCallReceived, (data) {
        Logger().d('instanceCallListener=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            if(data['data'].toString().isNotEmpty){
              instanceCallEnumNotifier.value = CallTypeEnum.receiverRequested;
              bgCallEndTrigger.value = 20;
              NavigationService.context.toPushNamed(RoutesConstants.instantCallRequestDialogScreen,
                  args: InstanceCallDialogArguments(
                    name: data['data']['userDetails']['userName'].toString(),
                   secondBtnColor: ColorConstants.yellowButtonColor,
                    onFirstBtnTap: () {
                      updateRequestStatusEmit(expertId: userId, callStatusEnum: CallStatusEnum.accept,
                          callRoleEnum: CallRoleEnum.expert, userId: data['data']['userDetails']['id'].toString());
                      NavigationService.context.toPop();
                      },
                    onSecondBtnTap: (){
                      updateRequestStatusEmit(expertId: userId, callStatusEnum: CallStatusEnum.decline,
                          callRoleEnum: CallRoleEnum.expert, userId: data['data']['userDetails']['id'].toString());
                      NavigationService.context.toPop();
                    },
                    image: data['data']['userDetails']['profile'].toString(), expertId: userId, userID: data['data']['userDetails']['id'].toString(),
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
              print("updateRequestReceived != 200");
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
            NavigationService.context.toPushNamed(RoutesConstants.videoCallScreen,
                args: VideoCallArguments(agoraChannelId: data['data']['channelCode'].toString(),
                    agoraToken: data['data']['agoraToken'].toString()));
          }
        }
      });
    } catch (e) {
      Logger().d('connectCallResponse====$e');
    }
  }

  void updateCallStatusEmit({required String status, required CallRoleEnum callRoleEnum}) {
    try {
      Logger().d('updateCallStatusEmit ==== Success');
      socket?.emit(AppConstants.updateConnectCallStatus, {
        AppConstants.callStatus: status,
        AppConstants.role: callRoleEnum.roleToNumber,
        AppConstants.callHistoryId: 1,
      });
    } catch (e) {
      Logger().d('updateCallStatusEmit====$e');
    }
  }

  void updateCallStatusResponse() {
    try {
      socket?.on(AppConstants.updateConnectCallStatusSent, (data) {
        Logger().d('updateCallStatusResponse=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {

          }
        }
      });
    } catch (e) {
      Logger().d('updateCallStatusResponse====$e');
    }
  }


  void updateCallStatusListener() {
    try {
      socket?.on(AppConstants.updateConnectCallStatusReceived, (data) {
        Logger().d('updateCallStatusListener=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {

          }
        }
      });
    } catch (e) {
      Logger().d('updateCallStatusListener====$e');
    }
  }

}