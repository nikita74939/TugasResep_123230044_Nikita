import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../data/datasources/detail_remote_datasource.dart';
import '../../data/repositories/detail_repository_impl.dart';
import '../../domain/entities/meail_detail.dart';
import '../widgets/favorite_button.dart';
import '../widgets/ingredient_list.dart';
import '../../../favorite/data/datasources/favorite_local_datasource.dart';
import '../../../favorite/data/repositories/favorite_repository_impl.dart';
import '../../../favorite/domain/entities/favorite_meal.dart';

class DetailPage extends StatefulWidget {
  final String mealId;

  const DetailPage({super.key, required this.mealId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final _detailRepo = DetailRepositoryImpl(
    remoteDatasource: DetailRemoteDatasource(),
  );
  final _favoriteRepo = FavoriteRepositoryImpl(
    localDatasource: FavoriteLocalDatasource(),
  );

  late Future<MealDetail> _detailFuture;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Selalu fetch ulang dari API saat halaman dibuka
    _detailFuture = _detailRepo.getMealDetail(widget.mealId);
    _isFavorite = _favoriteRepo.isFavorite(widget.mealId);
  }

  Future<void> _toggleFavorite(MealDetail detail) async {
    if (_isFavorite) {
      await _favoriteRepo.removeFavorite(detail.id);
    } else {
      await _favoriteRepo.addFavorite(FavoriteMeal(
        id: detail.id,
        name: detail.name,
        thumbnailUrl: detail.thumbnailUrl,
      ));
    }
    setState(() => _isFavorite = !_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: FutureBuilder<MealDetail>(
        future: _detailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.primary),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: AppColors.shimmer,
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Icon(Icons.error_outline_rounded,
                          size: 32, color: AppColors.textHint),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Gagal memuat detail resep.',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => setState(() {
                        _detailFuture =
                            _detailRepo.getMealDetail(widget.mealId);
                      }),
                      child: const Text('Coba Lagi'),
                    ),
                  ],
                ),
              ),
            );
          }

          final detail = snapshot.data!;
          return _buildContent(detail);
        },
      ),
    );
  }

  Widget _buildContent(MealDetail detail) {
    return CustomScrollView(
      slivers: [
        // AppBar dengan foto resep sebagai background
        SliverAppBar(
          expandedHeight: 300,
          pinned: true,
          backgroundColor: AppColors.surface,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  color: AppColors.textPrimary,
                  size: 18,
                ),
              ),
            ),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
              detail.thumbnailUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  Container(color: AppColors.shimmer),
            ),
          ),
        ),

        // Konten detail
        SliverToBoxAdapter(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Chip Kategori & Asal Negara
                  Wrap(
                    spacing: 8,
                    children: [
                      _buildChip(Icons.category_rounded, detail.category),
                      _buildChip(Icons.public_rounded, detail.area),
                    ],
                  ),
                  const SizedBox(height: 14),

                  // Nama resep
                  Text(
                    detail.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      height: 1.2,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Tombol Favorit
                  FavoriteButton(
                    isFavorite: _isFavorite,
                    onTap: () => _toggleFavorite(detail),
                  ),
                  const SizedBox(height: 28),

                  // Divider section
                  _buildSectionHeader('🧂 Bahan-bahan'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IngredientList(ingredients: detail.ingredients),
                  ),
                  const SizedBox(height: 24),

                  // Cara memasak
                  _buildSectionHeader('👨‍🍳 Cara Memasak'),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      detail.instructions,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                        height: 1.7,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 17,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
        letterSpacing: -0.3,
      ),
    );
  }

  Widget _buildChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 5),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}