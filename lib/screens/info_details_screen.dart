import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MoviesInfo extends StatelessWidget {
  const MoviesInfo({super.key});

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
        
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20), 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Información',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 35, 
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10), // Espacio entre el título y el texto
                  Text(
                    'Este proyecto trata de una aplicación móvil llamada “NoMo”, esta app trata de que ofrece una gran variedad de películas, lo cual al seleccionar cualquier película de la pantalla principal mostrara la información de la película, un pequeño trailer, la información de los actores y si es de aventura, drama, acción, etc.',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 25, 
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 340), // Espacio entre los textos
                  Text(
                    'Hecho por',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 20, 
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10), // Espacio entre el título y el texto
                  Text(
                    'Noelia Montiel & Sharon  Rodriguez',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 15, 
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
