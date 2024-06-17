import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_role_enum.dart';
import 'package:mirl/infrastructure/commons/enums/notification_color_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/instance_call_emits_response_model.dart';
import 'package:mirl/infrastructure/models/common/notification_data_model.dart';
import 'package:mirl/infrastructure/models/response/cancel_appointment_response_model.dart';
import 'package:mirl/infrastructure/models/response/login_response_model.dart';
import 'package:mirl/infrastructure/providers/auth_provider.dart';
import 'package:mirl/ui/common/arguments/screen_arguments.dart';
import 'package:mirl/ui/screens/instant_call_screen/arguments/instance_call_dialog_arguments.dart';
import 'package:mirl/ui/screens/multi_call_screen/arguments/multi_call_connect_request_arguments.dart';

class CommonMethods {
  /// get current time zone
  static Future<String> getCurrentTimeZone() async {
    return await FlutterTimezone.getLocalTimezone();
  }

  static Future<String> getDeviceIdentifier() async {
    if (Platform.isAndroid) {
      const _androidIdPlugin = AndroidId();
      String? androidId = await _androidIdPlugin.getId();
      return androidId ?? '';
    } else {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.identifierForVendor ?? '';
    }
  }

  static String numberToWord(int number) {
    if (number < 0 || number > 99) {
      return "Number out of range";
    }

    final List<String> units = [
      '',
      'one',
      'two',
      'three',
      'four',
      'five',
      'six',
      'seven',
      'eight',
      'nine'
    ];

    final List<String> teens = [
      'ten',
      'eleven',
      'twelve',
      'thirteen',
      'fourteen',
      'fifteen',
      'sixteen',
      'seventeen',
      'eighteen',
      'nineteen'
    ];

    final List<String> tens = [
      '',
      'ten',
      'twenty',
      'thirty',
      'forty',
      'fifty',
      'sixty',
      'seventy',
      'eighty',
      'ninety'
    ];

    if (number < 10) {
      return units[number];
    } else if (number < 20) {
      return teens[number - 10];
    } else {
      return '${tens[number ~/ 10]}-${units[number % 10]}';
    }
  }

