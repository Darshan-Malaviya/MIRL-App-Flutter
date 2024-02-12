import 'dart:developer';

import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/mirl_app.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket? socket;

class SocketApi {
  // A static private instance to access _socketApi from inside class only
  static final SocketApi singleTone = SocketApi._internal();

  // An internal private constructor to access it for only once for static instance of class.
  SocketApi._internal();

  // Factry constructor to retutn same static instance everytime you create any object.
  factory SocketApi() {
    return singleTone;
  }

  // static Function? onListenMethods;

  void init({required ValueChanged<bool> onListenMethod}) {
    final token = SharedPrefHelper.getAuthToken;
    String id = SharedPrefHelper.getUserId;

    socket = IO.io(
      flavorConfig?.socketUrl, // AppConstants.socketUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .setExtraHeaders(<String, String>{
            'Authorization': '$token',
            'mirlAppToken': 'Bearer 9e03fddc477f8dddf89ca6b608d1c6cccdc882ccd104dbafcdb02ff8edd419296937b1b6562db403c0be150a0a432f70c5e13csdsj232sdbb3438cbdf'
          })
          .disableAutoConnect()
          .enableReconnection()
          .build(),
    );

    socket?.connect();
    socket?.onConnect((_) {
      log('Connection established');
      updateSocketId(id);
      userOnlineStatus(id);
      onListenMethod(true);
    });
    socket?.onDisconnect((_) => onListenMethod(false));
    socket?.onConnectError((err) => onListenMethod(false));
    socket?.onError((err) => onListenMethod(false));
  }

  // All socket related functions.

  void updateSocketId(String id) {
    socket?.emit(AppConstants.updateSocketId, {AppConstants.userId: id});
  }

  void userOnlineStatus(String id) {
    // socket?.emit(AppConstants.onlineEmit, {AppConstants.loginUserId: id});
  }
}
