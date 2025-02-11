import '../../../models/movie_details_model.dart';

abstract class DetailsScreenStates {}

class DetailsScreenLoadingState extends DetailsScreenStates {}

class DetailsScreenLoadedState extends DetailsScreenStates {
  MovieDetailsModel movieDetailsModel;

  DetailsScreenLoadedState({required this.movieDetailsModel});
}

class DetailsScreenErrorState extends DetailsScreenStates {
  String message;

  DetailsScreenErrorState({required this.message});
}
