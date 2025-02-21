import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/di/di.dart';
import 'package:movies_app/ui/home_screen/tabs/search_tab/cubit/search_screen_cubit.dart';
import 'package:movies_app/ui/home_screen/tabs/search_tab/cubit/search_screen_states.dart';
import 'package:movies_app/ui/widgets/custom_text_form_field.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/asset_manager.dart';

import '../../../details_screen/details_screen.dart';
import '../../../widgets/movie_poster.dart';
import '../browse_tab/cubit/browse_tab_view_model.dart';

class SearchScreen extends StatelessWidget {
  final SearchScreenCubit searchCubit = getIt<SearchScreenCubit>();

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return BlocProvider.value(
      value: searchCubit,
      child: BlocBuilder<SearchScreenCubit, SearchStates>(
        builder: (context, state) {
          return Scaffold(
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.03, vertical: height * 0.05),
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: 'Search',
                    controller: searchCubit.controller,
                    prefixIcon: AssetsManager.searchIcon,
                    onChanged: (query) {
                      searchCubit.getSearchedMovie(query.toLowerCase());
                      // if(query.isEmpty||query==null){
                      //   searchCubit.searchedMovieList.clear();
                      // }
                    },
                  ),
                  SizedBox(height: height*0.025),
                  Expanded(
                    child: state is SearchLoadingState
                        ? Center(child: CircularProgressIndicator(color: AppColors.yellowColor))
                        : state is SearchErrorState
                        ? Center(child: Text('Error: ${state.error}'))
                        : state is SearchSuccessState && state.movieList.isNotEmpty
                        ? GridView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: width * 0.03,
                        mainAxisSpacing: height * 0.025,
                        childAspectRatio: 1 / 1.6,
                      ),
                      itemCount: state.movieList.length,
                      itemBuilder: (context, index) {
                        return MoviePoster(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              DetailsScreen.routeName,
                              arguments: state.movieList[index].id,
                            );
                                          BrowseTabViewModel.get(context)
                                              .addToHistory(
                                                  state.movieList[index]);
                                        },
                          networkImage: state.movieList[index].largeCoverImage ??
                              state.movieList[index].mediumCoverImage ??
                              state.movieList[index].smallCoverImage ??
                                            "https://upload.wikimedia.org/wikipedia/commons/1/14/No_Image_Available.jpg",
                                        rating: state.movieList[index].rating.toString(),
                          imageWidth: double.infinity,
                          imageHeight: double.infinity,
                          imageFit: BoxFit.cover,
                        );
                      },
                    )
                        : Center(child: Image.asset(AssetsManager.popCornImage)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}