  /// autoLogout
  static Future<void> autoLogout() async {
    UserData? data;
    if (SharedPrefHelper.getUserData.isNotEmpty) {
      data = UserData.fromJson(jsonDecode(SharedPrefHelper.getUserData));
    }
    if (data?.loginType == 1) {
      googleSignIn?.signOut();
    } /*else {
      await UpdateUserDetailsRepository().userLogout();
    }*/
    SharedPrefHelper.clearPrefs();
    NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.loginScreen);
  }

  /// if some one block logged user
  static Future<void> blockByAnyOtherUser({required String blockedUserId}) async {
    int index = favoriteListNotifier.value.indexWhere((element) => element.id.toString() == blockedUserId);
    if (index != -1) {
      favoriteListNotifier.value.removeWhere((element) => element.id == blockedUserId);
    }
    // if (activeRoute.value == RoutesConstants.instantCallRequestDialogScreen) {
    //   await FlutterToast().showToast(msg: "Sorry! You are blocked by this expert.");
    //   await Future.delayed(const Duration(seconds: 1));
    //   NavigationService.context.toPushNamedAndRemoveUntil(RoutesConstants.dashBoardScreen, args: 0);
    // }
  }

  static void onTapNotification(String data,{ bool fromNotificationList = false}) {
    NotificationData notificationData = NotificationData.fromJson(jsonDecode(data));
    if (notificationData.key == NotificationTypeEnum.appointmentConfirmed.name) {
      NavigationService.context.toPushNamed(RoutesConstants.viewCalendarAppointment,
          args: AppointmentArgs(role: int.parse(notificationData.role.toString()), fromNotification: true, selectedDate: notificationData.date));
    } else if (notificationData.key == NotificationTypeEnum.appointmentCancelled.name) {
      NotificationData notificationData = NotificationData.fromJsonCanceled(jsonDecode(data));
      NavigationService.context.toPushNamed(RoutesConstants.canceledNotificationScreen,
          args: CancelArgs(
            role: int.parse(notificationData.role.toString()),
            cancelDate: notificationData.date,
            cancelData: CancelAppointmentData(
              startTime: notificationData.startTime,
              endTime: notificationData.endTime,
              duration: int.parse(notificationData.duration ?? '0'),
              name: notificationData.name,
              profileImage: notificationData.profile,
              reason: notificationData.reason,
            ),
          ));
    } else if (notificationData.key == NotificationTypeEnum.multipleConnectRequestExpert.name) {
      if(fromNotificationList == true) {
        if (multiRequestTimerNotifier.value != 60) {
          NotificationData notificationData = NotificationData.fromJsonCall(jsonDecode(data));
          NavigationService.context.toPushNamed(RoutesConstants.multiConnectCallDialogScreen,
              args: MultiConnectDialogArguments(
                //expertList: model.data?.expertList,
                userDetail: UserDetails(
                    id: int.parse(notificationData.userId ?? ''), userName: notificationData.userName, userProfile: notificationData.profile),
                onFirstBtnTap: () {
                  /// expert accept
                  socket?.emit(AppConstants.multiConnectUpdateStatus, {
                    AppConstants.expertId: SharedPrefHelper.getUserId,
                    AppConstants.userId: notificationData.userId,
                    AppConstants.role: CallRoleEnum.expert,
                    AppConstants.callStatus: CallRequestStatusEnum.accept,
                    AppConstants.callRequestId: notificationData.callRequestId,
                    AppConstants.time: DateTime.now().toUtc().toString()
                  });
                  NavigationService.context.toPop();
                },
                onSecondBtnTap: () {
                  /// expert decline
                  socket?.emit(AppConstants.multiConnectUpdateStatus, {
                    AppConstants.expertId: SharedPrefHelper.getUserId,
                    AppConstants.userId: notificationData.userId,
                    AppConstants.role: CallRoleEnum.expert,
                    AppConstants.callStatus: CallRequestStatusEnum.decline,
                    AppConstants.callRequestId: notificationData.callRequestId,
                    AppConstants.time: DateTime.now().toUtc().toString()
                  });
                  NavigationService.context.toPop();
                },
              ));
        }
      }
    } else if (notificationData.key == NotificationTypeEnum.multiConnectRequestUser.name){
      NotificationData notificationData = NotificationData.fromJsonCall(jsonDecode(data));
      // context.toPop();
   /*   allCallDurationNotifier.value = multiProviderWatch.multiCallDuration * 60;

      /// user side
      NavigationService.context.toPushNamed(RoutesConstants.multiConnectCallDialogScreen,
          args: MultiConnectDialogArguments(
            //expertList: multiProviderRead.selectedExpertDetails,
            userDetail: multiProviderRead.loggedUserData,
            onFirstBtnTap: () {
              if (instanceCallEnumNotifier.value == CallRequestTypeEnum.multiRequestTimeout) {
                /// tru again
              } else {
                List<int> data = multiProviderWatch.selectedExpertDetails.map((e) => e.id ?? 0).toList();
                CustomLoading.progressDialog(isLoading: true);
                ref.read(socketProvider).multiConnectRequestEmit(
                    expertIdsList: data, requestedDuration: multiProviderWatch.multiCallDuration * 60);
              }
            },
            onSecondBtnTap: () async {
              /// cancel
              if (multiConnectCallEnumNotifier.value.secondButtonName == LocaleKeys.goBack.tr().toUpperCase()) {
                context.toPop();
                ref.read(multiConnectProvider).getLoggedUserData();
                await ref.read(multiConnectProvider).getSingleCategoryApiCall(
                    categoryId: widget.args.categoryId ?? '',
                    context: context,
                    requestModel:
                    ExpertDataRequestModel(userId: SharedPrefHelper.getUserId, multiConnectRequest: 'true'));
                ref.read(filterProvider).setCategoryWhenFromMultiConnect(
                    ref.watch(multiConnectProvider).singleCategoryData?.categoryData);
              } else if (multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestApproved) {
                if (multiProviderWatch.selectedExpertForCall != null && multiConnectCallEnumNotifier.value == CallRequestTypeEnum.multiRequestApproved) {
                  multiProviderRead.getPayValue(fee: multiProviderWatch.selectedExpertForCall?.fee ?? 0);
                  CommonBottomSheet.bottomSheet(
                      context: context,
                      child: MultiCallPaymentBottomSheetView(onPressed: () {
                        context.toPop();
                        ref.read(socketProvider).connectCallEmit(
                            expertId: multiProviderWatch.selectedExpertForCall?.id.toString() ?? '');
                      }),
                      isDismissible: true);
                } else {
                  /// Choose any expert for call
                  FlutterToast().showToast(msg: LocaleKeys.pleasePickOneExpertStartYourCall.tr());
                }
              } else {
                /// change expert id here
                ref.read(socketProvider).multiConnectStatusEmit(
                    callStatusEnum: CallRequestStatusEnum.cancel,
                    expertId: null,
                    userId: SharedPrefHelper.getUserId,
                    callRoleEnum: CallRoleEnum.user,
                    callRequestId: SharedPrefHelper.getCallRequestId.toString());
                context.toPop();
                ref.read(multiConnectProvider).getLoggedUserData();
                await ref.read(multiConnectProvider).getSingleCategoryApiCall(
                    categoryId: widget.args.categoryId ?? '',
                    context: context,
                    requestModel:
                    ExpertDataRequestModel(userId: SharedPrefHelper.getUserId, multiConnectRequest: 'true'));
                ref.read(filterProvider).setCategoryWhenFromMultiConnect(
                    ref.watch(multiConnectProvider).singleCategoryData?.categoryData);
              }
            },
          ));*/
    } else if(notificationData.key == NotificationTypeEnum.instantCall.name){
      if(fromNotificationList == true) {
        NotificationData notificationData = NotificationData.fromJsonCall(jsonDecode(data));

        NavigationService.context.toPushNamed(RoutesConstants.instantCallRequestDialogScreen,
            args: InstanceCallDialogArguments(
              name: notificationData.userName,
              onFirstBtnTap: () {
                socket?.emit(AppConstants.updateRequestStatus, {
                  AppConstants.expertId: notificationData.expertId,
                  AppConstants.userId: notificationData.userId,
                  AppConstants.role: CallRoleEnum.expert.roleToNumber,
                  AppConstants.callStatus: CallRequestStatusEnum.accept.callRequestStatusToNumber,
                  AppConstants.callRequestId: notificationData.callRequestId,
                  AppConstants.time: DateTime.now().toUtc().toString()
                });
                NavigationService.context.toPop();
              },
              onSecondBtnTap: () {
                socket?.emit(AppConstants.updateRequestStatus, {
                  AppConstants.expertId: notificationData.expertId,
                  AppConstants.userId: notificationData.userId,
                  AppConstants.role: CallRoleEnum.expert.roleToNumber,
                  AppConstants.callStatus: CallRequestStatusEnum.decline.callRequestStatusToNumber,
                  AppConstants.callRequestId: notificationData.callRequestId,
                  AppConstants.time: DateTime.now().toUtc().toString()
                });
                NavigationService.context.toPop();
              },
              image: '',
              expertId: notificationData.expertId ?? '',
              userID: notificationData.userId ?? '',
            ));
      }
    }
    else if (notificationData.key == NotificationTypeEnum.appointmentIn1min.name){
      NavigationService.context.toPushNamed(RoutesConstants.viewCalendarAppointment, args: AppointmentArgs(role: int.parse(notificationData.role.toString()), fromNotification: true, selectedDate: notificationData.date));
    } else if (notificationData.key == NotificationTypeEnum.appointmentIn30min.name){
      NavigationService.context.toPushNamed(RoutesConstants.viewCalendarAppointment, args: AppointmentArgs(role: int.parse(notificationData.role.toString()), fromNotification: true, selectedDate: notificationData.date));
    } else if (notificationData.key == NotificationTypeEnum.appointmentRemainder.name){
      NavigationService.context.toPushNamed(RoutesConstants.viewCalendarAppointment, args: AppointmentArgs(role: int.parse(notificationData.role.toString()), fromNotification: true, selectedDate: notificationData.date));
    }
  }
}
