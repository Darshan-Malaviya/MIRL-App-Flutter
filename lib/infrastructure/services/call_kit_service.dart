import 'package:flutter_callkit_incoming/entities/android_params.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/notification_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:mirl/infrastructure/models/common/extra_service_model.dart';

Future<void> showCallkitIncoming({required String uuid, required ExtraResponseModel extraResponseModel}) async {
  final params = CallKitParams(
    id: uuid,
    nameCaller: extraResponseModel.userName,
    appName: 'Mirl',
    avatar: extraResponseModel.userProfile,
    handle: 'Incoming call',
    type: 0,
    duration: 60000,
    textAccept: 'Accept',
    textDecline: 'Decline',
    extra: extraResponseModel.toJson(),
    headers: <String, dynamic>{'apiKey': 'Abc@123!', 'platform': 'flutter'},
    missedCallNotification: const NotificationParams(isShowCallback: false, showNotification: false),
    android: const AndroidParams(
      isCustomNotification: false,
      isShowLogo: true,
      ringtonePath: 'system_ringtone_default',
      backgroundColor: '#44AA87',
      backgroundUrl: 'assets/test.png',
      actionColor: '#4CAF50',
    ),
  );
  await FlutterCallkitIncoming.showCallkitIncoming(params);
}
