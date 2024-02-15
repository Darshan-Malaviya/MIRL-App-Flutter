class Pagination {
  int? page;
  int? perPage;
  int? itemCount;
  int? pageCount;
  int? previousPage;
  int? nextPage;

  Pagination({this.page, this.perPage, this.itemCount, this.pageCount, this.previousPage, this.nextPage});

  Pagination.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['perPage'];
    itemCount = json['itemCount'];
    pageCount = json['pageCount'];
    previousPage = json['previousPage'];
    nextPage = json['nextPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page'] = this.page;
    data['perPage'] = this.perPage;
    data['itemCount'] = this.itemCount;
    data['pageCount'] = this.pageCount;
    data['previousPage'] = this.previousPage;
    data['nextPage'] = this.nextPage;
    return data;
  }
}