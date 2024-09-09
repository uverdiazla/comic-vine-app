import 'package:comic_vine_app/core/contracts/i_size_config.dart';
import 'package:comic_vine_app/core/widgets/dot_loading_indicator.dart';
import 'package:comic_vine_app/core/widgets/error_widget.dart';
import 'package:flutter/material.dart';
import 'package:comic_vine_app/core/widgets/custom_divider.dart';
import 'package:comic_vine_app/features/comic_vine/data/models/comic_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_bloc.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_event.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_state.dart';
import 'package:comic_vine_app/core/contracts/i_theme_config.dart';
import 'package:comic_vine_app/core/widgets/comic_tile.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:comic_vine_app/core/theme/app_theme.dart';

class ComicListPage extends StatelessWidget {
  const ComicListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the theme configuration through GetIt
    final themeConfig = GetIt.I<IThemeConfig>() as AppTheme;
    final responsiveConfig = GetIt.I<ISizeConfig>();

    return Scaffold(
      backgroundColor: themeConfig.getPrimaryColor(), // Background color based on the theme
      body: SafeArea( // Use SafeArea to ensure content does not overlap the status bar
        child: BlocProvider(
          // Injecting ComicBloc using GetIt and triggering the FetchComics event
          create: (_) => GetIt.I<ComicBloc>()..add(FetchComics()),
          child: BlocBuilder<ComicBloc, ComicState>(
            builder: (context, state) {
              // Handling the different states of ComicBloc
              if (state is ComicLoading) {
                return const DotLoadingIndicator();
              } else if (state is ComicError) {
                // Show an error message if something goes wrong
                return CustomErrorWidget(
                  errorMessage: state.message,
                );
              } else if (state is ComicLoaded) {
                // Display the comics list once the data is loaded
                return CustomScrollView(
                  slivers: [
                    // Static "Latest Issues" section at the beginning, visible without scrolling
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: responsiveConfig.getHeightSize(2)),
                            CustomDivider(),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Text(
                                AppLocalizations.of(context)!.latest_issues,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: themeConfig.getDefaultTextColor(), // Text color based on theme configuration
                                ),
                              ),
                            ),
                            CustomDivider(),
                          ],
                        ),
                      ),
                    ),

                    // SliverList for displaying the list of comics
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final ComicModel comic = state.comics[index];
                          // Reuse the ComicTile widget to display individual comics
                          return ComicTile(
                            id: comic.id,
                            imageUrl: comic.imageUrl,
                            title: comic.name,
                            issueNumber: comic.issueNumber, // Assuming the ID represents the issue number
                            releaseDate: DateTime.parse(comic.coverDate), // Replace with the actual release date
                          );
                        },
                        childCount: state.comics.length, // Number of comics to display
                      ),
                    ),
                  ],
                );
              }
              // Default fallback if no comics are available
              return Center(child: Text(AppLocalizations.of(context)!.not_comics_available));
            },
          ),
        ),
      ),
    );
  }
}
