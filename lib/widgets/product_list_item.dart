import 'package:flutter/material.dart';
import 'package:watchyy/styles/styles.dart';
import 'package:watchyy/widgets/widgets.dart';

class ProductListItem extends StatelessWidget {
  const ProductListItem({
    super.key,
    required this.name,
    required this.onPressed,
  });

  final String name;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.inverseSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: WASpacings.md.vertical + WASpacings.sm.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: AppTheme.of(context).appTypography.bodyLarge,
              ),
              Icon(
                WAIcons.chevronRight,
                color: colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
