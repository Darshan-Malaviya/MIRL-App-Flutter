import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_callkit_incoming/entities/call_event.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:mirl/generated/locale_keys.g.dart';
import 'package:mirl/infrastructure/commons/enums/call_connect_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_timer_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/extra_service_model.dart';
import 'package:mirl/infrastructure/models/common/instance_call_emits_response_model.dart';
import 'package:mirl/ui/screens/instant_call_screen/arguments/instance_call_dialog_arguments.dart';
import 'package:mirl/ui/screens/multi_call_screen/arguments/multi_call_connect_request_arguments.dart';
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
    multiConnectRequestResponse();
    multiConnectRequestListener();
    multiConnectStatusListener();
    multiConnectStatusResponse();
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
            updateCallStatusEmit(status: CallStatusEnum.acceptCall, callRoleEnum: CallRoleEnum.expert, callHistoryId: extraResponseModel?.callHistoryId ?? '');
            break;
          case Event.actionCallDecline:
          // TODO: declined an incoming call
            log('ACTION_CALL_DECLINE');
            callConnectNotifier.value = CallConnectStatusEnum.declined;
            instanceRequestTimerNotifier = ValueNotifier<int>(120);
            instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
            await updateCallStatusEmit(status: CallStatusEnum.declineCall, callRoleEnum: CallRoleEnum.expert,callHistoryId: extraResponseModel?.callHistoryId ?? '');
            break;
          case Event.actionCallEnded:
          // TODO: ended an incoming/outgoing call
            log('ACTION_CALL_ENDED');
            if(callConnectNotifier.value != CallConnectStatusEnum.completed){
              callConnectNotifier.value = CallConnectStatusEnum.completed;
              updateCallStatusEmit(status: CallStatusEnum.completedCall, callRoleEnum: CallRoleEnum.expert,callHistoryId: extraResponseModel?.callHistoryId ?? '');
            }
            break;
          case Event.actionCallTimeout:
            if (callConnectNotifier.value != CallConnectStatusEnum.timeout) {
              callConnectNotifier.value = CallConnectStatusEnum.timeout;
              updateCallStatusEmit(status: CallStatusEnum.timeoutCall,
                  callRoleEnum: CallRoleEnum.expert, callHistoryId: extraResponseModel?.callHistoryId ?? '');
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

  void instanceCallRequestEmit({required String expertId, required int requestedDuration}) {
    try {
      String userId = SharedPrefHelper.getUserId.toString();
      socket?.emit(AppConstants.requestCallEmit, {
        AppConstants.expertId: expertId,
        AppConstants.userId: userId,
        AppConstants.requestType: 1,
        AppConstants.time: DateTime.now().toUtc().toString(),
        AppConstants.requestedDuration: requestedDuration
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
            InstanceCallEmitsResponseModel model = InstanceCallEmitsResponseModel.fromJson(data);
            SharedPrefHelper.saveCallRequestId(model.data?.callRequestId.toString());
            allCallDurationNotifier.value = model.data?.requestedDuration ?? 0;
            instanceCallEnumNotifier.value = CallRequestTypeEnum.requestWaiting;
          } else {
            InstanceCallErrorModel model = InstanceCallErrorModel.fromJson(data);
            FlutterToast().showToast(msg: model.message?.first.toString());
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
              instanceCallEnumNotifier.value = CallRequestTypeEnum.receiverRequested;
              InstanceCallEmitsResponseModel model = InstanceCallEmitsResponseModel.fromJson(data);
              SharedPrefHelper.saveCallRequestId(model.data?.callRequestId.toString());
              allCallDurationNotifier.value = model.data?.requestedDuration ?? 0;

              /// This is call receiver (Expert) side.
              NavigationService.context.toPushNamed(RoutesConstants.instantCallRequestDialogScreen,
                  args: InstanceCallDialogArguments(
                    name: model.data?.userDetails?.userName.toString(),
                    onFirstBtnTap: () {
                      updateRequestStatusEmit(userId: model.data?.userDetails?.id.toString() ?? '', callStatusEnum: CallRequestStatusEnum.accept,
                          callRoleEnum: CallRoleEnum.expert, expertId: model.data?.expertId.toString() ?? '');
                      NavigationService.context.toPop();
                      },
                    onSecondBtnTap: (){
                      updateRequestStatusEmit(expertId: model.data?.expertId.toString() ?? '', callStatusEnum: CallRequestStatusEnum.decline,
                          callRoleEnum: CallRoleEnum.expert, userId: model.data?.userDetails?.id.toString() ?? '');
                      NavigationService.context.toPop();
                    },
                    image: model.data?.userDetails?.userProfile.toString(),
                    expertId: model.data?.expertId.toString() ?? '',
                    userID: model.data?.userDetails?.id.toString() ?? '',
                  ));
            }
          } else {
            InstanceCallErrorModel model = InstanceCallErrorModel.fromJson(data);
            FlutterToast().showToast(msg: model.message?.first.toString());
          }
        }

      });
    } catch (e) {
      Logger().d('instanceCallListener====$e');
    }
  }


  void updateRequestStatusEmit({required String expertId,required String userId,required CallRequestStatusEnum callStatusEnum, required CallRoleEnum callRoleEnum}) {
    try {
      Logger().d('updateRequestStatusEmit==== Success');
      String callRequestId = SharedPrefHelper.getCallRequestId.toString();
      Logger().d("callRequestId on from pref $callRequestId");
      socket?.emit(AppConstants.updateRequestStatus, {
        AppConstants.expertId: expertId,
        AppConstants.userId: userId,
        AppConstants.role: callRoleEnum.roleToNumber,
        AppConstants.callStatus: callStatusEnum.callRequestStatusToNumber,
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
            InstanceCallEmitsResponseModel model = InstanceCallEmitsResponseModel.fromJson(data);
            if(model.data?.status.toString() == '4'){
              /// time out status
              if(model.data?.userId.toString() == SharedPrefHelper.getUserId.toString()){
               // NavigationService.context.toPop();
              }
            }
          } else {
            InstanceCallErrorModel model = InstanceCallErrorModel.fromJson(data);
            FlutterToast().showToast(msg: model.message?.first.toString());
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
          if (data['statusCode'].toString() == "200") {
            InstanceCallEmitsResponseModel model = InstanceCallEmitsResponseModel.fromJson(data);
            if(model.data?.userId.toString() == SharedPrefHelper.getUserId.toString()){
              /// user side
              if(model.data?.status.toString() == '2'){
                instanceCallEnumNotifier.value = CallRequestTypeEnum.requestApproved;
              } else if (model.data?.status.toString() == '3'){
                instanceCallEnumNotifier.value = CallRequestTypeEnum.requestDeclined;
              }
            } else {
              ///  on expert side
              if(model.data?.expertId.toString() == SharedPrefHelper.getUserId.toString()){

                if((model.data?.status.toString() == '4'
                 && (instanceCallEnumNotifier.value == CallRequestTypeEnum.receiverRequested))) {
                  instanceCallEnumNotifier.value = CallRequestTypeEnum.requestTimeout;
                  if (activeRoute.value == RoutesConstants.instantCallRequestDialogScreen) {
                    NavigationService.context.toPop();
                  }

                } else if(( (model.data?.status.toString() == '5')
                    && (instanceCallEnumNotifier.value == CallRequestTypeEnum.receiverRequested))) {
                  if (activeRoute.value == RoutesConstants.instantCallRequestDialogScreen) {
                    NavigationService.context.toPop();
                  }

                }

              }
              /// Call emit from here

            }
          } else {
            InstanceCallErrorModel model = InstanceCallErrorModel.fromJson(data);
            FlutterToast().showToast(msg: model.message?.first.toString());
          }
        }
      });
    } catch (e) {
      Logger().d('updateRequestStatusListener====$e');
    }
  }


  /// For schedule call pass call-history id from upcoming appointment list
  void connectCallEmit({required String expertId, String? callRequestId}) {
    try {
      Logger().d('connectCallEmit ==== Success');
      String userId = SharedPrefHelper.getUserId.toString();
      socket?.emit(AppConstants.connectCall, {
        AppConstants.expertId: expertId,
        AppConstants.userId: userId,
        AppConstants.uuid : const Uuid().v4().toString(),
        AppConstants.isVideo: "true",
        AppConstants.callRequestId: callRequestId ?? SharedPrefHelper.getCallRequestId.toString(),

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
                  args: VideoCallArguments(agoraChannelId: extraResponseModel?.channelCode.toString() ?? '',
                      agoraToken: extraResponseModel?.agoraToken.toString() ?? '', callType: int.parse(extraResponseModel?.requestType ?? "0")));

            }

          } else {
            InstanceCallErrorModel model = InstanceCallErrorModel.fromJson(data);
            FlutterToast().showToast(msg: model.message?.first.toString());
          }
        }
      });
    } catch (e) {
      Logger().d('connectCallResponse====$e');
    }
  }

  Future<void> updateCallStatusEmit({required CallStatusEnum status, required CallRoleEnum callRoleEnum, required String callHistoryId}) async {
    try {
      Logger().d('updateCallStatusEmit ==== Success');
      socket?.emit(AppConstants.updateConnectCallStatus, {
        AppConstants.callStatus: status.callRequestStatusToNumber,
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

          if (data['statusCode'].toString() == "200") {
            InstanceCallEmitsResponseModel model = InstanceCallEmitsResponseModel.fromJson(data);
            if(model.data?.status.toString() == '2'){
              callConnectNotifier.value = CallConnectStatusEnum.accepted;
              /// accept
              if(isSocketConnected){
                NavigationService.context.toPushNamed(RoutesConstants.videoCallScreen,
                    args: VideoCallArguments(agoraChannelId: extraResponseModel?.channelCode.toString() ?? '',
                        agoraToken: extraResponseModel?.agoraToken.toString() ?? '', callType: model.data?.requestType ?? 0));
              }
            } else if (model.data?.status.toString() == '3'){
              /// decline
              callConnectNotifier.value = CallConnectStatusEnum.declined;
              instanceRequestTimerNotifier = ValueNotifier<int>(120);
              instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);

            }  else if (model.data?.status.toString() == '4'){
              /// time out
             /// When expert not accept ant nor decline phone that time from call kit time out emit called and get response on expert side here.
            }  if(model.data?.status.toString() == '5'){
              /// cancelled
              callConnectNotifier.value = CallConnectStatusEnum.cancelled;
              instanceRequestTimerNotifier = ValueNotifier<int>(120);
              instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
              if(model.data?.userId.toString().toString() == SharedPrefHelper.getUserId.toString()) {
                if(activeRoute.value == RoutesConstants.videoCallScreen){
                  NavigationService.context.toPop();
                  NavigationService.context.toPop();
                }
              }
            } if(model.data?.status.toString() == '6') {
              /// completed
               callConnectNotifier.value = CallConnectStatusEnum.completed;
               if(activeRoute.value == RoutesConstants.videoCallScreen){
                 if(model.data?.userId.toString() == SharedPrefHelper.getUserId.toString()) {
                   if(activeRoute.value == RoutesConstants.videoCallScreen){
                     NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.callFeedbackScreen,
                         args: int.parse(extraResponseModel?.callHistoryId ?? ''));
                   }
                 } else {
                   await FlutterCallkitIncoming.endAllCalls();
                   NavigationService.context.toPop();
                 }
               }
               instanceRequestTimerNotifier = ValueNotifier<int>(120);
               instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
            }

          } else {
            InstanceCallErrorModel model = InstanceCallErrorModel.fromJson(data);
            FlutterToast().showToast(msg: model.message?.first.toString());

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
            InstanceCallEmitsResponseModel model = InstanceCallEmitsResponseModel.fromJson(data);
            if (model.data?.status.toString() == '2') {
              callConnectNotifier.value = CallConnectStatusEnum.accepted;

              /// accept
            } else if (data['data']['status'].toString() == '3') {
              /// decline
              /// This decline listen in user side always
              callConnectNotifier.value = CallConnectStatusEnum.declined;
              FlutterToast().showToast(msg: LocaleKeys.theExpertHasDeclinedYourCall.tr());
              instanceRequestTimerNotifier = ValueNotifier<int>(120);
              instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
              if(activeRoute.value == RoutesConstants.videoCallScreen){
                NavigationService.context.toPop();
                NavigationService.context.toPop();
              }
            } else if (model.data?.status.toString() == '4') {
              /// time out
              if (activeRoute.value == RoutesConstants.instantCallRequestDialogScreen || activeRoute.value == RoutesConstants.videoCallScreen) {
                FlutterToast().showToast(msg: LocaleKeys.expertNotResponding.tr());
                NavigationService.context.toPop();
              }
            }
            if (model.data?.status.toString() == '5') {
              /// cancelled
              if (activeRoute.value == RoutesConstants.instantCallRequestDialogScreen) {
                callConnectNotifier.value = CallConnectStatusEnum.cancelled;

                /// Expert not receive call from call kit and user cut call .
                await FlutterCallkitIncoming.endAllCalls();
              }
            }
            if (model.data?.status.toString() == '6') {
              /// completed
              callConnectNotifier.value = CallConnectStatusEnum.completed;
              if(activeRoute.value == RoutesConstants.videoCallScreen){
                if (model.data?.expertId.toString() == SharedPrefHelper.getUserId.toString()) {
                  /// Call cut by user and listen in expert side so pop the screen and cut call kit call also
                  NavigationService.context.toPop();
                  await FlutterCallkitIncoming.endAllCalls();
                } else {
                  NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.callFeedbackScreen,
                      args: int.parse(extraResponseModel?.callHistoryId ?? ''));
                }
              }
              instanceRequestTimerNotifier = ValueNotifier<int>(120);
              instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
            }
          } else {
            InstanceCallErrorModel model = InstanceCallErrorModel.fromJson(data);
            FlutterToast().showToast(msg: model.message?.first.toString());
          }
          }
      });
    } catch (e) {
      Logger().d('updateCallStatusListener====$e');
    }
  }

  Future<void> timerEmit({required int userId,
      required List<int> expertIdList,
      required CallRoleEnum callRoleEnum,
      required int timer,
      required CallTimerEnum timerType,
      required int requestType}) async {
    try {
      socket?.emit(AppConstants.getTime, {
        AppConstants.userId: userId,
        AppConstants.expertIds: expertIdList,
        AppConstants.role: callRoleEnum.roleToNumber,
        AppConstants.time: timer,
        AppConstants.requestType: requestType,
        AppConstants.timerType: timerType.callTimerToString
      });
    } catch (e) {
      Logger().d('timerEmit====$e');
    }
  }

  void timerResponse() {
    try {
      socket?.on(AppConstants.timeSend, (data) {
       // Logger().d('timerResponse=====${data.toString()}');
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
      socket?.on(AppConstants.timeReceived, (data)  async {
       // Logger().d('timerListener=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            InstanceCallEmitsResponseModel model = InstanceCallEmitsResponseModel.fromJson(data);

            if(model.data?.timerType.toString() == CallTimerEnum.call.name) {
              if(model.data?.time.toString() !=  extraResponseModel?.requestedDuration.toString()){
                instanceCallDurationNotifier.value = int.parse(model.data?.time.toString() ?? '');
              }
            } else if(model.data?.timerType.toString() == CallTimerEnum.request.name){
              instanceRequestTimerNotifier.value = int.parse(model.data?.time.toString() ?? '');
            }  else if(model.data?.timerType.toString() == CallTimerEnum.multiRequest.name){
              multiRequestTimerNotifier.value = int.parse(model.data?.time.toString() ?? '');
            } else {
              multiRequestTimerNotifier.value = int.parse(model.data?.time.toString() ?? '');
            }
          }
        }
      });
    } catch (e) {
      Logger().d('timerListener====$e');
    }
  }


  void multiConnectRequestEmit({required List<int> expertIdsList,required int requestedDuration}) {
    try {
      Logger().d('multiConnectRequestEmit ==== Success');
      String userId = SharedPrefHelper.getUserId.toString();
      socket?.emit(AppConstants.multiConnectRequest, {
        AppConstants.expertIds: expertIdsList,
        AppConstants.userId: userId,
        AppConstants.time: DateTime.now().toUtc().toString(),
        AppConstants.requestedDuration: requestedDuration
      });
    } catch (e) {
      Logger().d('multiConnectRequestEmit====$e');
    }
  }


  void multiConnectRequestResponse() {
    try {
      socket?.on(AppConstants.multiConnectRequestSent, (data) {
        CustomLoading.progressDialog(isLoading: false);
        Logger().d('multiConnectRequestResponse=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            InstanceCallEmitsResponseModel model = InstanceCallEmitsResponseModel.fromJson(data);
            SharedPrefHelper.saveCallRequestId(model.data?.callRequestId.toString());
            allCallDurationNotifier.value = model.data?.requestedDuration ?? 0;
            multiConnectCallEnumNotifier.value = CallRequestTypeEnum.multiRequestWaiting;
            ref.read(multiConnectProvider).setAllExpertStatusAsWaitingOnRequestCall();
            /// TODO change it will 120;
            multiRequestTimerNotifier.value = 60;
          } else {
            InstanceCallErrorModel model = InstanceCallErrorModel.fromJson(data);
            FlutterToast().showToast(msg: model.message?.first.toString());
          }
        }
      });
    } catch (e) {
      Logger().d('multiConnectRequestSent====$e');
    }
  }

  void multiConnectRequestListener() {
    try {
      socket?.on(AppConstants.multiConnectRequestReceived, (data) {
        Logger().d('multiConnectRequestReceived=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            multiConnectCallEnumNotifier.value = CallRequestTypeEnum.multiReceiverRequested;
            InstanceCallEmitsResponseModel model = InstanceCallEmitsResponseModel.fromJson(data);
            SharedPrefHelper.saveCallRequestId(model.data?.callRequestId.toString());
            allCallDurationNotifier.value = model.data?.requestedDuration ?? 0;
            multiConnectRequestStatusNotifier.value = CallRequestStatusEnum.waiting;
            /// This is multi connect call receiver (Expert) side.
            NavigationService.context.toPushNamed(RoutesConstants.multiConnectCallDialogScreen,
                args: MultiConnectDialogArguments(
                  //expertList: model.data?.expertList,
                  userDetail: model.data?.userDetails,
                  onFirstBtnTap: () {
                    multiConnectStatusEmit( callStatusEnum: CallRequestStatusEnum.accept,
                        expertId: SharedPrefHelper.getUserId,
                        userId: model.data?.userDetails?.id.toString() ?? '',
                        callRoleEnum: CallRoleEnum.expert,
                        callRequestId: model.data?.callRequestId.toString() ?? '');
                    /// expert accept
                    NavigationService.context.toPop();
                  },
                  onSecondBtnTap: (){
                    /// expert decline
                    multiConnectStatusEmit( callStatusEnum: CallRequestStatusEnum.decline,
                        expertId: SharedPrefHelper.getUserId,
                        userId: model.data?.userDetails?.id.toString() ?? '',
                        callRoleEnum: CallRoleEnum.expert,
                        callRequestId: model.data?.callRequestId.toString() ?? '');
                    NavigationService.context.toPop();
                  },
                ));

          }
        }
      });
    } catch (e) {
      Logger().d('multiConnectRequestReceived====$e');
    }
  }

  void multiConnectStatusEmit({required String? expertId,required String userId,
    required CallRequestStatusEnum callStatusEnum, required CallRoleEnum callRoleEnum, required String callRequestId}) {
    try {
      Logger().d('multiConnectStatusEmit ==== Success');
      socket?.emit(AppConstants.multiConnectUpdateStatus, {
        AppConstants.expertId: expertId,
        AppConstants.userId: userId,
        AppConstants.role: callRoleEnum.roleToNumber,
        AppConstants.callStatus: callStatusEnum.callRequestStatusToNumber,
        AppConstants.callRequestId: callRequestId,
        AppConstants.time: DateTime.now().toUtc().toString()
      });
    } catch (e) {
      Logger().d('multiConnectStatusEmit====$e');
    }
  }


  void multiConnectStatusResponse() {
    try {
      socket?.on(AppConstants.multiConnectStatusSend, (data) {
        Logger().d('multiConnectStatusSend=====${data.toString()}');
        chooseMultiConnectExpert.value = false;
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            InstanceCallEmitsResponseModel model = InstanceCallEmitsResponseModel.fromJson(data);
            if(model.data?.expertList?.isNotEmpty ?? false) {
              ref.read(multiConnectProvider).changeExpertListAfterEmit(expertsList: model.data?.expertList ?? []);
              bool isAnyApproveOrChoose =  model.data?.expertList?.any((element) => (element.status.toString() == '2') || (element.status.toString() == '6'))  ?? false;
             // bool isAnyChoose=  model.data?.expertList?.any((element) => element.status.toString() == '6')  ?? false;
              if(isAnyApproveOrChoose){
                //CustomLoading.progressDialog(isLoading: false);
                multiConnectCallEnumNotifier.value = CallRequestTypeEnum.multiRequestApproved;
              } else {
                multiConnectCallEnumNotifier.value = CallRequestTypeEnum.multiRequestTimeout;
                multiConnectRequestStatusNotifier.value = CallRequestStatusEnum.timeout;
              }
            }
          } else {
            InstanceCallErrorModel model = InstanceCallErrorModel.fromJson(data);
            FlutterToast().showToast(msg: model.message?.first.toString());
          }
        }
      });
    } catch (e) {
      Logger().d('multiConnectStatusSend====$e');
    }
  }


  void multiConnectStatusListener() {
    try {
      socket?.on(AppConstants.multiConnectStatusReceived, (data) {
        Logger().d('multiConnectStatusReceived=====${data.toString()}');
        if (data.toString().isNotEmpty) {
          if (data['statusCode'].toString() == '200') {
            InstanceCallEmitsResponseModel model = InstanceCallEmitsResponseModel.fromJson(data);
            if(model.data?.status.toString() == '5' || model.data?.status.toString() == '4'){
              if(activeRoute.value == RoutesConstants.multiConnectCallDialogScreen){
                NavigationService.context.toPop();
              }
            }

          } else {
            InstanceCallErrorModel model = InstanceCallErrorModel.fromJson(data);
            FlutterToast().showToast(msg: model.message?.first.toString());
          }
        }
      });
    } catch (e) {
      Logger().d('multiConnectStatusReceived====$e');
    }
  }

}