import 'package:material_ui/material_ui.dart';

import '../../../core/strings/app_strings.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text(AppStrings.tabProfile)));
  }
}
