import 'package:flutter/material.dart';

enum AveSelectCardVariant { defaultVariant, blueBackground, small }

/// A selectable card component used to represent an option with
/// an icon and label.
///
/// Supports multiple visual variants, selection state,
/// and optional decorative background elements.
class AveSelectCard extends StatefulWidget {
  /// The icon displayed inside the card.
  ///
  /// Typically an [Icon] or custom widget.
  final Widget icon;

  /// The primary text label shown below or beside the icon.
  final String label;

  /// Callback triggered when the card is tapped.
  ///
  /// If null, the card is rendered as disabled
  /// and does not respond to interaction.
  final VoidCallback? onTap;

  /// Determines the visual style and layout of the card.
  ///
  /// Controls background color, borders, and size variations.
  final AveSelectCardVariant variant;

  /// Whether the card is currently selected.
  ///
  /// Affects background color, text color, and emphasis styling.
  final bool selected;

  /// Reduces the size and number of decorative background circles
  /// when enabled.
  final bool compressed;

  /// Whether decorative background circles are displayed
  /// behind the icon (only applies to large variants).
  final bool showCircles;

  /// Optional fixed width for the card.
  ///
  /// If null, the card sizes itself according to layout constraints.
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
  State<AveSelectCard> createState() => _AveSelectCardState();
}

class _AveSelectCardState extends State<AveSelectCard> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onTap == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final isDisabled = widget.onTap == null;
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    Widget content;

    // ---- SMALL VARIANT ----
    if (widget.variant == AveSelectCardVariant.small) {
      content = Container(
        width: widget.width ?? double.infinity,
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isDisabled
              ? theme.disabledColor.withOpacity(.1)
              : (widget.selected ? primary : Colors.white),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDisabled ? theme.disabledColor : primary),
        ),
        child: Row(
          children: [
            IconTheme(
              data: IconThemeData(
                color: isDisabled
                    ? theme.disabledColor
                    : (widget.selected ? Colors.white : primary),
                size: 28,
              ),
              child: widget.icon,
            ),
            const SizedBox(width: 12),
            Text(
              widget.label,
              style: TextStyle(
                color: isDisabled
                    ? theme.disabledColor
                    : (widget.selected ? Colors.white : primary),
                fontWeight: widget.selected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    } else {
      // ---- LARGE VARIANTS ----

      final backgroundColor = isDisabled
          ? theme.disabledColor.withOpacity(.1)
          : switch (widget.variant) {
              AveSelectCardVariant.defaultVariant =>
                widget.selected ? primary : Colors.white,
              AveSelectCardVariant.blueBackground =>
                widget.selected ? primary : secondary,
              AveSelectCardVariant.small => Colors.white,
            };

      final textColor = isDisabled
          ? theme.disabledColor
          : (widget.variant == AveSelectCardVariant.blueBackground
                ? Colors.white
                : (widget.selected ? Colors.white : primary));

      content = Container(
        width: widget.width,
        constraints: const BoxConstraints(minHeight: 190, minWidth: 150),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color:
                widget.variant == AveSelectCardVariant.blueBackground &&
                    widget.selected
                ? Colors.white
                : primary,
          ),
        ),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            if (widget.showCircles &&
                widget.variant != AveSelectCardVariant.small)
              Positioned(
                top: 20,
                child: _CircleBackground(
                  primary: primary,
                  selected: widget.selected,
                  compressed: widget.compressed,
                ),
              ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 56),
                IconTheme(
                  data: IconThemeData(size: 40, color: textColor),
                  child: widget.icon,
                ),
                const SizedBox(height: 55),
                Text(
                  widget.label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: widget.selected
                        ? FontWeight.w600
                        : FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Opacity(
      opacity: isDisabled ? 0.5 : 1,
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        onTap: isDisabled ? null : widget.onTap,
        child: AnimatedScale(
          scale: _pressed ? 0.99 : 1.0,
          duration: const Duration(milliseconds: 80),
          curve: Curves.easeOut,
          child: content,
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
