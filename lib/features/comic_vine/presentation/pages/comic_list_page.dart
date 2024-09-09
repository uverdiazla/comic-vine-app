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

class ComicListPage extends StatefulWidget {
  const ComicListPage({super.key});

  @override
  State<ComicListPage> createState() => _ComicListPageState();
}

class _ComicListPageState extends State<ComicListPage> {
  final ScrollController _scrollController = ScrollController();
  bool _isLoadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    context.read<ComicBloc>().add(const FetchComics(page: 1));
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !_isLoadingMore) {
      setState(() {
        _isLoadingMore = true;
      });
      context.read<ComicBloc>().add(FetchComics(page: context.read<ComicBloc>().currentPage));
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeConfig = GetIt.I<IThemeConfig>() as AppTheme;
    final responsiveConfig = GetIt.I<ISizeConfig>();

    return Scaffold(
      backgroundColor: themeConfig.getPrimaryColor(),
      body: SafeArea(
        child: BlocBuilder<ComicBloc, ComicState>(
          builder: (context, state) {
            if (state is ComicLoading && !_isLoadingMore) {
              return const DotLoadingIndicator();
            } else if (state is ComicError) {
              return CustomErrorWidget(errorMessage: state.message);
            } else if (state is ComicLoaded || state is ComicLoadingMore) {
              final comics = (state as ComicLoaded).comics;
              _isLoadingMore = state is ComicLoadingMore;

              return CustomScrollView(
                controller: _scrollController,
                slivers: [
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
                                color: themeConfig.getDefaultTextColor(),
                              ),
                            ),
                          ),
                          CustomDivider(),
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final ComicModel comic = comics[index];
                        return ComicTile(
                          id: comic.id,
                          imageUrl: comic.imageUrl,
                          title: comic.name,
                          issueNumber: comic.issueNumber,
                          releaseDate: DateTime.parse(comic.coverDate),
                        );
                      },
                      childCount: comics.length,
                    ),
                  ),
                  if (_isLoadingMore)
                    const SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        child: Center(child: DotLoadingIndicator(size: 20,)),
                      ),
                    ),
                ],
              );
            }
            return Center(child: Text(AppLocalizations.of(context)!.not_comics_available));
          },
        ),
      ),
    );
  }
}
