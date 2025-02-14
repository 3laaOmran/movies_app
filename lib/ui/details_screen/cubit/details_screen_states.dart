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
