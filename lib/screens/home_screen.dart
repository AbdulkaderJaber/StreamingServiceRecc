import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

import '../Widgets/custom_app_bar.dart';

import '../movies.dart';

import 'package:untitled9/movies.dart';

import 'movie_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Movie? selectedMovie;


  @override
  Widget build(BuildContext context) {

    //screenSize variable
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      //Cast button
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey[850],
        child: const Icon(Icons.cast),
        onPressed: () => print('Cast'),
      ),

      //AppBar
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 50.0), //screenSize variable is used here
        child: CustomAppBar()
      ),
      body: Column(
        children: [
          MovieSelectionWidget(
            onMovieSelected: (movie) {
              setState(() {
                selectedMovie = movie;
              });

              // Navigate to the movie details screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MovieDetailScreen(movie: movie),
                ),
              );
            },
            onRatingChanged: (rating) {

            },
          ),

          SizedBox(height: 20.0),
          if (selectedMovie != null)
            Column(
              children: [
                Text('Selected Movie: ${selectedMovie!.title}'),

              ],
    ),

          SizedBox(height: 20.0),
          // Display the list of movies via a ListView
          Expanded(
            child: ListView.builder(
              itemCount: MoviesData.movies.length,
              itemBuilder: (context, index) {
                Movie movie = MoviesData.movies[index];
                return ListTile(
                  title: Text(movie.title),

                );
              },
            ),
          ),

    ],
    ),

    );

  }
}
