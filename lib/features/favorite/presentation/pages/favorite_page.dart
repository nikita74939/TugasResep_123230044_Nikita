import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/datasources/favorite_local_datasource.dart';
import '../../data/repositories/favorite_repository_impl.dart';
import '../../domain/entities/favorite_meal.dart';
import '../widgets/favorite_card.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final _repo = FavoriteRepositoryImpl(
    localDatasource: FavoriteLocalDatasource(),
  );

  late List<FavoriteMeal> _favorites;

  @override
  void initState() {
    super.initState();
    _favorites = _repo.getAllFavorites();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _refresh();
  }

  void _refresh() {
    setState(() {
      _favorites = _repo.getAllFavorites();
    });
  }

  Future<void> _removeFavorite(String id) async {
    await _repo.removeFavorite(id);
    _refresh();
  }

  @override
  Widget build(BuildContext context) {
    if (_favorites.isEmpty) {
      return const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, size: 64, color: AppColors.textHint),
            SizedBox(height: 12),
            Text(
              'Belum ada favorit',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Tambahkan resep ke favorit dari halaman detail.',
              style: TextStyle(fontSize: 13, color: AppColors.textHint),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemCount: _favorites.length,
      itemBuilder: (_, index) {
        final meal = _favorites[index];
        return FavoriteCard(
          meal: meal,
          onRemove: () => _removeFavorite(meal.id),
        );
      },
    );
  }
}