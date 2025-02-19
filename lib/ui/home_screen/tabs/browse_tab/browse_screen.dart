import 'package:flutter/material.dart';
import 'package:movies_app/ui/widgets/movie_poster.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class BrowseScreen extends StatefulWidget {
  @override
  _BrowseScreenState createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  final List<String> genres = [
    'Drama', 'Thriller', 'Action', 'Crime', 'Comedy', 'Sci-Fi', 'Family', 'Romance', 'Documentary'
  ];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: genres.length, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: tabController,
          isScrollable: true,
          dividerColor: Colors.transparent,
          tabAlignment: TabAlignment.start,
          labelPadding: EdgeInsets.symmetric(horizontal: width*0.01),
          onTap: (index) {
            setState(() {

            });
          },
          indicatorColor: Colors.transparent,
          tabs: List.generate(genres.length, (index) {
            bool isSelected = tabController.index == index;
            return Tab(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: width*0.06, vertical: height*0.01),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.yellowColor : AppColors.blackColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected? AppColors.blackColor: AppColors.yellowColor
                  )
                ),
                child: Text(
                  genres[index],
                  style: isSelected ?
                    AppStyles.bold20Black : AppStyles.bold20Yellow,
                  ),
                ),
            );
          }),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: List.generate(genres.length, (index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.04,vertical: height*0.01),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                childAspectRatio: 0.73,
              ),
              itemCount: 10,
              itemBuilder: (context, itemIndex) {
                return MoviePoster(
                  onTap: () {},
                  networkImage: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQKjPBkeoNEasSdvcXXsYYpaHv51T0edLvg_g&s',
                  rating: '7.7',
                  imageWidth: double.infinity,
                  imageHeight: height*0.3,
                  imageFit: BoxFit.cover,
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
