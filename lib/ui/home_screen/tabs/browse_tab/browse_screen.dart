import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/ui/home_screen/tabs/browse_tab/cubit/browse_tab_view_model.dart';
import 'package:movies_app/ui/widgets/movie_poster.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';
import 'package:movies_app/ui/home_screen/tabs/browse_tab/cubit/browse_tab_states.dart';
import 'package:movies_app/models/movie_model.dart';

class BrowseScreen extends StatefulWidget {
  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  final List<String> genres = [
    'Drama', 'Thriller', 'Action', 'Crime', 'Comedy', 'Sci-Fi', 'Family', 'Romance', 'Documentary'
  ];
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return BlocBuilder<BrowseTabViewModel, BrowseTabStates>(
      bloc: BrowseTabViewModel.get(context)..getMovies(),
      builder: (context, state) {
        return DefaultTabController(
          length: genres.length,
          initialIndex: selectedIndex,
          child: Scaffold(
            appBar: AppBar(
              title: TabBar(
                isScrollable: true,
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.start,
                labelPadding: EdgeInsets.symmetric(horizontal: width * 0.01),
                indicatorColor: Colors.transparent,
                onTap: (index) {
                  setState(() {
                    selectedIndex = index;
                  });
                  BrowseTabViewModel.get(context)..changeSelectedGenre(genres[index]);
                },
                tabs: List.generate(genres.length, (index) {
                  return Tab(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.06, vertical: height * 0.01),
                      decoration: BoxDecoration(
                        color: selectedIndex == index ? AppColors.yellowColor : AppColors.blackColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.yellowColor),
                      ),
                      child: Text(
                        genres[index],
                        style: AppStyles.bold20Yellow.copyWith(
                          color: selectedIndex == index ? AppColors.blackColor : AppColors.yellowColor,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            body: buildBody(state,height,width),
          ),
        );
      },
    );
  }

  Widget buildBody(BrowseTabStates state,var height,var width) {
    if (state is BrowseTabLoadingState) {
      return Center(child: CircularProgressIndicator(color: AppColors.yellowColor));
    } else if (state is BrowseTabErrorState) {
      return Column(
        children: [
          Center(child: Text(state.errorMsg)),
          ElevatedButton(onPressed: (){
            BrowseTabViewModel.get(context)..getMovies();
            setState(() {

            });
          }, child: Text('Try Again'))
        ],
      );
    } else if (state is BrowseTabSuccessState) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: width*0.05, vertical: height*0.03),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            childAspectRatio: 0.73,
          ),
          itemCount: state.moviesList.length,
          itemBuilder: (context, index) {
            Movie movie = state.moviesList[index];
            return MoviePoster(
              onTap: () {},
              networkImage: movie.largeCoverImage ?? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKjPBkeoNEasSdvcXXsYYpaHv51T0edLvg_g&s',
              rating: movie.rating?.toString() ?? 'N/A',
              imageWidth: double.infinity,
              imageHeight: height*0.3,
              imageFit: BoxFit.cover,
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}