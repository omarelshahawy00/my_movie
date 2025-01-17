import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_app/core/helpers/get_it.dart';
import 'package:movie_app/features/actor_details/data/repo/actor_repo_impl.dart';
import 'package:movie_app/features/actor_details/manager/actor_cubit/actor_cubit.dart';
import 'package:movie_app/features/actor_details/manager/actor_movies_cubit/actor_movies_cubit.dart';
import 'package:movie_app/features/actor_details/ui/actor_details_screen.dart';
import 'package:movie_app/features/favorites/data/models/favorites_model.dart';
import 'package:movie_app/features/favorites/manager/add_to_favorites_cubit/add_to_favorites_cubit.dart';
import 'package:movie_app/features/home/data/models/movie_model.dart';
import 'package:movie_app/features/home/data/repos/home_repo_impl.dart';
import 'package:movie_app/features/home/manager/all_movies_cubit/all_movies_cubit.dart';
import 'package:movie_app/features/home/manager/navbar_cubit/bottom_navbar_cubit.dart';
import 'package:movie_app/features/home/ui/home_screen.dart';
import 'package:movie_app/features/movie_details/data/models/cast_model.dart';
import 'package:movie_app/features/movie_details/data/repos/details_repo_impl.dart';
import 'package:movie_app/features/movie_details/manager/cast_cubit/cast_cubit.dart';
import 'package:movie_app/features/movie_details/manager/trailer/trailer_cubit.dart';
import 'package:movie_app/features/movie_details/ui/movie_details_screen.dart';
import 'package:movie_app/features/splash/ui/splash_screen.dart';
import 'package:movie_app/main_view.dart';

import '../../features/home/manager/category_cubit/category_cubit.dart';
import '../../features/home/manager/trending_movies_cubit/trending_movie_cubit.dart';

class Routes {
  late final MovieModel movie;
  static const String homeScreen = '/homeScreen';
  static const String splashScreen = '/splashScreen';
  static const String mainView = '/mainView';
  static const String movieDetailsScreen = '/movieDetailsScreen';
  static const String searchScreen = '/searchScreen';
  static const String actorDetailsScreen = '/actorDetailsScreen';

  static final router = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(
        path: mainView,
        builder: (BuildContext context, GoRouterState state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) =>
                    TrendingMovieCubit(getIt.get<HomeRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => AllMoviesCubit(getIt.get<HomeRepoImpl>()),
              ),
              BlocProvider(create: (context) => CategoryCubit()),
              BlocProvider(create: (context) => BottomNavbarCubit()),
            ],
            child: BottomNavBar(),
          );
        },
      ),
      GoRoute(
        path: movieDetailsScreen,
        builder: (BuildContext context, GoRouterState state) {
          final movie = state.extra as MovieModel;

          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => CastCubit(getIt.get<DetailsRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => TrailerCubit(getIt.get<DetailsRepoImpl>()),
              ),
              BlocProvider(
                create: (context) => AddToFavoritesCubit(),
              ),
            ],
            child: MovieDetailsScreen(
              movie: movie,
            ),
          );
        },
      ),
      GoRoute(
        path: splashScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const SplashScreen();
        },
      ),
      GoRoute(
        path: homeScreen,
        builder: (BuildContext context, GoRouterState state) {
          return const HomeScreen();
        },
      ),
      GoRoute(
        path: actorDetailsScreen,
        builder: (BuildContext context, GoRouterState state) {
          final cast = state.extra as CastModel; // Extract the actor object
          return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => ActorCubit(getIt.get<ActorRepoImpl>()),
              ),
              BlocProvider(
                create: (context) =>
                    ActorMoviesCubit(getIt.get<ActorRepoImpl>()),
              ),
            ],
            child: ActorDetailsScreen(cast: cast),
          );
        },
      ),
    ],
  );
}
