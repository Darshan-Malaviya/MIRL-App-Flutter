// library countrycodepicker;
//
// import 'package:flutter_boilerplate_may_2023/infrastructure/commons/exports/common_exports.dart';
// import 'package:flutter_sim_country_code/flutter_sim_country_code.dart';
//
// const TextStyle _defaultItemTextStyle = TextStyle(fontSize: 16);
// const TextStyle _defaultSearchInputStyle = TextStyle(fontSize: 16);
// const String _kDefaultSearchHintText = 'Search country name, code';
// const String countryCodePackageName = 'assets/flags/';
//
// class CountryPickerWidget extends StatefulWidget {
//   const CountryPickerWidget({
//     Key? key,
//     this.onSelected,
//     this.itemTextStyle = _defaultItemTextStyle,
//     this.searchInputStyle = _defaultSearchInputStyle,
//     this.searchInputDecoration,
//     this.searchHintText = _kDefaultSearchHintText,
//     this.flagIconSize = 32,
//     this.showSeparator = false,
//     this.focusSearchBox = false,
//   }) : super(key: key);
//
//   /// This callback will be called on selection of a [Country].
//   final ValueChanged<Country>? onSelected;
//
//   /// [itemTextStyle] can be used to change the TextStyle of the Text in ListItem. Default is [_defaultItemTextStyle]
//   final TextStyle itemTextStyle;
//
//   /// [searchInputStyle] can be used to change the TextStyle of the Text in SearchBox. Default is [searchInputStyle]
//   final TextStyle searchInputStyle;
//
//   /// [searchInputDecoration] can be used to change the decoration for SearchBox.
//   final InputDecoration? searchInputDecoration;
//
//   /// Flag icon size (width). Default set to 32.
//   final double flagIconSize;
//
//   ///Can be set to `true` for showing the List Separator. Default set to `false`
//   final bool showSeparator;
//
//   ///Can be set to `true` for opening the keyboard automatically. Default set to `false`
//   final bool focusSearchBox;
//
//   ///This will change the hint of the search box. Alternatively [searchInputDecoration] can be used to change decoration fully.
//   final String searchHintText;
//
//   @override
//   _CountryPickerWidgetState createState() => _CountryPickerWidgetState();
// }
//
// class _CountryPickerWidgetState extends State<CountryPickerWidget> {
//   List<Country> _list = [];
//   List<Country> _filteredList = [];
//   final TextEditingController _controller = TextEditingController();
//   final ScrollController _scrollController = ScrollController();
//   bool _isLoading = false;
//   Country? _currentCountry;
//
//   void _onSearch(text) {
//     if (text == null || text.isEmpty) {
//       setState(() {
//         _filteredList
//           ..clear()
//           ..addAll(_list);
//       });
//     } else {
//       setState(() {
//         _filteredList = _list
//             .where((element) =>
//                 element.name.toLowerCase().contains(text.toString().toLowerCase()) ||
//                 element.callingCode.toLowerCase().contains(text.toString().toLowerCase()) ||
//                 element.countryCode.toLowerCase().startsWith(text.toString().toLowerCase()))
//             .map((e) => e)
//             .toList();
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     _scrollController.addListener(() {
//       FocusScopeNode currentFocus = FocusScope.of(context);
//       if (!currentFocus.hasPrimaryFocus) {
//         currentFocus.unfocus();
//       }
//     });
//     loadList();
//     super.initState();
//   }
//
//   Future<void> loadList() async {
//     setState(() {
//       _isLoading = true;
//     });
//     _list = await getCountries(context);
//     try {
//       String? code = await FlutterSimCountryCode.simCountryCode;
//       if (code != null && code.isNotEmpty) {
//         _currentCountry = _list.firstWhere((element) => element.countryCode == code);
//       }
//       final country = _currentCountry;
//       if (country != null) {
//         _list
//           ..removeWhere((element) => element.callingCode == country.callingCode)
//           ..insert(0, country);
//       }
//     } finally {
//       setState(() {
//         _filteredList = _list.map((e) => e).toList();
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) => Column(
//         children: <Widget>[
//           const SizedBox(
//             height: 24,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 24, right: 24),
//             child: TextField(
//               style: widget.searchInputStyle,
//               autofocus: widget.focusSearchBox,
//               decoration: widget.searchInputDecoration ??
//                   InputDecoration(
//                       suffixIcon: Visibility(
//                         visible: _controller.text.isNotEmpty,
//                         child: InkWell(
//                           overlayColor: MaterialStateProperty.all(Colors.transparent),
//                           child: const Icon(Icons.clear),
//                           onTap: () => setState(() {
//                             _controller.clear();
//                             _filteredList
//                               ..clear()
//                               ..addAll(_list);
//                           }),
//                         ),
//                       ),
//                       border: DecoratedInputBorder(
//                         child: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
//                           borderSide: const BorderSide(
//                             color: Colors.transparent,
//                           ),
//                         ),
//                         shadow: buildBoxShadow(),
//                       ),
//                       enabledBorder: DecoratedInputBorder(
//                         child: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
//                           borderSide: const BorderSide(
//                             color: Colors.transparent,
//                           ),
//                         ),
//                         shadow: buildBoxShadow(),
//                       ),
//                       focusedBorder: DecoratedInputBorder(
//                         child: OutlineInputBorder(
//                           borderSide: BorderSide(
//                             color: ColorConstants.primaryColor,
//                           ),
//                           borderRadius: BorderRadius.circular(RadiusConstant.commonRadius),
//                         ),
//                         shadow: buildBoxShadow(),
//                       ),
//                       contentPadding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
//                       hintText: widget.searchHintText,
//                       hintStyle:
//                           const TextStyle(fontFamily: 'Poppins', color: ColorConstants.blackColor, fontSize: 14, fontWeight: FontWeight.w400)),
//               textInputAction: TextInputAction.done,
//               controller: _controller,
//               onChanged: _onSearch,
//               inputFormatters: [
//                 FilteringTextInputFormatter.deny(RegExp(r'^\s*')),
//                 FilteringTextInputFormatter.deny(RegExp(RegexConstants.emojiRegex)),
//               ],
//             ),
//           ),
//           const SizedBox(
//             height: 16,
//           ),
//           Expanded(
//             child: _isLoading
//                 ? const Center(child: CircularProgressIndicator())
//                 : _filteredList.isEmpty
//                     ? const Center(
//                         child: BodyMediumText(
//                         title: 'No country found.',
//                         fontWeight: FontWeight.w600,
//                       ))
//                     : ListView.separated(
//                         padding: const EdgeInsets.only(top: 10),
//                         controller: _scrollController,
//                         itemCount: _filteredList.length,
//                         separatorBuilder: (_, index) => widget.showSeparator ? const Divider() : Container(),
//                         itemBuilder: (_, index) => InkWell(
//                           onTap: () {
//                             widget.onSelected?.call(_filteredList[index]);
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.only(bottom: 12, top: 12, left: 24, right: 24),
//                             child: Row(
//                               children: <Widget>[
//                                 ClipRRect(
//                                   borderRadius: BorderRadius.circular(2),
//                                   child: Image.asset(
//                                     countryCodePackageName + _filteredList[index].flag,
//                                     width: widget.flagIconSize,
//                                   ),
//                                 ),
//                                 const SizedBox(
//                                   width: 16,
//                                 ),
//                                 Expanded(
//                                   child: BodyMediumText(
//                                     title: '${_filteredList[index].callingCode} ${_filteredList[index].name}',
//                                     titleColor: ColorConstants.blackColor,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ),
//                       ),
//           )
//         ],
//       );
//
//   BoxShadow buildBoxShadow() => const BoxShadow(color: ColorConstants.whiteColor, blurRadius: 6, offset: Offset(0, 3));
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     _controller.dispose();
//     super.dispose();
//   }
// }
//
