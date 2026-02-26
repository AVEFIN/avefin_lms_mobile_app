import 'package:avefin_lms_mobile_app/widgets_design_system/button/button.dart';
import 'package:flutter/material.dart';

class WidgetTestView extends StatelessWidget {
  const WidgetTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Button Test")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Primary"),
            const SizedBox(height: 12),
            AppButton(
              child: Text("boton"),
              variant: AppButtonVariant.double, //has lots of variants
              onPressed: () => {},
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
