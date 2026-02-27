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

class AppButton extends StatefulWidget {
  final Widget child;
  final VoidCallback onPressed;
  final AppButtonVariant variant;
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

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final double? width = widget.width;

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
        foreground = theme.textTheme.bodyLarge!.color!;
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

    Widget buttonChild = widget.child;

    Widget core = Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(6),
        border: border != null ? Border.fromBorderSide(border) : null,
      ),
      alignment: Alignment.center,
      child:
          widget.variant == AppButtonVariant.link
              ? Container(
                padding: const EdgeInsets.only(bottom: 1),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: foreground, width: 1.5),
                  ),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(
                    color: foreground,
                    fontWeight: FontWeight.w400,
                  ),
                  child: buttonChild,
                ),
              )
              : DefaultTextStyle(
                style: TextStyle(
                  color: foreground,
                  fontWeight: FontWeight.w400,
                ),
                child: buttonChild,
              ),
    );

    // Double variant
    if (widget.variant == AppButtonVariant.double ||
        widget.variant == AppButtonVariant.doubleWhite) {
      return _buildDouble(context, width);
    }

    return GestureDetector(onTap: widget.onPressed, child: core);
  }

  Widget _buildDouble(BuildContext context, double? width) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    final isWhite = widget.variant == AppButtonVariant.doubleWhite;

    final textColor = isWhite ? secondary : Colors.white;
    final leftBackground = isWhite ? Colors.white : secondary;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: width,
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
            color: primary,
            borderRadius: BorderRadius.circular(6),
          ),
          child: const Icon(Icons.arrow_forward, size: 18, color: Colors.white),
        ),
      ],
    );
  }
}
