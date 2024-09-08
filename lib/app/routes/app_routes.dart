import 'package:comic_vine_app/features/comic_vine/data/repositories/comic_repository_mock.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_bloc.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/blocs/comic/comic_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/pages/comic_list_page.dart';
import 'package:comic_vine_app/features/comic_vine/presentation/pages/comic_detail_page.dart';

/// Configuration of the app routes using GoRouter.
/// Defines navigation paths and how pages are connected.
class AppRoutes {
  // Define the router and its routes
  static final GoRouter router = GoRouter(
    routes: [
      // Route for the comic list page (home page)
      GoRoute(
        path: '/',
        name: 'comicList',
        builder: (context, state) => const ComicListPage(),
      ),
      // Dynamic route for the comic detail page, passing comic ID as parameter
      GoRoute(
        path: '/comic/:id',
        name: 'comicDetail',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;

          return BlocProvider(
            create: (context) => ComicBloc(ComicRepositoryMock())..add(FetchComics()),
            child: ComicDetailPage(comicId: id),
          );
        },
      ),
    ],
  );
}
