import 'package:avefin_lms_mobile_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StepItem {
  final Widget? icon;
  final String label;

  const StepItem({this.icon, required this.label});
}

enum StepNavigationVariant { primary, secondary }

/// A custom horizontal step navigation component used to represent
/// multi-step flows such as large forms or onboarding processes.
///
/// Each step is rendered as a pill containing an optional icon
/// and a label. The component visually distinguishes between:
///
/// - Completed steps (solid connector + filled pill)
/// - Active step (half solid / half dashed connector)
/// - Upcoming steps (dashed connector + outlined pill)
///
/// The widget is responsive:
/// - On wide screens, both icon and label are displayed.
/// - On constrained widths, only the icon is shown to prevent overflow.
///
/// Supports a disabled state that blocks interaction and
/// a visual variant system for styling flexibility.
class StepNavigation extends StatelessWidget {
  /// Whether all step interactions are disabled.
  ///
  /// When true, step pills cannot be tapped and appear inactive.
  final bool disabled;

  /// The ordered list of steps to render in the navigation.
  ///
  /// Each [StepItem] defines the icon and label displayed in a pill.
  final List<StepItem> steps;

  /// The index of the currently active step.
  ///
  /// Steps with an index lower than this value are marked as completed.
  final int currentStep;

  /// Callback triggered when a step pill is tapped.
  ///
  /// Returns the index of the selected step.
  final ValueChanged<int> onStepChange;

  /// Defines the visual styling variant of the step navigation.
  ///
  /// Controls background behavior for non-active steps.
  final StepNavigationVariant variant;

  const StepNavigation({
    super.key,
    this.disabled = false,
    required this.steps,
    required this.currentStep,
    required this.onStepChange,
    this.variant = StepNavigationVariant.primary,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;

    return LayoutBuilder(
      builder: (context, constraints) {
        final totalWidth = constraints.maxWidth;
        final widthPerStep = totalWidth / steps.length;

        // You can tweak this threshold
        final showLabels = widthPerStep > 120;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Row(
            children: List.generate(steps.length, (index) {
              final isCompleted = index < currentStep;
              final isActive = index == currentStep;

              return Expanded(
                flex: index == steps.length - 1 ? 0 : 1,
                child: Row(
                  children: [
                    _StepPill(
                      step: steps[index],
                      isCompleted: isCompleted,
                      isActive: isActive,
                      disabled: disabled,
                      primary: primary,
                      secondary: secondary,
                      variant: variant,
                      showLabel: showLabels,
                      onTap: () => onStepChange(index),
                    ),
                    if (index < steps.length - 1)
                      Expanded(
                        child: _Connector(
                          isCompleted: isCompleted,
                          isActive: isActive,
                          primary: primary,
                          secondary: secondary,
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),
        );
      },
    );
  }
}

class _StepPill extends StatelessWidget {
  final StepItem step;
  final bool isCompleted;
  final bool isActive;
  final bool disabled;
  final Color primary;
  final Color secondary;
  final StepNavigationVariant variant;
  final VoidCallback onTap;
  final bool showLabel;

  const _StepPill({
    required this.step,
    required this.isCompleted,
    required this.isActive,
    required this.disabled,
    required this.primary,
    required this.secondary,
    required this.variant,
    required this.onTap,
    required this.showLabel,
  });

  @override
  Widget build(BuildContext context) {
    final isFilled = isCompleted || isActive;

    final background = isFilled
        ? primary
        : (variant == StepNavigationVariant.secondary
              ? Colors.white
              : AppColors.lightBorderSubtle);

    final textColor = isFilled ? Colors.white : primary;

    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(999),
          border: Border.all(
            color: isFilled
                ? primary
                : AppColors.lightBorderSubtle.withAlpha(80),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (step.icon != null)
              IconTheme(
                data: IconThemeData(
                  size: 18,
                  color: isFilled ? textColor : primary.withAlpha(80),
                ),
                child: step.icon!,
              ),
            if (showLabel && step.icon != null) const SizedBox(width: 8),
            if (showLabel)
              Text(
                step.label,
                style: TextStyle(
                  color: textColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Connector extends StatelessWidget {
  final bool isCompleted;
  final bool isActive;
  final Color primary;
  final Color secondary;

  const _Connector({
    required this.isCompleted,
    required this.isActive,
    required this.primary,
    required this.secondary,
  });

  @override
  Widget build(BuildContext context) {
    if (isCompleted) {
      return Container(height: 2, color: primary);
    }

    if (isActive) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Container(height: 2, color: primary)),
          Expanded(
            child: CustomPaint(
              size: const Size(double.infinity, 1),
              painter: _DashedLinePainter(AppColors.lightBorderSubtle),
            ),
          ),
        ],
      );
    }

    return CustomPaint(
      size: const Size(double.infinity, 1),
      painter: _DashedLinePainter(AppColors.lightBorderSubtle),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final Color color;

  _DashedLinePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    const dashWidth = 6.0;
    const dashSpace = 4.0;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2;

    double startX = 0;
    while (startX < size.width) {
      canvas.drawLine(Offset(startX, 0), Offset(startX + dashWidth, 0), paint);
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
