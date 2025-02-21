import 'package:movies_app/models/IsFavouriteModel.dart';
import 'package:movies_app/models/movie_suggestion_model.dart';

import '../../../models/movie_details_model.dart';

abstract class DetailsScreenStates {}

class DetailsScreenLoadingState extends DetailsScreenStates {}

class DetailsScreenErrorState extends DetailsScreenStates {
  String message;

  DetailsScreenErrorState({required this.message});
}

class DetailsAndSuggestionsSuccessState extends DetailsScreenStates {
  final MovieDetailsModel movieDetailsModel;
  final MovieSuggestionModel movieSuggestionModel;

  DetailsAndSuggestionsSuccessState({
    required this.movieDetailsModel,
    required this.movieSuggestionModel,
  });
}

class AddToFavouriteSuccessState extends DetailsScreenStates {
  String message;

  AddToFavouriteSuccessState({required this.message});
}

class AddToFavouriteErrorState extends DetailsScreenStates {
  String message;

  AddToFavouriteErrorState({required this.message});
}

class IsFavouriteSuccessState extends DetailsScreenStates {
  IsFavouriteModel isFavouriteModel;

  IsFavouriteSuccessState({required this.isFavouriteModel});
}

class IsFavouriteErrorState extends DetailsScreenStates {
  String message;

  IsFavouriteErrorState({required this.message});
}

class DeletedSuccessState extends DetailsScreenStates {}

class DeletedErrorState extends DetailsScreenStates {
  String message;

  DeletedErrorState({required this.message});
}
