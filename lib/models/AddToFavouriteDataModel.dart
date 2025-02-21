class AddToFavouriteDataModel {
  AddToFavouriteDataModel({
    this.movieId,
    this.name,
    this.rating,
    this.imageURL,
    this.year,
  });

  AddToFavouriteDataModel.fromJson(dynamic json) {
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
