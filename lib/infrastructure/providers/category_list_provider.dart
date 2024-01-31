import 'package:logger/logger.dart';
import 'package:mirl/infrastructure/commons/exports/common_exports.dart';
import 'package:mirl/infrastructure/models/common/category_model.dart';
import 'package:mirl/infrastructure/models/response/category_list_response_model.dart';
import 'package:mirl/infrastructure/repository/category_list_repo.dart';

class CategoryListProvider extends ChangeNotifier {
  final _categoryListRepository = CategoryListRepository();

  List<CategoryModel>? get categoryList => _categoryList;
  final List<CategoryModel> _categoryList = [];
}
