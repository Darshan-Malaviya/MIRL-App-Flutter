import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'main.dart';

void main() {
  //dev flavor
  final flavorDevConfig = FlavorConfig()
    ..appTitle = AppConstants.localFlavorName
    ..appIdForIOS = '1:123033805966:ios:ec61db6b22f44a9a3215df'
    ..socketUrl = 'http://192.168.1.137:3000'
    ..iosBundleId = 'com.app.mirl.dev'
    ..baseUrl = "http://192.168.1.137:3000" //TODO add base url here
    ..iosClientId = '123033805966-6vc88aip1vmemr5v24obppu6q7003vkg.apps.googleusercontent.com';

  mainCommon(flavorDevConfig);
}
