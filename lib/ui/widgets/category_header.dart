import 'package:flutter/material.dart';
import 'package:movies_app/utils/app_colors.dart';
import 'package:movies_app/utils/app_styles.dart';

class CategoryHeader extends StatelessWidget {
  final String categoryTitle;
  final VoidCallback onSeeMoreTap;

  CategoryHeader({
    required this.categoryTitle,
    required this.onSeeMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(categoryTitle, style: AppStyles.regular20White),
        InkWell(
          onTap: onSeeMoreTap,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('See More', style: AppStyles.regular16Yellow),
              SizedBox(width: 8),
              Icon(Icons.arrow_forward_outlined, color: AppColors.yellowColor, size: 15),
            ],
          ),
        ),
      ],
    );
  }
}
