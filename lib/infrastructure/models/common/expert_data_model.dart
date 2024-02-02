
import 'package:mirl/infrastructure/models/response/get_single_category_response_model.dart';

class ExpertData {
  int? id;
  String? expertName;
  String? expertProfile;
  String? fee;
  String? about;
  List<ExpertCategory>? expertCategory;

  ExpertData({this.id, this.expertName, this.expertProfile, this.fee, this.about, this.expertCategory});

  ExpertData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expertName = json['expertName'];
    expertProfile = json['expertProfile'];
    fee = json['fee'];
    about = json['about'];
    if (json['expertCategory'] != null) {
      expertCategory = <ExpertCategory>[];
      json['expertCategory'].forEach((v) {
        expertCategory!.add(new ExpertCategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expertName'] = this.expertName;
    data['expertProfile'] = this.expertProfile;
    data['fee'] = this.fee;
    data['about'] = this.about;
    if (this.expertCategory != null) {
      data['expertCategory'] = this.expertCategory?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}