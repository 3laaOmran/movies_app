import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies_app/repository/search/repository/search_repository.dart';
import 'package:movies_app/ui/home_screen/tabs/search_tab/cubit/search_screen_states.dart';

import '../../../../../models/movie_model.dart';

@injectable
class SearchScreenCubit extends Cubit<SearchStates> {
  SearchRepository searchRepository;
  SearchScreenCubit({required this.searchRepository}) : super(SearchInitialState());

  var controller = TextEditingController();
  List<Movie> searchedMovieList = [];

  void getSearchedMovie(String query) async {
    try {
      emit(SearchLoadingState());
      var response = await searchRepository.getSearchedMovie(query.toLowerCase());

      if (response == null || response.status == null) {
        emit(SearchErrorState(error: response.statusMessage!));
        return;
      }

      searchedMovieList = response.data!.movies!;
      emit(SearchSuccessState(movieList: searchedMovieList));
    } catch (e) {
      emit(SearchErrorState(error: e.toString()));
    }
    if (query.isEmpty) {
      searchedMovieList=[];
      emit(SearchInitialState());
      return;
    }
  }

}



