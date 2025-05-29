import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ui/views/login/login_viewModel.dart';
import 'ui/views/option_selection/option_selection_viewModel.dart';
import 'ui/views/startup/startup_view.dart';


// Step 1: Define a global navigator key
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => OptionSelectionViewModel()),
          ChangeNotifierProvider(create: (context) => LoginViewModel())
        ],
      child: MaterialApp(
        navigatorKey: navigatorKey,
        debugShowCheckedModeBanner: false,
        home: StartupView(),
      ),
    );
  }
}
