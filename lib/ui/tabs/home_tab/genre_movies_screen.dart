import 'package:flutter/material.dart';
import 'package:movies_app/models/movie_model.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class GenreMoviesScreen extends StatelessWidget {
  final String genre;
  final List<Movie> allMovies;

  const GenreMoviesScreen({Key? key, required this.genre, required this.allMovies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var filteredMovies = allMovies.where((movie) => movie.genres?.contains(genre) ?? false).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('$genre Movies'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: filteredMovies.length,
        itemBuilder: (context, index) {
          var movie = filteredMovies[index];
          return InkWell(
            onTap: () {
              // TODO: Navigate to movie details screen
            },
            child: Card(
              color: AppColors.darkGreyColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(
                    movie.largeCoverImage!,
                    height: height * 0.25,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      movie.title ?? 'No Title',
                      style: AppStyles.bold20White,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      'Rating: ${movie.rating?.toString() ?? 'N/A'}',
                      style: AppStyles.regular16Yellow,
                    ),
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
