import 'package:flutter/material.dart';
import 'package:avefin_lms_mobile_app/widgets_design_system/ave_select_card.dart';
import 'package:avefin_lms_mobile_app/widgets_design_system/button.dart';
import 'package:avefin_lms_mobile_app/widgets_design_system/step_navigation.dart';

class WidgetTestView extends StatefulWidget {
  const WidgetTestView({super.key});

  @override
  State<WidgetTestView> createState() => _WidgetTestViewState();
}

class _WidgetTestViewState extends State<WidgetTestView> {
  int currentStep = 0;
  String? personType = "fisica"; // mock enabled state

  final List<StepItem> steps = const [
    StepItem(icon: Icon(Icons.info_outline), label: "Info. general"),
    StepItem(icon: Icon(Icons.home_outlined), label: "Domicilio"),
    StepItem(icon: Icon(Icons.phone_outlined), label: "Contacto"),
    StepItem(icon: Icon(Icons.description_outlined), label: "Resumen"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Widgets Test")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Step Navigation Example
            StepNavigation(
              disabled: personType == null,
              steps: steps,
              currentStep: currentStep,
              onStepChange: (index) {
                setState(() => currentStep = index);
              },
            ),

            const SizedBox(height: 32),

            /// Button Example
            AppButton(
              child: const Text("Botón primario"),
              variant: AppButtonVariant.primary,
              onPressed: () {
                debugPrint("Button pressed");
              },
            ),

            const SizedBox(height: 32),

            /// Select Card Example
            AveSelectCard(
              icon: const Icon(Icons.home_sharp),
              label: "Persona moral (empresa)",
              onTap: () {
                debugPrint("Card tapped");
              },
              variant: AveSelectCardVariant.defaultVariant,
              selected: true,
            ),
          ],
        ),
      ),
    );
  }
}
