import 'package:logger/logger.dart';

class ServiceResponseModel {
  int? id;
  BookedBy? bookedBy;
  BookedFor? bookedFor;
  String? businessName;
  Services? businessLocation;
  String? secondaryBrand;
  Product? product;
  String? machineModel;
  String? machineSerialNumber;
  String? customerPO;
  Services? bookServiceBrand;
  Services? bookServiceType;
  String? postcode;
  String? serviceDate;
  String? message;
  String? firstCreated;
  String? lastModified;

  ServiceResponseModel(
      {this.id,
      this.bookedBy,
      this.bookedFor,
      this.businessName,
      this.businessLocation,
      this.secondaryBrand,
      this.product,
      this.machineModel,
      this.machineSerialNumber,
      this.customerPO,
      this.bookServiceBrand,
      this.bookServiceType,
      this.postcode,
      this.serviceDate,
      this.message,
      this.firstCreated,
      this.lastModified});

  ServiceResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookedBy = json['bookedBy'] != null ? BookedBy.fromJson(json['bookedBy']) : null;
    bookedFor = json['bookedFor'] != null ? BookedFor.fromJson(json['bookedFor']) : null;
    businessName = json['businessName'];
    businessLocation = json['businessLocation'] != null ? Services.fromJson(json['businessLocation']) : null;
    secondaryBrand = json['secondaryBrand'];
    product = json['product'] != null ? Product.fromJson(json['product']) : null;
    machineModel = json['machineModel'];
    machineSerialNumber = json['machineSerialNumber'];
    customerPO = json['customerPO'];
    bookServiceBrand = json['bookServiceBrand'] != null ? Services.fromJson(json['bookServiceBrand']) : null;
    bookServiceType = json['bookServiceType'] != null ? Services.fromJson(json['bookServiceType']) : null;
    postcode = json['postcode'];
    serviceDate = json['serviceDate'];
    message = json['message'];
    firstCreated = json['firstCreated'];
    lastModified = json['lastModified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (bookedBy != null) {
      data['bookedBy'] = bookedBy!.toJson();
    }
    if (bookedFor != null) {
      data['bookedFor'] = bookedFor!.toJson();
    }
    data['businessName'] = businessName;
    if (businessLocation != null) {
      data['businessLocation'] = businessLocation!.toJson();
    }
    data['secondaryBrand'] = secondaryBrand;
    if (product != null) {
      data['product'] = product!.toJson();
    }
    data['machineModel'] = machineModel;
    data['machineSerialNumber'] = machineSerialNumber;
    data['customerPO'] = customerPO;
    if (bookServiceBrand != null) {
      data['bookServiceBrand'] = bookServiceBrand!.toJson();
    }
    if (bookServiceType != null) {
      data['bookServiceType'] = bookServiceType!.toJson();
    }
    data['postcode'] = postcode;
    data['serviceDate'] = serviceDate;
    data['message'] = message;
    data['firstCreated'] = firstCreated;
    data['lastModified'] = lastModified;
    return data;
  }

  static Future<ServiceResponseModel?> parseInfo(Map<String, dynamic>? json) async {
    try {
      return ServiceResponseModel.fromJson(json ?? {});
    } catch (e) {
      Logger().e("ServiceResponseModel exception : $e");
      return null;
    }
  }
}

class BookedBy {
  String? firstName;
  String? lastName;
  String? email;

  BookedBy({this.firstName, this.lastName, this.email});

  BookedBy.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    return data;
  }
}

class BookedFor {
  String? firstName;
  String? lastName;
  String? email;
  String? countryCode;
  String? phone;

  BookedFor({this.firstName, this.lastName, this.email, this.countryCode, this.phone});

  BookedFor.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    countryCode = json['countryCode'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstName'] = firstName;
    data['lastName'] = lastName;
    data['email'] = email;
    data['countryCode'] = countryCode;
    data['phone'] = phone;
    return data;
  }
}

class Services {
  int? id;
  String? name;

  Services({this.id, this.name});

  Services.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class Product {
  int? id;
  String? product;

  Product({this.id, this.product});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product'] = product;
    return data;
  }
}
