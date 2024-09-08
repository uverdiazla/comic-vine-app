import 'package:comic_vine_app/core/contracts/i_theme_config.dart';
import 'package:comic_vine_app/core/theme/app_theme.dart';
import 'package:comic_vine_app/core/widgets/error_widget.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/widgets/comic_detail/comic_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_bloc.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_state.dart';
import 'package:comic_vine_app/features/comic_vine/data/models/comic_model.dart';
import 'package:get_it/get_it.dart';

class ComicDetailPage extends StatelessWidget {
  final int comicId;

  const ComicDetailPage({super.key, required this.comicId});

  @override
  Widget build(BuildContext context) {

    final themeConfig = GetIt.I<IThemeConfig>() as AppTheme;


    return Scaffold(
      backgroundColor: themeConfig.getPrimaryColor(),
      body: SafeArea(
        child: BlocBuilder<ComicBloc, ComicState>(
          builder: (context, state) {
            if (state is ComicLoading) {
              return const Center(child: CircularProgressIndicator());  // Loading indicator
            } else if (state is ComicError) {
              return CustomErrorWidget(
                errorMessage: state.message,
              );  // Error message
            } else if (state is ComicLoaded) {
              // If the comic is not found, return a default ComicModel instance
              final comic = state.comics.firstWhere(
                    (c) => c.id == comicId,
                orElse: () => ComicModel(
                  id: 0,
                  name: 'Unknown Comic',
                  issueNumber: 'N/A',
                  coverDate: 'Unknown Date',
                  description: 'No description available',
                  imageUrl: 'https://default-image-url.com',  // Default image
                  volumeId: 0,
                  volumeName: 'Unknown Volume',
                ),
              );

              return SingleChildScrollView(
                child: ComicDetailCard(
                  imageUrl: comic.imageUrl,
                  title: comic.name,
                  issueNumber: comic.issueNumber,
                  description: comic.description,
                ),
              );
            }

            // Default message if no comics are available
            return const Center(child: Text('No comic details available'));
          },
        ),
      ),
    );
  }
}
