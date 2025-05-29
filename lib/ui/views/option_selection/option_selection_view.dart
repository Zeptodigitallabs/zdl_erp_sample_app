import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdl_erp_sample_app/utils/colors.dart';
import 'package:zdl_erp_sdk/zdl_erp_sdk.dart';

import '../../../main.dart';
import 'option_selection_viewModel.dart';

class OptionSelectionView extends StatefulWidget {
  const OptionSelectionView({super.key});

  @override
  State<OptionSelectionView> createState() => _OptionSelectionViewState();
}

class _OptionSelectionViewState extends State<OptionSelectionView> {

  @override
  void initState() {
    ZdlErpSdk.instance.init(navigatorKey.currentContext!);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<OptionSelectionViewModel>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40),
              Center(child: Image.asset('assets/images/schoolerp_logo.png')),
              SizedBox(height: 60),

              // Button 1: Token Login
              viewModel.isLoading
                  ? CircularProgressIndicator(color: kcPrimary)
                  : OutlinedButton(
                    onPressed: () async {
                      viewModel.showSchoolSelectionSheet(context);
                      //viewModel.callUnifiedLoginApiAndOpenSDK(context);
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 24,
                      ),
                      side: BorderSide(color: kcPrimary, width: 1.5),
                    ),
                    child: Text(
                      "Open ZDL ERP SDK Using Unified Login API.",
                      style: TextStyle(fontSize: 16, color: kcPrimary),
                    ),
                  ),

              SizedBox(height: 20),

              // Button 2: Username + Password Login
              OutlinedButton(
                onPressed: () {
                  viewModel.openLoginScreen(context);
                },
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  side: BorderSide(color: kcPrimary, width: 1.5),
                ),
                child: Text(
                  "Open ZDL ERP SDK Using Username and Password.",
                  style: TextStyle(fontSize: 16, color: kcPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
