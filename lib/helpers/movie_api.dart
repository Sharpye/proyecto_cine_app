


import 'package:dio/dio.dart';
import 'package:proyecto_cine_app/domain/entities/movie.dart';
import 'package:proyecto_cine_app/env.dart';

class MovieApi {
  final dio = Dio();
  static const trendingMovies =
      'https://api.themoviedb.org/3/trending/movie/day?api_key=${Env.apiKey}';

  static const topRateMovies =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${Env.apiKey}';

  static const upcomingMovies =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${Env.apiKey}';
    
  static const popularMovies =
      'https://api.themoviedb.org/3/movie/popular?api_key=${Env.apiKey}';

  static const nowPlayingMovies =
      'https://api.themoviedb.org/3/movie/now_playing?api_key=${Env.apiKey}';
    

  Future<List<Movie>> getTrendingMovies() async {
    try {
      final response = await dio.get(trendingMovies);
      if (response.statusCode == 200) {
        final decodedData = response.data['results'] as List;
        return decodedData.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar las peliculas');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Movie>> getTopRatedMovies() async {
    try {
      final response = await dio.get(topRateMovies);
      if (response.statusCode == 200) {
        final decodedData = response.data['results'] as List;
        return decodedData.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar las peliculas');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<List<Movie>> getUpcomingMovies() async {
    try {
      final response = await dio.get(upcomingMovies);
      if (response.statusCode == 200) {
        final decodedData = response.data['results'] as List;
        return decodedData.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar las peliculas');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

    Future<List<Movie>> getPopularMovies() async {
    try {
      final response = await dio.get(trendingMovies);
      if (response.statusCode == 200) {
        final decodedData = response.data['results'] as List;
        return decodedData.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar las peliculas');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

    Future<List<Movie>> getNowPlayingMovies() async {
    try {
      final response = await dio.get(trendingMovies);
      if (response.statusCode == 200) {
        final decodedData = response.data['results'] as List;
        return decodedData.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Error al cargar las peliculas');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  
  Future<List<dynamic>> getCastMovie(int movieId) async {
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=${Env.apiKey}';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final decodedData = response.data['cast'] as List;
        return decodedData;
      } else {
        throw Exception('Error al cargar los datos');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future<String?> getTrailerKey(int movieId) async {
    print(movieId);
    final url =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=${Env.apiKey}';
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final results = response.data['results'] as List;
        if (results.isNotEmpty) {
          final trailer = results.firstWhere(
            (video) => video['type'] == 'Trailer' && video['site'] == 'YouTube',
            orElse: () => null,
          );
          return trailer != null ? trailer['key'] : null;
        }
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
    return null;
  }
}
