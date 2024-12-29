import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/favorites/manager/cubit/favorites_cubit.dart';
import 'package:movie_app/features/favorites/ui/widgets/favorites_screen%20_body.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoritesCubit()..getFavorites(),
      child: const FavoritesScreenBody(),
    );
  }
}
