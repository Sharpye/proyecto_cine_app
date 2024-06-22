import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_cine_app/domain/entities/movie.dart';
import 'package:proyecto_cine_app/env.dart';
import 'package:proyecto_cine_app/widgets/movies_details.dart';


class MovieCarrusel extends StatelessWidget {
  const MovieCarrusel({
    super.key,
    required this.snapshot,
  });

  final AsyncSnapshot<List<Movie>> snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
          height: 300,
          autoPlay: true,
          viewportFraction: 0.55,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 3),
        ),
        itemBuilder: (context, itemIndex, pageViewIndex) {
          final movie = snapshot.data![itemIndex];
          return GestureDetector(
            onTap: ()  {
             
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetails(
                      movie: movie,
                    
                    ),
                  ),
                );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                height: 300,
                width: 300,
                child: Image.network(
                  '${Env.image}${movie.posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
