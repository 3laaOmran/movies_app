/// message : "Success Login"
/// data : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY3YTE4MjRhZWE4MjhhMzdkNWE3YjAzYiIsImVtYWlsIjoiYW1yMkBnbWFpbC5jb20iLCJpYXQiOjE3Mzg4MzcwMDN9.3xGzcRfVEmCjzXDhFqloDO4QXq7nHh1eIiNd7NfAa1Y"

class LoginModel {
  LoginModel({
    this.message,
    this.statusCode,
    this.data,
  });

  LoginModel.fromJson(dynamic json) {
    if (json["message"] is String) {
      message = json["message"];
    } else {
      message = json['message'] != null ? json['message'].cast<String>() : [];
    }
    statusCode = json['statusCode'];
    data = json['data'];
  }

  var message;
  int? statusCode;
  String? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map["message"] = message;
    map['statusCode'] = statusCode;
    map['data'] = data;
    return map;
  }
}
