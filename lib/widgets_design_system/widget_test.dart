import 'package:avefin_lms_mobile_app/widgets_design_system/button/button.dart';
import 'package:flutter/material.dart';

class WidgetTestView extends StatelessWidget {
  const WidgetTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Widgets Test")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppButton(
              child: Text("boton"),
              variant: AppButtonVariant.double,
              onPressed: () => {},
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
