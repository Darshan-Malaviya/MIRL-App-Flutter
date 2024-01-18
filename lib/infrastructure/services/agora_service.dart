import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';

// late RtcEngine engine;

class AgoraService {
  // A static private instance to access _socketApi from inside class only
  static final AgoraService singleton = AgoraService._internal();

  // Factory constructor to return same static instance everytime you create any object.
  factory AgoraService() {
    return singleton;
  }

  // An internal private constructor to access it for only once for static instance of class.
  AgoraService._internal();

  Future<String> getVoipToken() async {
    return await FlutterCallkitIncoming.getDevicePushTokenVoIP();
  }
}
