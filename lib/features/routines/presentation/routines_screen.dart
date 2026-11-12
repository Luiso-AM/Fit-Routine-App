import 'package:flutter/material.dart';

import '../../../core/strings/app_strings.dart';

class RoutinesScreen extends StatelessWidget {
  const RoutinesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text(AppStrings.tabRoutines)));
  }
}
