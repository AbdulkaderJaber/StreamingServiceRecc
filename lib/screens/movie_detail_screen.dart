import 'package:flutter/material.dart';
import '../movies.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailScreen({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              movie.imageUrl,
              height: 200.0,
              width: 200.0,
              fit: BoxFit.cover,
            ),

            SizedBox(height: 20.0),
            Text('Title: ${movie.title}'),
            Text('Director: ${movie.director}'),
            Text('Genre: ${movie.genre}'),
            Text('R-rated: ${movie.isRRated ? 'Yes' : 'No'}'),
            Text('Rating: ${movie.rating.toStringAsFixed(1)}'),

          ],
        ),
      ),
    );
  }
}
