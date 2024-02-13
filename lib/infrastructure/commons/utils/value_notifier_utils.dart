import 'package:mirl/infrastructure/commons/enums/call_request_enum.dart';

import '../exports/common_exports.dart';

ValueNotifier<bool> socketListen = ValueNotifier(false);
ValueNotifier<int> bgCallEndTrigger = ValueNotifier<int>(0);
ValueNotifier<CallTypeEnum> instanceCallEnumNotifier = ValueNotifier<CallTypeEnum>(CallTypeEnum.callRequest);