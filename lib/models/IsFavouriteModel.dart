class IsFavouriteModel {
  IsFavouriteModel({
    this.data,
    this.message,
    this.error,
    this.statusCode,
  });

  IsFavouriteModel.fromJson(dynamic json) {
    message = json['message'];
    data = json['data'];
    error = json['error'];
    statusCode = json['statusCode'];
  }

  bool? data;
  String? message;
  String? error;
  num? statusCode;

// Map<String, dynamic> toJson() {
//   final map = <String, dynamic>{};
//   map['message'] = message;
//   map['error'] = error;
//   map['statusCode'] = statusCode;
//   return map;
// }
}
