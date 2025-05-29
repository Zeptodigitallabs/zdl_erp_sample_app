import 'package:flutter/material.dart';

import '../option_selection/option_selection_view.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();// Initialize the SDK here
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OptionSelectionView()),
      );
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
