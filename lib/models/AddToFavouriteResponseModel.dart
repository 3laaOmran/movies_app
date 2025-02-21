class AddToFavouriteModel {
  AddToFavouriteModel({
    this.statusCode,
    this.message,
    this.data,
  });

  AddToFavouriteModel.fromJson(dynamic json) {
    message = json['message'];
    statusCode = json['statusCode'];
    data =
        json['data'] != null ? AddToFavouriteData.fromJson(json['data']) : null;
  }

  String? message;
  num? statusCode;
  AddToFavouriteData? data;

// Map<String, dynamic> toJson() {
//   final map = <String, dynamic>{};
//   map['message'] = message;
//   if (data != null) {
//     map['data'] = data?.toJson();
//   }
//   return map;
// }
}

class AddToFavouriteData {
  AddToFavouriteData({
    this.movieId,
    this.name,
    this.rating,
    this.imageURL,
    this.year,
  });

  AddToFavouriteData.fromJson(dynamic json) {
    movieId = json['movieId'];
    name = json['name'];
    rating = json['rating'];
    imageURL = json['imageURL'];
    year = json['year'];
  }

  String? movieId;
  String? name;
  num? rating;
  String? imageURL;
  String? year;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movieId'] = movieId;
    map['name'] = name;
    map['rating'] = rating;
    map['imageURL'] = imageURL;
    map['year'] = year;
    return map;
  }
}
