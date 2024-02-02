
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mirl/infrastructure/providers/add_your_area_expertise_provider.dart';
import 'package:mirl/infrastructure/providers/auth_provider.dart';
import 'package:mirl/infrastructure/providers/category_list_provider.dart';
import 'package:mirl/infrastructure/providers/edit_expert_provider.dart';
import 'package:mirl/infrastructure/providers/filter_provider.dart';
import 'package:mirl/infrastructure/providers/expert_detail_provider.dart';
import 'package:mirl/infrastructure/providers/home_provider.dart';
import 'package:mirl/infrastructure/providers/schedule_call_provider.dart';


// final authProvider = ChangeNotifierProvider.autoDispose((ref) => AuthProvider());
final loginScreenProvider = ChangeNotifierProvider.autoDispose((_) => AuthProvider());
final homeProvider = ChangeNotifierProvider.autoDispose((_) => HomeProvider());
final categoryListProvider = ChangeNotifierProvider<CategoryListProvider>((_) => CategoryListProvider());
final editExpertProvider = ChangeNotifierProvider.autoDispose((_) => EditExpertProvider());
final addYourAreaExpertiseProvider = ChangeNotifierProvider.autoDispose((_) => AddYourAreaExpertiseProvider());
final expertDetailProvider = ChangeNotifierProvider.autoDispose((_) => ExpertDetailProvider());
final filterProvider = ChangeNotifierProvider.autoDispose((_) => FilterProvider());
final scheduleCallProvider = ChangeNotifierProvider.autoDispose((_) => ScheduleCallProvider());
// final cityCountryProvider = ChangeNotifierProvider<CityCountryProvider>((ref) => CityCountryProvider());


