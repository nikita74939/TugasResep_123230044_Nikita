import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../domain/entities/meail_detail.dart';

class IngredientList extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientList({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    final validIngredients = ingredients.where((i) => i.isValid).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: validIngredients.asMap().entries.map((entry) {
        final i = entry.value;
        final isLast = entry.key == validIngredients.length - 1;
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    '${i.measure.trim()} ${i.name.trim()}',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                      height: 1.4,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            if (!isLast) ...[
              const SizedBox(height: 4),
              const Divider(color: AppColors.divider, height: 12, thickness: 1),
            ],
          ],
        );
      }).toList(),
    );
  }
}
