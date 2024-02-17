import 'package:mirl/infrastructure/models/response/cms_response_model.dart';

class CmsArgs {
  final String? name;
  final String? title;
  final List<CmsData>? list;

  CmsArgs({this.name, this.title, this.list});
}
