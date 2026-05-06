import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';

class FavoriteButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;

  const FavoriteButton({
    super.key,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: ElevatedButton.icon(
        onPressed: onTap,
        icon: Icon(
          isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded,
          size: 20,
        ),
        label: Text(isFavorite ? 'Hapus dari Favorit' : 'Simpan ke Favorit'),
        style: ElevatedButton.styleFrom(
          backgroundColor: isFavorite
              ? AppColors.favorite.withOpacity(0.1)
              : AppColors.primary,
          foregroundColor:
              isFavorite ? AppColors.favorite : Colors.white,
          elevation: 0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}