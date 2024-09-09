import 'package:comic_vine_app/core/contracts/i_theme_config.dart';
import 'package:comic_vine_app/core/theme/app_theme.dart';
import 'package:comic_vine_app/core/widgets/dot_loading_indicator.dart';
import 'package:comic_vine_app/core/widgets/error_widget.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_event.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/widgets/comic_detail/comic_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_bloc.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_state.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Widget that represents the comic detail page.
/// This page will show the detailed information of a specific comic by its ID.
/// It reacts to the states of the ComicBloc to manage loading, error, and data.
class ComicDetailPage extends StatelessWidget {
  final int comicId;  // ID of the comic to be displayed

  const ComicDetailPage({super.key, required this.comicId});

  @override
  Widget build(BuildContext context) {
    // Access the theme configuration via dependency injection
    final themeConfig = GetIt.I<IThemeConfig>() as AppTheme;

    return Scaffold(
      backgroundColor: themeConfig.getPrimaryColor(),  // Set the background color from the theme
      body: SafeArea(
        child: BlocBuilder<ComicBloc, ComicState>(
          builder: (context, state) {
            if (state is ComicLoading) {
              // Display loading spinner while fetching comic details
              return const DotLoadingIndicator();
            } else if (state is ComicError) {
              // Display error message if there is an error in fetching data
              return CustomErrorWidget(
                errorMessage: state.message,  // Show the error message from the state
              );
            } else if (state is ComicDetailLoaded ) {
              // Find the comic by its ID or show a default comic if not found
              final comic = state.comic;

              // Display the comic details in a scrollable view
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<ComicBloc>().add(RefreshComicDetail(comic.id));
                },
                child: SingleChildScrollView(
                  child: ComicDetailCard(
                    comic: comic,
                  ),
                ),
              );
            }

            // Default fallback message if no comic details are available
            return CustomErrorWidget(
              errorMessage: AppLocalizations.of(context)!.not_comics_available,
            );
          },
        ),
      ),
    );
  }
}
