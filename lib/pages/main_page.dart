import 'dart:ui';

//packages
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

//Widgets
import '../widgets/movie_tile.dart';

//Models
import '../models/search_category.dart';
import '../models/movie.dart';

class MainPage extends ConsumerWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return _buildUI(context);
  }

  Widget _buildUI(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    TextEditingController searchFieldController = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SizedBox(
        height: deviceHeight,
        width: deviceWidth,
        child: Stack(
          alignment: Alignment.center,
          children: [
            _backgroundWidget(deviceHeight, deviceWidth),
            _foregroundWidget(deviceHeight, deviceWidth, searchFieldController),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget(deviceHeight, deviceWidth) {
    return Container(
      height: deviceHeight,
      width: deviceWidth,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        image: DecorationImage(
            image: NetworkImage(
                'https://cdn.marvel.com/content/1x/thorloveandthunder_lob_crd_04.jpg'),
            fit: BoxFit.cover),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.02),
          ),
        ),
      ),
    );
  }

  Widget _foregroundWidget(
      deviceHeight, deviceWidth, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(top: deviceHeight * 0.02),
      width: deviceWidth * 0.88,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _topBarWidget(deviceHeight, deviceWidth, controller),
          Container(
            height: deviceHeight * 0.83,
            padding: EdgeInsets.symmetric(vertical: deviceHeight * 0.01),
            child: _movieListViewWidget(deviceHeight, deviceWidth),
          )
        ],
      ),
    );
  }

  Widget _topBarWidget(
      deviceHeight, deviceWidth, TextEditingController controller) {
    return Container(
      height: deviceHeight * 0.08,
      decoration: const BoxDecoration(
        color: Colors.black54,
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _searchFieldWidget(deviceHeight, deviceWidth, controller),
          _categorySelectionWidget(),
        ],
      ),
    );
  }

  Widget _searchFieldWidget(
      deviceHeight, deviceWidth, TextEditingController controller) {
    const border = InputBorder.none;
    return SizedBox(
      width: deviceWidth * 0.50,
      height: deviceHeight * 0.05,
      child: TextField(
        controller: controller,
        onSubmitted: (String input) {},
        style: const TextStyle(
          color: Colors.white,
        ),
        decoration: const InputDecoration(
            focusedBorder: border,
            border: border,
            prefixIcon: Icon(Icons.search, color: Colors.white24),
            hintStyle: TextStyle(color: Colors.white54),
            filled: false,
            fillColor: Colors.white24,
            hintText: 'Search....'),
      ),
    );
  }

  Widget _categorySelectionWidget() {
    return DropdownButton(
      dropdownColor: Colors.black38,
      value: SearchCategory.popular,
      icon: const Icon(
        Icons.menu,
        color: Colors.white24,
      ),
      onChanged: (input) {},
      items: const [
        DropdownMenuItem(
          value: SearchCategory.popular,
          child: Text(
            SearchCategory.popular,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.upcoming,
          child: Text(
            SearchCategory.upcoming,
            style: TextStyle(color: Colors.white),
          ),
        ),
        DropdownMenuItem(
          value: SearchCategory.none,
          child: Text(
            SearchCategory.none,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _movieListViewWidget(
    deviceHeight,
    deviceWidth,
  ) {
    final List<Movie> movies = [];

    for (var i = 0; i < 20; i++) {
      movies.add(
        Movie(
          name: "Mortal Kombat",
          language: "EN",
          isAdult: false,
          description:
              "Cole Young, a washed-up MMA fighter, is chosen to join a team of champions in a high-stakes battle to prevent the Earth from being taken over by Outworld.",
          posterPath: "/xGu0F1T3WmPsAcQEQJfnG7Udf8.jpg",
          backdropPath: "/9yBVqNruk6Ykrwc32qrK2TIE5xw.jpg",
          rating: 7.8,
          releaseDate: "2021-04-07",
        ),
      );
    }

    if (movies.isNotEmpty) {
      return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: deviceHeight * 0.02, horizontal: 0),
              child: GestureDetector(
                onTap: () {},
                child: MovieTile(
                    height: deviceHeight * 0.20,
                    width: deviceWidth * 0.85,
                    movie: movies[index]),
              ),
            );
          });
    } else {
      return const Center(
        child:
            CircularProgressIndicator.adaptive(backgroundColor: Colors.white),
      );
    }
  }
}
