import 'package:flutter/material.dart';

class Movie {
  final String title;
  final String director;
  final String genre;
  final bool isRRated;
  final String imageUrl;
  final double rating;

  Movie({
    required this.title,
    required this.director,
    required this.genre,
    required this.isRRated,
    required this.imageUrl,
    required this.rating,
  });
}

class MoviesData {
  static List<Movie> movies = [
    Movie(
      title: 'Inception',
      director: 'Chris Nolan',
      genre: 'Action',
      isRRated: false,
      imageUrl: 'assets/Inception.jpg',
      rating: 9.0,
    ),

    Movie(
      title: 'memento',
      director: 'Chris Nolan',
      genre: 'Thriller',
      isRRated: true,
      imageUrl: 'assets/memento.jpg',
      rating: 8.0,
    ),

    Movie(
      title: 'Fight Club',
      director: 'David Fincher',
      genre: 'Action',
      isRRated: true,
      imageUrl: 'assets/FightClub.jpg',
      rating: 9.5,
    ),

    Movie(
      title: 'The Killer',
      director: 'David Fincher',
      genre: 'Thriller',
      isRRated: false,
      imageUrl: 'assets/thekiller.jpg',
      rating: 7.5,
    ),


    Movie(
      title: 'Drive',
      director: 'NWR',
      genre: 'Action',
      isRRated: false,
      imageUrl: 'assets/Drive.jpg',
      rating: 9.0,
    ),

    Movie(
      title: 'Only God Forgives',
      director: 'NWR',
      genre: 'Thriller',
      isRRated: true,
      imageUrl: 'assets/onlygodforgives.jpg',
      rating: 8.0,
    ),

  ];
}

class RatingInputWidget extends StatefulWidget {
  final void Function(double) onRatingChanged;

  const RatingInputWidget({Key? key, required this.onRatingChanged}) : super(key: key);

  @override
  _RatingInputWidgetState createState() => _RatingInputWidgetState();
}

class _RatingInputWidgetState extends State<RatingInputWidget> {
  TextEditingController _ratingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('(OPTIONAL): Enter Minimum Rating (0-10):'),
        TextField(
          controller: _ratingController,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          decoration: InputDecoration(
            hintText: 'Enter rating from 0 to 10',
          ),
          onChanged: (value) {
            // Validate the input and update the rating
            if (_isValidRating(value)) {
              // Convert the input to a double and pass it to the callback
              double rating = double.parse(value);
              widget.onRatingChanged(rating);
            } else {

              print('Invalid rating input');
            }
          },
        ),
        SizedBox(height: 16.0),
      ],
    );
  }

  bool _isValidRating(String value) {
    // Check if the input is a valid double and within the range of 0 to 10
    try {
      double rating = double.parse(value);
      return rating >= 0 && rating <= 10;
    } catch (e) {
      return false;
    }
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _ratingController.dispose();
    super.dispose();
  }
}

class MovieSelectionWidget extends StatefulWidget {
  final void Function(Movie) onMovieSelected;
  final void Function(double) onRatingChanged;

  const MovieSelectionWidget({Key? key, required this.onMovieSelected, required this.onRatingChanged})
      : super(key: key);

  @override
  _MovieSelectionWidgetState createState() => _MovieSelectionWidgetState();

}

class _MovieSelectionWidgetState extends State<MovieSelectionWidget> {
  String selectedDirector = 'Chris Nolan';
  String selectedGenre = 'Action';
  bool isRrated = false;
  double minRating = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Select Director:'),
        DropdownButton<String>(
          value: selectedDirector,
          items: ['Chris Nolan', 'David Fincher', 'NWR'].map((director) {
            return DropdownMenuItem<String>(
              value: director,
              child: Text(director),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedDirector = value!;
            });
          },
        ),

        SizedBox(height: 16.0),
        Text('Select Genre:'),
        Row(
          children: ['Action', 'Thriller'].map((genre) {
            return Row(
              children: [
                Radio<String>(
                  value: genre,
                  groupValue: selectedGenre,
                  onChanged: (value) {
                    setState(() {
                      selectedGenre = value!;
                    });
                  },
                ),
                Text(genre),
              ],
            );
          }).toList(),
        ),



        SizedBox(height: 16.0),
        Checkbox(
          value: isRrated,
          onChanged: (value) {
            setState(() {
              isRrated = value!;
            });
          },
        ),
        Text('Watch R-rated movie'),
        SizedBox(height: 16.0),

        RatingInputWidget(
          onRatingChanged: (rating) {
            setState(() {
              minRating = rating;
            });
          },
        ),

        SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            List<Movie> selectedMovies = MoviesData.movies.where((movie) {
              return movie.director == selectedDirector &&
                  movie.genre == selectedGenre &&
                  (!isRrated || movie.isRRated) &&
                  movie.rating >= minRating;
            }).toList();

            if (selectedMovies.isNotEmpty) {
              int randomIndex = DateTime.now().millisecondsSinceEpoch % selectedMovies.length;
              widget.onMovieSelected(selectedMovies[randomIndex]);
            }
          },
          child: Text('Watch Random Movie'),
        ),
      ],
    );
  }
}


