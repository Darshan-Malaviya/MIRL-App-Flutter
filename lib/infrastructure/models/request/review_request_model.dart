class ReviewRequestModel {
  final String firstCreatedOrder;
  final String ratingOrder;
  final String page;
  final String limit;

  ReviewRequestModel({
    required this.firstCreatedOrder,
    required this.ratingOrder,
    required this.page,
    required this.limit,
  });

  ReviewRequestModel.fromJson(Map<String, dynamic> json)
      : firstCreatedOrder = json['firstCreatedOrder'],
        ratingOrder = json['ratingOrder'],
        page = json['page'],
        limit = json['limit'];

  Map<String, dynamic> toJson() => {
        'firstCreatedOrder': firstCreatedOrder,
        'ratingOrder': ratingOrder,
        'page': page,
        'limit': limit,
      };

  Map<String, dynamic> toNullFreeJson() {
    var json = toJson();
    json.removeWhere((key, value) => value == null);
    return json;
  }
}
