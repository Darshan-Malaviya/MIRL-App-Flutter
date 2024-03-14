import 'dart:developer';

import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/mirl_app.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

IO.Socket? socket;
bool isSocketConnected = false;

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
    socket?.on('connect', (data) => log("SOCKET:- connect----$data"));
    socket?.on('connect_error', (data) => log("SOCKET:- connect_error----$data"));
    socket?.on('connect_timeout', (data) => log("SOCKET:- connect_timeout----$data"));
    socket?.on('connecting', (data) => log("SOCKET:- connecting----$data"));
    socket?.on('disconnect', (data) {
       log("SOCKET:- disconnect----$data");
    });
    socket?.on('error', (data) => log("SOCKET:- error----$data"));
    socket?.on('reconnect', (data) => log("SOCKET:- reconnect----$data"));
    socket?.on('reconnect_attempt', (data) => log("SOCKET:- reconnect_attempt----$data"));
    socket?.on('reconnect_failed', (data) => log("SOCKET:- reconnect_failed----$data"));
    socket?.on('reconnect_error', (data) => log("SOCKET:- reconnect_error----$data"));
    socket?.on('reconnect_failed', (data) => log("SOCKET:- reconnect_failed----$data"));
    socket?.on('reconnecting', (data) => log("SOCKET:- reconnecting----$data"));
    socket?.on('ping', (data) => log("SOCKET:- ping----$data"));
    socket?.on('pong', (data) => log("SOCKET:- pong----$data"));
    socket?.onConnect((_) {
      log('Connection established');
      isSocketConnected = true;
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
