///define api  code
enum APIType { get, post, put, delete }

///define filter type
enum FilterType { Gender, InstantCall, Country, City, Topic, Category, OverAllRating }

///define device type
enum DeviceType { A, I }

///define login type  code
abstract class LoginType {
  static const normal = 0;
  static const google = 1;
  static const apple = 2;
  static const facebook = 3;
}
