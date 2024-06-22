import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proyecto_cine_app/domain/entities/movie.dart';
import 'package:proyecto_cine_app/helpers/movie_api.dart';
import 'package:proyecto_cine_app/screens/info_details_screen.dart';
import 'package:proyecto_cine_app/widgets/carrusel.dart';
import 'package:proyecto_cine_app/widgets/slider.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topMovies;
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> popularMovies;
  late Future<List<Movie>> nowPlayingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = MovieApi().getTrendingMovies();
    topMovies = MovieApi().getTopRatedMovies();
    upcomingMovies = MovieApi().getUpcomingMovies();
    popularMovies = MovieApi().getPopularMovies();
    nowPlayingMovies = MovieApi().getNowPlayingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.network(
          'https://i.postimg.cc/1zpgWD07/nomo.png',
          fit: BoxFit.cover,
          height: 40,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.info,
              size:
                  30, 
              color: Color.fromARGB(
                  255, 228, 99, 13), 
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MoviesInfo()),
              );
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'En tendencia',
                style: GoogleFonts.aBeeZee(
                  fontSize: 25, 
                color: Colors.black),
              ),
              const SizedBox(height: 32),
              SizedBox(
                  child: FutureBuilder(
                      future: trendingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return MovieCarrusel(
                            snapshot: snapshot,
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      })),
              //
              const SizedBox(height: 32),
              Text(
                'Mejor calificadas',
                style: GoogleFonts.aBeeZee(fontSize: 25, color: Colors.black),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              SizedBox(
                  child: FutureBuilder(
                      future: topMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SliderCarrusel(
                            snapshot: snapshot,
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      })),
              //
              const SizedBox(height: 32),
              Text(
                'En cines',
                style: GoogleFonts.aBeeZee(fontSize: 25, color: Colors.black),
                textAlign: TextAlign.right,
              ),
              const SizedBox(height: 32),
              SizedBox(
                  child: FutureBuilder(
                      future: nowPlayingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return MovieCarrusel(
                            snapshot: snapshot,
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      })),
              //
              const SizedBox(height: 32),
              Text(
                'Proximamente',
                style: GoogleFonts.aBeeZee(
                  fontSize: 25,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                  child: FutureBuilder(
                      future: upcomingMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SliderCarrusel(
                            snapshot: snapshot,
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      })),
              //
              const SizedBox(height: 32),
              Text(
                'Populares',
                style: GoogleFonts.aBeeZee(fontSize: 25, color: Colors.black),
              ),
              const SizedBox(height: 32),
              SizedBox(
                  child: FutureBuilder(
                      future: popularMovies,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SliderCarrusel(
                            snapshot: snapshot,
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text(snapshot.error.toString()));
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
