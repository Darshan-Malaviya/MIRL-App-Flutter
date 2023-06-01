class Country {

  Country(this.name, this.flag, this.countryCode, this.callingCode);

  factory Country.fromJson(Map<String, dynamic> json) => Country(
      json['name'] as String,
      json['flag'] as String,
      json['country_code'] as String,
      json['calling_code'] as String,
    );
  final String name;
  final String flag;
  final String countryCode;
  String callingCode;
}
