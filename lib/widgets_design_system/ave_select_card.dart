import 'package:flutter/material.dart';

enum AveSelectCardVariant { defaultVariant, blueBackground, small }

class AveSelectCard extends StatelessWidget {
  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final AveSelectCardVariant variant;
  final bool selected;
  final bool compressed;
  final bool showCircles;
  final double? width;

  const AveSelectCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.variant = AveSelectCardVariant.defaultVariant,
    this.selected = false,
    this.compressed = false,
    this.showCircles = true,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    // ---- SMALL VARIANT ----
    if (variant == AveSelectCardVariant.small) {
      return GestureDetector(
        onTap: onTap,
        child: Container(
          width: width ?? double.infinity,
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: selected ? primary : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: primary),
          ),
          child: Row(
            children: [
              IconTheme(
                data: IconThemeData(
                  color: selected ? Colors.white : primary,
                  size: 28,
                ),
                child: icon,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: selected ? Colors.white : primary,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // ---- LARGE VARIANTS ----

    final backgroundColor = switch (variant) {
      AveSelectCardVariant.defaultVariant => selected ? primary : Colors.white,
      AveSelectCardVariant.blueBackground => selected ? primary : secondary,
      AveSelectCardVariant.small => Colors.white,
    };

    final textColor =
        variant == AveSelectCardVariant.blueBackground
            ? (selected ? Colors.white : Colors.white)
            : (selected ? Colors.white : primary);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        constraints: const BoxConstraints(minHeight: 190, minWidth: 150),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                variant == AveSelectCardVariant.blueBackground && selected
                    ? Colors.white
                    : primary,
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            if (showCircles && variant != AveSelectCardVariant.small)
              Positioned(
                top: 20,
                child: _CircleBackground(
                  primary: primary,
                  selected: selected,
                  compressed: compressed,
                ),
              ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 56),
                IconTheme(
                  data: IconThemeData(size: 40, color: textColor),
                  child: icon,
                ),
                const SizedBox(height: 55),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CircleBackground extends StatelessWidget {
  final Color primary;
  final bool selected;
  final bool compressed;

  const _CircleBackground({
    required this.primary,
    required this.selected,
    required this.compressed,
  });

  @override
  Widget build(BuildContext context) {
    final sizes = compressed ? [55.0, 95.0, 125.0] : [55.0, 75.0, 95.0, 115.0];

    return Stack(
      alignment: Alignment.center,
      children:
          sizes.map((size) {
            return Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    selected
                        ? Colors.white.withOpacity(.15)
                        : primary.withOpacity(.15),
              ),
            );
          }).toList(),
    );
  }
}
