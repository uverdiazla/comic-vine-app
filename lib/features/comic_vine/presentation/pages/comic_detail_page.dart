import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_bloc.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_state.dart';

class ComicDetailPage extends StatelessWidget {
  final int comicId;

  const ComicDetailPage({Key? key, required this.comicId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comic Details'),
      ),
      body: BlocBuilder<ComicBloc, ComicState>(
        builder: (context, state) {
          if (state is ComicLoading) {
            return const Center(child: CircularProgressIndicator());  // Indicador de carga
          } else if (state is ComicError) {
            return const Center(child: Text('Error loading comic details'));  // Mensaje de error
          } else if (state is ComicLoaded) {
            final comic = state.comics.firstWhere((c) => c.id == comicId);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.network(comic.imageUrl),
                  const SizedBox(height: 16),
                  Text(comic.title, style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  Text(comic.description),
                ],
              ),
            );
          }
          return const Center(child: Text('No comic details available'));  // Si no hay datos
        },
      ),
    );
  }
}
