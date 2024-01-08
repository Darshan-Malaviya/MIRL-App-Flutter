import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'main.dart';

void main() {
  //dev flavor
  final flavorDevConfig = FlavorConfig()
    ..appTitle = AppConstants.prodFlavorName
    ..appIdForIOS = '1:123033805966:ios:413f510839e4d94c3215df'
    //..socketUrl = 'http://107.22.27.50:3000'
    ..iosBundleId = 'com.app.mirl'
    ..baseUrl = "https://api.mirl.com/" //TODO add base url here
    ..iosClientId = '123033805966-32ie9m2baveh8f0me1v09gn0uf127m56.apps.googleusercontent.com';

  mainCommon(flavorDevConfig);
}
