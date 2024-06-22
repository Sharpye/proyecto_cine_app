import 'package:flutter/material.dart';
import 'package:proyecto_cine_app/env.dart';
import 'package:proyecto_cine_app/widgets/movies_details.dart';


class SliderCarrusel extends StatelessWidget {
  const SliderCarrusel({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MovieDetails(movie: snapshot.data[index])));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 400,
                  width: 150,
                  child: Image.network(
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                      '${Env.image}${snapshot.data![index].posterPath}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
