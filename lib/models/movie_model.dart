import 'package:hive/hive.dart';

part 'movie_model.g.dart';

@HiveType(typeId: 0)
class MovieModel {
  @HiveField(0)
  String? status;

  @HiveField(1)
  String? statusMessage;

  @HiveField(2)
  Data? data;

  MovieModel({this.status, this.statusMessage, this.data});

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
        status: json['status'],
        statusMessage: json['status_message'],
        data: json['data'] != null ? Data.fromJson(json['data']) : null,
      );

  Map<String, dynamic> toJson() => {
        'status': status,
        'status_message': statusMessage,
        'data': data?.toJson(),
      };
}

@HiveType(typeId: 1)
class Data {
  @HiveField(0)
  int? movieCount;

  @HiveField(1)
  int? limit;

  @HiveField(2)
  int? pageNumber;

  @HiveField(3)
  List<Movie>? movies;

  Data({this.movieCount, this.limit, this.pageNumber, this.movies});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        movieCount: json['movie_count'],
        limit: json['limit'],
        pageNumber: json['page_number'],
        movies: (json['movies'] as List<dynamic>?)
            ?.map((e) => Movie.fromJson(e))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'movie_count': movieCount,
        'limit': limit,
        'page_number': pageNumber,
        'movies': movies?.map((e) => e.toJson()).toList(),
      };
}

@HiveType(typeId: 2)
class Movie {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? url;

  @HiveField(2)
  String? imdbCode;

  @HiveField(3)
  String? title;

  @HiveField(4)
  String? titleEnglish;

  @HiveField(5)
  String? titleLong;

  @HiveField(6)
  String? slug;

  @HiveField(7)
  int? year;

  @HiveField(8)
  double? rating;

  @HiveField(9)
  int? runtime;

  @HiveField(10)
  List<String>? genres;

  @HiveField(11)
  String? summary;

  @HiveField(12)
  String? descriptionFull;

  @HiveField(13)
  String? synopsis;

  @HiveField(14)
  String? ytTrailerCode;

  @HiveField(15)
  String? language;

  @HiveField(16)
  String? mpaRating;

  @HiveField(17)
  String? backgroundImage;

  @HiveField(18)
  String? backgroundImageOriginal;

  @HiveField(19)
  String? smallCoverImage;

  @HiveField(20)
  String? mediumCoverImage;

  @HiveField(21)
  String? largeCoverImage;

  @HiveField(22)
  String? state;

  @HiveField(23)
  List<Torrents>? torrents;

  @HiveField(24)
  String? dateUploaded;

  @HiveField(25)
  int? dateUploadedUnix;

  Movie({
    this.id,
    this.url,
    this.imdbCode,
    this.title,
    this.titleEnglish,
    this.titleLong,
    this.slug,
    this.year,
    this.rating,
    this.runtime,
    this.genres,
    this.summary,
    this.descriptionFull,
    this.synopsis,
    this.ytTrailerCode,
    this.language,
    this.mpaRating,
    this.backgroundImage,
    this.backgroundImageOriginal,
    this.smallCoverImage,
    this.mediumCoverImage,
    this.largeCoverImage,
    this.state,
    this.torrents,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'],
        url: json['url'],
        imdbCode: json['imdb_code'],
        title: json['title'],
        titleEnglish: json['title_english'],
        titleLong: json['title_long'],
        slug: json['slug'],
        year: json['year'],
        rating: (json['rating'] as num?)?.toDouble(),
        runtime: json['runtime'],
        genres: (json['genres'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        summary: json['summary'],
        descriptionFull: json['description_full'],
        synopsis: json['synopsis'],
        ytTrailerCode: json['yt_trailer_code'],
        language: json['language'],
        mpaRating: json['mpa_rating'],
        backgroundImage: json['background_image'],
        backgroundImageOriginal: json['background_image_original'],
        smallCoverImage: json['small_cover_image'],
        mediumCoverImage: json['medium_cover_image'],
        largeCoverImage: json['large_cover_image'],
        state: json['state'],
        torrents: (json['torrents'] as List<dynamic>?)
            ?.map((e) => Torrents.fromJson(e))
            .toList(),
        dateUploaded: json['date_uploaded'],
        dateUploadedUnix: json['date_uploaded_unix'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'url': url,
        'imdb_code': imdbCode,
        'title': title,
        'title_english': titleEnglish,
        'title_long': titleLong,
        'slug': slug,
        'year': year,
        'rating': rating,
        'runtime': runtime,
        'genres': genres,
        'summary': summary,
        'description_full': descriptionFull,
        'synopsis': synopsis,
        'yt_trailer_code': ytTrailerCode,
        'language': language,
        'mpa_rating': mpaRating,
        'background_image': backgroundImage,
        'background_image_original': backgroundImageOriginal,
        'small_cover_image': smallCoverImage,
        'medium_cover_image': mediumCoverImage,
        'large_cover_image': largeCoverImage,
        'state': state,
        'torrents': torrents?.map((e) => e.toJson()).toList(),
        'date_uploaded': dateUploaded,
        'date_uploaded_unix': dateUploadedUnix,
      };
}

@HiveType(typeId: 3)
class Torrents {
  @HiveField(0)
  String? url;

  @HiveField(1)
  String? hash;

  @HiveField(2)
  String? quality;

  @HiveField(3)
  String? type;

  @HiveField(4)
  String? isRepack;

  @HiveField(5)
  String? videoCodec;

  @HiveField(6)
  String? bitDepth;

  @HiveField(7)
  String? audioChannels;

  @HiveField(8)
  int? seeds;

  @HiveField(9)
  int? peers;

  @HiveField(10)
  String? size;

  @HiveField(11)
  int? sizeBytes;

  @HiveField(12)
  String? dateUploaded;

  @HiveField(13)
  int? dateUploadedUnix;

  Torrents({
    this.url,
    this.hash,
    this.quality,
    this.type,
    this.isRepack,
    this.videoCodec,
    this.bitDepth,
    this.audioChannels,
    this.seeds,
    this.peers,
    this.size,
    this.sizeBytes,
    this.dateUploaded,
    this.dateUploadedUnix,
  });

  factory Torrents.fromJson(Map<String, dynamic> json) => Torrents(
        url: json['url'],
        hash: json['hash'],
        quality: json['quality'],
        type: json['type'],
        isRepack: json['is_repack'],
        videoCodec: json['video_codec'],
        bitDepth: json['bit_depth'],
        audioChannels: json['audio_channels'],
        seeds: json['seeds'],
        peers: json['peers'],
        size: json['size'],
        sizeBytes: json['size_bytes'],
        dateUploaded: json['date_uploaded'],
        dateUploadedUnix: json['date_uploaded_unix'],
      );

  Map<String, dynamic> toJson() => {
        'url': url,
        'hash': hash,
        'quality': quality,
        'type': type,
        'is_repack': isRepack,
        'video_codec': videoCodec,
        'bit_depth': bitDepth,
        'audio_channels': audioChannels,
        'seeds': seeds,
        'peers': peers,
        'size': size,
        'size_bytes': sizeBytes,
        'date_uploaded': dateUploaded,
        'date_uploaded_unix': dateUploadedUnix,
      };
}
