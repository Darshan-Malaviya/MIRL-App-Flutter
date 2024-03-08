import 'package:mirl/infrastructure/commons/enums/call_connect_status_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_history_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';
import 'package:mirl/infrastructure/commons/enums/call_request_status_enum.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/response/home_data_response_model.dart';

ValueNotifier<bool> socketListen = ValueNotifier(false);
ValueNotifier<List<UserFavorites>> favoriteListNotifier = ValueNotifier<List<UserFavorites>>([]);
ValueNotifier<int> instanceCallDurationNotifier = ValueNotifier<int>(-1);
ValueNotifier<int> allCallDurationNotifier = ValueNotifier<int>(0);
ValueNotifier<int> instanceRequestTimerNotifier = ValueNotifier<int>(120);
ValueNotifier<int> multiRequestTimerNotifier = ValueNotifier<int>(60);
ValueNotifier<CallRequestTypeEnum> instanceCallEnumNotifier = ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
ValueNotifier<CallRequestTypeEnum> multiConnectCallEnumNotifier =
    ValueNotifier<CallRequestTypeEnum>(CallRequestTypeEnum.callRequest);
ValueNotifier<CallRequestStatusEnum> multiConnectRequestStatusNotifier =
    ValueNotifier<CallRequestStatusEnum>(CallRequestStatusEnum.waiting);
ValueNotifier<CallConnectStatusEnum> callConnectNotifier = ValueNotifier<CallConnectStatusEnum>(CallConnectStatusEnum.ringing);
ValueNotifier<bool> changeVideoCallView = ValueNotifier<bool>(true);
ValueNotifier<int> mirlConnectView = ValueNotifier<int>(0);
ValueNotifier<int> reportView = ValueNotifier<int>(0);
ValueNotifier<String> activeRoute = ValueNotifier<String>("/");
ValueNotifier<CallHistoryEnum> callHistoryEnumNotifier = ValueNotifier<CallHistoryEnum>(CallHistoryEnum.instantCall);
