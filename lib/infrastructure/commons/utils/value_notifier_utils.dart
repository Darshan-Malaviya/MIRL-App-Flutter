import 'package:mirl/infrastructure/commons/enums/call_connect_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';

import '../exports/common_exports.dart';

ValueNotifier<bool> socketListen = ValueNotifier(false);
ValueNotifier<int> bgCallEndTrigger = ValueNotifier<int>(0);
ValueNotifier<int> instanceCallDurationNotifier = ValueNotifier<int>(-1);
ValueNotifier<int> instanceRequestTimerNotifier = ValueNotifier<int>(-1);
ValueNotifier<CallTypeEnum> instanceCallEnumNotifier = ValueNotifier<CallTypeEnum>(CallTypeEnum.callRequest);
ValueNotifier<CallConnectStatusEnum> callConnectNotifier = ValueNotifier<CallConnectStatusEnum>(CallConnectStatusEnum.ringing);
ValueNotifier<bool> changeVideoCallView = ValueNotifier<bool>(true);
ValueNotifier<String> activeRoute = ValueNotifier<String>("/");


