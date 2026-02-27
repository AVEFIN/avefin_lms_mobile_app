import 'package:flutter/material.dart';

enum AppButtonVariant {
  primary,
  destructive,
  outline,
  secondary,
  ghost,
  link,
  double,
  doubleWhite,
  discreteDelete,
}

/// A reusable design-system button component.
///
/// Supports multiple visual variants and a disabled state.
/// If [onPressed] is null, the button renders as disabled
/// and does not respond to user interaction.
class AppButton extends StatefulWidget {
  /// The content displayed inside the button.
  ///
  /// Typically a [Text], [Icon], or a combination of both.
  final Widget child;

  /// Callback executed when the button is tapped.
  ///
  /// If null, the button is considered disabled and
  /// no press interaction will occur.
  final VoidCallback? onPressed;

  /// Determines the visual style and layout of the button.
  ///
  /// Controls background color, text color, borders,
  /// and special layouts such as double variants.
  final AppButtonVariant variant;

  /// Optional fixed width for the button.
  ///
  /// If null, the button sizes itself based on its content.
  final double? width;

  const AppButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.width,
  });

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (widget.onPressed == null) return;
    setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDisabled = widget.onPressed == null;

    if (widget.variant == AppButtonVariant.double ||
        widget.variant == AppButtonVariant.doubleWhite) {
      return _buildDouble(context, isDisabled);
    }

    Color background;
    Color foreground;
    BorderSide? border;

    switch (widget.variant) {
      case AppButtonVariant.primary:
        background = theme.colorScheme.primary;
        foreground = Colors.white;
        break;
      case AppButtonVariant.secondary:
        background = theme.colorScheme.secondary;
        foreground = Colors.white;
        break;
      case AppButtonVariant.destructive:
        background = Colors.red;
        foreground = Colors.white;
        break;
      case AppButtonVariant.outline:
        background = Colors.transparent;
        foreground = theme.colorScheme.primary;
        border = BorderSide(color: theme.dividerColor);
        break;
      case AppButtonVariant.ghost:
        background = Colors.transparent;
        foreground = theme.textTheme.bodyLarge?.color ?? Colors.black;
        break;
      case AppButtonVariant.link:
        background = Colors.transparent;
        foreground = theme.colorScheme.primary;
        break;
      case AppButtonVariant.discreteDelete:
        background = theme.dividerColor.withOpacity(.2);
        foreground = Colors.red;
        border = BorderSide(color: theme.dividerColor);
        break;
      case AppButtonVariant.double:
      case AppButtonVariant.doubleWhite:
        background = Colors.transparent;
        foreground = theme.colorScheme.primary;
        break;
    }

    if (isDisabled) {
      background = theme.disabledColor.withOpacity(0.1);
      foreground = theme.disabledColor;
      border = BorderSide(color: theme.disabledColor.withOpacity(0.3));
    }

    final core = Container(
      width: widget.width,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
        border: border != null ? Border.fromBorderSide(border) : null,
      ),
      alignment: Alignment.center,
      child: DefaultTextStyle(
        style: TextStyle(color: foreground, fontWeight: FontWeight.w400),
        child: widget.child,
      ),
    );

    return Opacity(
      opacity: isDisabled ? 0.6 : 1,
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        onTap: isDisabled ? null : widget.onPressed,
        child: AnimatedScale(
          scale: _pressed ? 0.99 : 1.0,
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeOut,
          child: core,
        ),
      ),
    );
  }

  Widget _buildDouble(BuildContext context, bool isDisabled) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    final isWhite = widget.variant == AppButtonVariant.doubleWhite;

    final textColor = isDisabled
        ? theme.disabledColor
        : (isWhite ? secondary : Colors.white);

    final leftBackground = isDisabled
        ? theme.disabledColor.withOpacity(0.1)
        : (isWhite ? Colors.white : secondary);

    final rightBackground = isDisabled
        ? theme.disabledColor.withOpacity(0.1)
        : primary;

    final content = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: widget.width,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: leftBackground,
            borderRadius: BorderRadius.circular(6),
          ),
          alignment: Alignment.center,
          child: DefaultTextStyle(
            style: TextStyle(color: textColor, fontWeight: FontWeight.w400),
            child: widget.child,
          ),
        ),
        const SizedBox(width: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 7),
          decoration: BoxDecoration(
            color: rightBackground,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
        ),
      ],
    );

    return Opacity(
      opacity: isDisabled ? 0.6 : 1,
      child: GestureDetector(
        onTapDown: (_) => _setPressed(true),
        onTapUp: (_) => _setPressed(false),
        onTapCancel: () => _setPressed(false),
        onTap: isDisabled ? null : widget.onPressed,
        child: AnimatedScale(
          scale: _pressed ? 0.99 : 1.0,
          duration: const Duration(milliseconds: 90),
          curve: Curves.easeOut,
          child: content,
        ),
      ),
    );
  }
}
