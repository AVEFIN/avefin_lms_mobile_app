import 'package:flutter/material.dart';

enum AveSelectCardVariant { defaultVariant, blueBackground, small }

/// A selectable card component used for single or multiple choice flows.
///
/// Behaves similarly to a radio or checkbox option.
/// Visual state is controlled externally via the [selected] property.
///
/// If [onTap] is null, the card renders in a disabled state.
class AveSelectCard extends StatelessWidget {
  /// Icon displayed above (or beside in small variant) the label.
  final Widget icon;

  /// Main text label describing the option.
  final String label;

  /// Callback triggered when the card is tapped.
  ///
  /// If null, the card becomes disabled and interaction is blocked.
  final VoidCallback? onTap;

  /// Visual style variant of the card.
  ///
  /// - [defaultVariant]: White background, primary border.
  /// - [blueBackground]: Colored background variant.
  /// - [small]: Compact horizontal layout.
  final AveSelectCardVariant variant;

  /// Whether the card is currently selected.
  ///
  /// This does not manage state internally.
  /// Parent widgets must control selection.
  final bool selected;

  /// Reduces the size/amount of decorative background circles.
  ///
  /// Only applies to large variants.
  final bool compressed;

  /// Whether decorative background circles are rendered.
  ///
  /// Only applies to large variants.
  final bool showCircles;

  /// Optional fixed width for the card.
  ///
  /// If null, size is determined by parent constraints.
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
    final isDisabled = onTap == null;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    // ---- SMALL VARIANT ----
    if (variant == AveSelectCardVariant.small) {
      return GestureDetector(
        onTap: isDisabled ? null : onTap,
        child: Opacity(
          opacity: isDisabled ? 0.5 : 1,
          child: Container(
            width: width ?? double.infinity,
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isDisabled
                  ? theme.disabledColor.withOpacity(.1)
                  : (selected ? primary : Colors.white),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDisabled ? theme.disabledColor : primary,
              ),
            ),
            child: Row(
              children: [
                IconTheme(
                  data: IconThemeData(
                    color: isDisabled
                        ? theme.disabledColor
                        : (selected ? Colors.white : primary),
                    size: 28,
                  ),
                  child: icon,
                ),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: TextStyle(
                    color: isDisabled
                        ? theme.disabledColor
                        : (selected ? Colors.white : primary),
                    fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    // ---- LARGE VARIANTS ----

    final backgroundColor = isDisabled
        ? theme.disabledColor.withOpacity(.1)
        : switch (variant) {
            AveSelectCardVariant.defaultVariant =>
              selected ? primary : Colors.white,
            AveSelectCardVariant.blueBackground =>
              selected ? primary : secondary,
            AveSelectCardVariant.small => Colors.white,
          };

    final textColor = isDisabled
        ? theme.disabledColor
        : (variant == AveSelectCardVariant.blueBackground
              ? Colors.white
              : (selected ? Colors.white : primary));

    return GestureDetector(
      onTap: isDisabled ? null : onTap,
      child: Opacity(
        opacity: isDisabled ? 0.5 : 1,
        child: Container(
          width: width,
          constraints: const BoxConstraints(minHeight: 190, minWidth: 150),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: variant == AveSelectCardVariant.blueBackground && selected
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
      children: sizes.map((size) {
        return Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: selected
                ? Colors.white.withOpacity(.15)
                : primary.withOpacity(.15),
          ),
        );
      }).toList(),
    );
  }
}
