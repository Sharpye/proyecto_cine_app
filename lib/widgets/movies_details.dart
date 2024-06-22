import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_cine_app/domain/entities/movie.dart';
import 'package:proyecto_cine_app/env.dart';
import 'package:proyecto_cine_app/helpers/movie_api.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;

  const MovieDetails({super.key, required this.movie});

  @override
  MovieDetailsState createState() => MovieDetailsState();
}

class MovieDetailsState extends State<MovieDetails> {
  late Future<String?> trailerKey;
  late Future<List<dynamic>> reparto;
  YoutubePlayerController? _youtubePlayerController;

  @override
  void initState() {
    super.initState();
    reparto = MovieApi().getCastMovie(widget.movie.id);
    trailerKey = MovieApi().getTrailerKey(widget.movie.id);
    trailerKey.then((key) {
      if (key != null) {
        setState(() {
          _youtubePlayerController = YoutubePlayerController(
            initialVideoId: key,
            flags: const YoutubePlayerFlags(
              autoPlay: false,
              mute: false,
            ),
          );
        });
      }
    });
  }

  @override
  void dispose() {
    _youtubePlayerController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            backgroundColor: Colors.black,
            expandedHeight: 500,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                child: Image.network(
                  '${Env.image}${widget.movie.posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Descripción',
                    style: GoogleFonts.aBeeZee(
                        fontSize: 25, 
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    widget.movie.overview,
                    style: GoogleFonts.aBeeZee(
                      fontSize: 18,
                      color: Colors.black
                      ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border.all(color: const Color.fromARGB(255, 255, 23, 7)),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  'Lanzamiento: ',
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black
                                      ),
                                ),
                                Text(
                                  widget.movie.releaseDate,
                                  style: GoogleFonts.aBeeZee(
                                      fontSize: 16,
                                      color: Colors.black
                                      ),
                                ),
                              ],
                            )),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: const Color.fromARGB(255, 255, 23, 7)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Rating',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 16, 
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const Icon(
                                Icons.star,
                                color: Color.fromARGB(255, 255, 23, 7),
                              ),
                              Text(widget.movie.voteAvegage.toStringAsFixed(1), style: const TextStyle(color: Colors.black),),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<String?>(
                    future: trailerKey,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData && snapshot.data != null) {
                        return YoutubePlayer(
                          controller: YoutubePlayerController(
                            initialVideoId: snapshot.data!,
                            flags: const YoutubePlayerFlags(
                              autoPlay: false,
                              mute: false,
                            ),
                          ),
                          showVideoProgressIndicator: true,
                        );
                      } else {
                        return Text(
                          'No hay trailer disponible',
                          style: GoogleFonts.aBeeZee(
                                    fontSize: 16, 
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                          );
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  FutureBuilder<List<dynamic>>(
                    future: reparto,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (snapshot.hasData) {
                        return SizedBox(
                          height: 200,
                          child: RepartoMovieList(snapshot.data!),
                        );
                      } else {
                        return  Center(
                          child:
                              Text(
                                'No se encontró reparto para esta película.',
                                style: GoogleFonts.aBeeZee(
                                    fontSize: 16, 
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget RepartoMovieList(List<dynamic> respartoMovie) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: respartoMovie.length,
      itemBuilder: (context, index) {
        final actor = respartoMovie[index];
        return Container(
          width: 120,
          margin: const EdgeInsets.only(right: 10),
          child: Column(
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: actor['profile_path'] != null
                    ? NetworkImage('${Env.image}${actor['profile_path']}')
                    : const NetworkImage(
                        'https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/No-Image-Placeholder.svg/1665px-No-Image-Placeholder.svg.png',
                      ),
              ),
              const SizedBox(height: 10),
              Text(
                actor['name'],
                style: GoogleFonts.aBeeZee(
                  fontSize: 14,
                  color: Colors.black
                  ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              Text(
                actor['character'],
                style: GoogleFonts.aBeeZee(fontSize: 12, color: const Color.fromARGB(255, 0, 0, 0)),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }
}
