import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../../domain/entities/favorite_meal.dart';

class FavoriteCard extends StatelessWidget {
  final FavoriteMeal meal;
  final VoidCallback onRemove;

  const FavoriteCard({
    super.key,
    required this.meal,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        AppRoutes.detail,
        arguments: meal.id,
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Konten card
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar
                Expanded(
                  child: Image.network(
                    meal.thumbnailUrl,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: AppColors.shimmer,
                      child: const Icon(Icons.broken_image,
                          color: AppColors.textHint),
                    ),
                  ),
                ),

                // Nama resep
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    meal.name,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),

            // Tombol hapus (X) di pojok kanan atas
            Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                onTap: onRemove,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Icons.close,
                    size: 16,
                    color: AppColors.favorite,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}