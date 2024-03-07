///define api  code
enum APIType { get, post, put, delete }

///define filter type
enum FilterType { Gender, InstantCall, Country, City, Topic, Category, OverAllRating, FeeRange, SortBy }

///define device type
enum DeviceType { A, I }

///define login type  code
abstract class LoginType {
  static const normal = 0;
  static const google = 1;
  static const apple = 2;
  static const facebook = 3;
}

///define notification type
abstract class NotificationType {
  static const expert = 1;
  static const user = 2;
  static const general = 3;
}

///over all rating type  code
abstract class OverAllRatingType {
  static const EXPERTISE = 1;
  static const COMMUNICATION = 2;
  static const HELPFULNESS = 3;
  static const EMPATHY = 4;
  static const PROFESSIONALISM = 5;
}

enum RatingEnum { EXPERTISE, COMMUNICATION, HELPFULNESS, EMPATHY, PROFESSIONALISM }
