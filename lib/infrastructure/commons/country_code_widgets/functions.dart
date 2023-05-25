// import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
// import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
//
//
// ///This function returns list of countries
// Future<List<Country>> getCountries(BuildContext context) async {
//   String rawData = await DefaultAssetBundle.of(context).loadString('assets/raw/country_codes.json');
//   final parsed = json.decode(rawData.toString()).cast<Map<String, dynamic>>();
//   return parsed.map<Country>((json) => Country.fromJson(json)).toList();
// }
//
//
// ///This function returns an user's current country. User's sim country code is matched with the ones in the list.
// ///If there is no sim in the device, first country in the list will be returned.
// ///This function returns an user's current country. User's sim country code is matched with the ones in the list.
// ///If there is no sim in the device, first country in the list will be returned.
// Future<Country> getDefaultCountry(BuildContext context) async {
//   final list = await getCountries(context);
//   try {
//     final countryCode = await FlutterSimCountryCode.simCountryCode;
//     if (countryCode == null) {
//       return list.first;
//     }
//     return list.firstWhere((element) => element.countryCode.toLowerCase() == countryCode.toLowerCase());
//   } catch (e) {
//     return list.first;
//   }
// }
//
// ///This function returns an country whose [countryCode] matches with the passed one.
// Future<Country?> getCountryByCountryCode(BuildContext context, String countryCode) async {
//   final list = await getCountries(context);
//   return list.firstWhere((element) => element.countryCode == countryCode);
// }
//
// ///This function returns an country whose [callingCode] matches with the passed one.
// Future<Country?> getCountryByCallingCode(BuildContext context, String callingCode) async {
//   final list = await getCountries(context);
//   return list.firstWhere((element) => element.callingCode == callingCode);
// }
//
// Future<Country?> showCountryPickerSheet(BuildContext context,
//     {Widget? title, Widget? cancelWidget, bool focusSearchBox= false,TickerProvider? vsync,}) {
//   return showModalBottomSheet<Country?>(
//       context: context,
//       backgroundColor: Colors.transparent,
//       barrierColor: ColorConstants.primaryColor.withOpacity(0.7),
//       isScrollControlled: true,
//       transitionAnimationController: vsync != null ? AnimationController(vsync: vsync,duration: const Duration(milliseconds: 500),reverseDuration: const Duration(milliseconds: 300)) : null,
//       builder: (_) {
//         return Padding(
//           padding: MediaQuery.of(context).viewInsets,
//           child: Container(
//             height: 400,
//             decoration: const BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(RadiusConstant.alertdialogRadius),
//                 topRight: Radius.circular(RadiusConstant.alertdialogRadius),
//               ),
//             ),
//             child: CountryPickerWidget(
//               onSelected: (country) => Navigator.of(context).pop(country),
//             ),
//           ),
//         );
//       });
// }
