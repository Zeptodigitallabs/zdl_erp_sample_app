import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdl_erp_sample_app/utils/colors.dart';

import '../../../utils/image_paths.dart';
import '../../../utils/strings.dart';
import 'role_selection_viewModel.dart';

class RoleSelectionView extends StatelessWidget {
  const RoleSelectionView({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RoleSelectionViewModel>(context);
    return Scaffold(
      backgroundColor: kcWhite,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [splashBGColorStart, splashBGColorEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        height: MediaQuery.of(context).size.height,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 260,
              bottom: 0,
              left: 0,
              right: 0,
              child: Card(
                elevation: 5,
                margin: const EdgeInsets.all(0),
                color: kcWhite,
                surfaceTintColor: kcWhite,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      opacity: 0.05,
                      repeat: ImageRepeat.repeat,
                      image: AssetImage(
                        kiBg,
                        // ),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const SizedBox(height: 40),
                        Text(
                          ksMsg,
                          style: TextStyle(
                            fontSize: 20,
                            color: kcPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 30),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              viewModel.selectedLoginType(ksStudent, context);
                            },
                            child: Card(
                              color: kcWhite,
                              surfaceTintColor: kcWhite,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: kcPrimary, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: SizedBox(
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Image.asset(kiStudent),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      ksStudent,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: kcPrimary,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              viewModel.selectedLoginType(ksParent, context);
                            },
                            child: Card(
                              color: kcWhite,
                              surfaceTintColor: kcWhite,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: kcPrimary, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: SizedBox(
                                height: 80,
                                child: SizedBox(
                                  height: 80,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Image.asset(kiParent),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        ksParent,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: kcPrimary,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: GestureDetector(
                            onTap: () {
                              viewModel.selectedLoginType(ksStaff, context);
                            },
                            child: Card(
                              color: kcWhite,
                              surfaceTintColor: kcWhite,
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: kcPrimary, width: 1),
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                              ),
                              child: SizedBox(
                                height: 80,
                                child: SizedBox(
                                  height: 80,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: Image.asset(kiStaff),
                                      ),
                                      const SizedBox(width: 12),
                                      Text(
                                        ksStaff,
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: kcPrimary,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(left: -30, right: 0, top: 90, child: Image.asset(kiLoginTopLogo)),
          ],
        ),
      ),
    );
  }
}
