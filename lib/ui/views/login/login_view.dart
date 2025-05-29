import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdl_erp_sample_app/main.dart';
import 'package:zdl_erp_sample_app/utils/colors.dart';
import 'package:zdl_erp_sdk/models/zdl_erp_options.dart';
import 'package:zdl_erp_sdk/zdl_erp_sdk.dart';

import '../../../utils/image_paths.dart';
import '../../../utils/strings.dart';
import 'login_viewModel.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  void initState() {
    ZdlErpSdk.instance.init(navigatorKey.currentContext!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
    return Scaffold(
      backgroundColor: kcWhite,
      body: SingleChildScrollView(
        child: Container(
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
                        image: AssetImage(kiBg),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 40),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  viewModel.onBackPressed(context);
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: kcPrimary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                ksMsg1,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: kcPrimary,
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                          ),

                          Container(
                            padding: const EdgeInsets.all(5),
                            child: FutureBuilder<List<String>>(
                              future: viewModel.getSelectedSchool(),
                              builder: (
                                BuildContext context,
                                AsyncSnapshot<List<String>> snapshot,
                              ) {
                                List<String> selectedSchool =
                                    snapshot.data ?? schools[0];

                                return GestureDetector(
                                  onTap: () {
                                    showModalBottomSheet<void>(
                                      context: context,
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      // so your container's radius is visible
                                      builder: (context) {
                                        return Container(
                                          decoration: const BoxDecoration(
                                            color: kcWhite,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(40.0),
                                              topRight: Radius.circular(40.0),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: kcWhite,
                                                image: DecorationImage(
                                                  opacity: 0.05,
                                                  repeat: ImageRepeat.repeat,
                                                  image: AssetImage(kiBg),
                                                ),
                                              ),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                            8.0,
                                                          ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            ksSelectSchool,
                                                            style: TextStyle(
                                                              fontSize: 16,
                                                              color: kcPrimary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap:
                                                                () =>
                                                                    Navigator.pop(
                                                                      context,
                                                                    ),
                                                            child:
                                                                const CircleAvatar(
                                                                  radius: 16,
                                                                  child: Icon(
                                                                    Icons.close,
                                                                  ),
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(height: 15),
                                                    SizedBox(
                                                      height: 300,
                                                      child: ListView.builder(
                                                        itemCount:
                                                           schools
                                                                .length,
                                                        itemBuilder: (
                                                          context,
                                                          index,
                                                        ) {
                                                          final school =
                                                              schools[index][0];
                                                          return GestureDetector(
                                                            onTap: () {
                                                              viewModel.setSelectedSchool(
                                                                  schools[index]
                                                              );
                                                              Navigator.pop(
                                                                context,
                                                              ); // Close sheet
                                                            },
                                                            child: Card(
                                                              color: kcWhite,
                                                              elevation: 3,
                                                              child: ListTile(
                                                                selected:
                                                                    viewModel
                                                                        .selectedSchool[0] ==
                                                                    school,
                                                                selectedTileColor:
                                                                    kcVeryLightPrimary,
                                                                title: Text(
                                                                  school,
                                                                  style: TextStyle(
                                                                    color:
                                                                        kcBlack,
                                                                    fontSize:
                                                                        16,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                                trailing: Icon(
                                                                  Icons
                                                                      .arrow_forward,
                                                                  color:
                                                                      kcBlack,
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: AbsorbPointer(
                                    child: TextFormField(
                                      readOnly: true,
                                      style: TextStyle(
                                        color: kcPrimary,
                                        fontSize: 16,
                                      ),
                                      decoration: InputDecoration(
                                        border: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kcPrimary,
                                            width: 1,
                                          ),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kcPrimary,
                                            width: 1,
                                          ),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: kcPrimary,
                                            width: 2,
                                          ),
                                        ),
                                        prefixIcon: Icon(
                                          Icons.school_rounded,
                                          color: kcPrimary,
                                        ),
                                        suffixIcon: Icon(
                                          Icons.arrow_drop_down_rounded,
                                          color: kcPrimary,
                                          size: 28,
                                        ),
                                        labelText: selectedSchool[0],
                                        labelStyle: TextStyle(fontSize: 16,color: kcPrimary)
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          FutureBuilder(
                            future:
                            Provider.of<LoginViewModel>(context, listen: false)
                                .getSelectedUserType(),
                            builder: (BuildContext context,
                                AsyncSnapshot<UserRole> snapshot) {
                              return GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    backgroundColor: Colors.white,
                                    context: context,
                                    builder: (context) {
                                      return Card(
                                        color: Colors.white,
                                        surfaceTintColor: Colors.white,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(15.0),
                                              topRight: Radius.circular(15.0)),
                                        ),
                                        elevation: 2.0,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 20, right: 20, top: 15),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Text(
                                                      "I want to login as",
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color:
                                                          kcPrimary,
                                                          fontWeight:
                                                          FontWeight.bold),
                                                    ),
                                                    GestureDetector(
                                                        onTap: () async {
                                                          setState(() {
                                                            Navigator.pop(context);
                                                          });
                                                        },
                                                        child: const CircleAvatar(
                                                            backgroundColor:
                                                            kcPrimary,
                                                            radius: 16,
                                                            child:
                                                            Icon(Icons.close,color: Colors.white,))),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    Provider.of<LoginViewModel>(
                                                        context,
                                                        listen: false)
                                                        .setLoginType(UserRole.student);
                                                    setState(() {
                                                      Navigator.of(context).pop();
                                                    });
                                                  },
                                                  child: Card(
                                                    elevation: 5,
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: kcPrimary,
                                                          width: 1),
                                                      borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                    ),
                                                    color: Colors.white,
                                                    surfaceTintColor: Colors.white,
                                                    child: SizedBox(
                                                      height: 60,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                              child: Image.asset(
                                                                  'assets/images/students.png'),
                                                            ),
                                                            const SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text(
                                                              'Student',
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color:
                                                                  kcPrimary,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () async {
                                                    Provider.of<LoginViewModel>(
                                                        context,
                                                        listen: false)
                                                        .setLoginType(UserRole.parent);
                                                    setState(() {
                                                      Navigator.of(context).pop();
                                                    });
                                                  },
                                                  child: Card(
                                                    color: Colors.white,
                                                    surfaceTintColor: Colors.white,
                                                    elevation: 5,
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: kcPrimary,
                                                          width: 1),
                                                      borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                    ),
                                                    child: SizedBox(
                                                      height: 60,
                                                      child: Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                              child: Image.asset(
                                                                  'assets/images/parents.png'),
                                                            ),
                                                            const SizedBox(
                                                              width: 12,
                                                            ),
                                                            Text(
                                                              "Parent",
                                                              style: TextStyle(
                                                                  fontSize: 18,
                                                                  color:
                                                                  kcPrimary,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                            ),
                                                          ]),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Provider.of<LoginViewModel>(
                                                        context,
                                                        listen: false)
                                                        .setLoginType(UserRole.staff);
                                                    setState(() {
                                                      Navigator.of(context).pop();
                                                    });
                                                  },
                                                  child: Card(
                                                    color: Colors.white,
                                                    surfaceTintColor: Colors.white,
                                                    elevation: 5,
                                                    shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: kcPrimary,
                                                          width: 1),
                                                      borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(10)),
                                                    ),
                                                    child: SizedBox(
                                                      height: 60,
                                                      child: SizedBox(
                                                        height: 80,
                                                        child: Row(
                                                            mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                const EdgeInsets
                                                                    .all(15.0),
                                                                child: Image.asset(
                                                                    'assets/images/staff.png'),
                                                              ),
                                                              const SizedBox(
                                                                width: 12,
                                                              ),
                                                              Text(
                                                                "Staff",
                                                                style: TextStyle(
                                                                    fontSize: 18,
                                                                    color:
                                                                    kcPrimary,
                                                                    fontWeight:
                                                                    FontWeight
                                                                        .normal),
                                                              ),
                                                            ]),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: TextFormField(
                                  enabled: false,
                                  style: TextStyle(color: kcPrimary, fontSize: 16),
                                  decoration: InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(color: kcPrimary),
                                        borderRadius: BorderRadius.circular(0.0),
                                      ),
                                      fillColor: Colors.transparent,
                                      labelStyle: TextStyle(
                                          color: kcPrimary, fontSize: 16),
                                      prefixIcon: Icon(
                                        Icons.person_3_rounded,
                                        color: kcPrimary,
                                      ),
                                      suffixIcon: Icon(
                                        Icons.arrow_drop_down_rounded,
                                        color: kcPrimary,
                                        size: 36,
                                      ),
                                      labelText: snapshot.data?.value),
                                ),
                              );
                            },
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: viewModel.usernameController,
                            style: TextStyle(
                              color: kcPrimary,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kcPrimary),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: kcPrimary,
                                  width: 2,
                                ),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 16,
                                color: kcPrimary,
                              ),
                              focusColor: kcPrimary,
                              hintStyle: TextStyle(
                                color: kcPrimary,
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(Icons.person, color: kcPrimary),
                              labelText: ksUserName,
                            ),
                            cursorColor: kcPrimary,
                          ),
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: viewModel.passwordController,
                            style: TextStyle(
                              color: kcPrimary,
                              fontSize: 16,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kcPrimary),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: kcPrimary,
                                  width: 2,
                                ),
                              ),
                              labelStyle: TextStyle(
                                fontSize: 16,
                                color: kcPrimary,
                              ),
                              focusColor: kcPrimary,
                              hintStyle: TextStyle(
                                color: kcPrimary,
                                fontSize: 16,
                              ),
                              prefixIcon: Icon(
                                Icons.lock_open_rounded,
                                color: kcPrimary,
                              ),
                              labelText: ksPassword,
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  viewModel.setObscureText(
                                    !viewModel.isObScureText,
                                  );
                                },
                                child:
                                    viewModel.isObScureText
                                        ? Icon(
                                          Icons.visibility,
                                          color: kcPrimary,
                                        )
                                        : Icon(
                                          Icons.visibility_off,
                                          color: kcPrimary,
                                        ),
                              ),
                            ),
                            obscureText: viewModel.isObScureText,
                            cursorColor: kcPrimary,
                          ),
                          const SizedBox(height: 20),
                          Center(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kcPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: () {
                                viewModel.authenticateUser(
                                  viewModel.usernameController.text,
                                  viewModel.passwordController.text,
                                  context,
                                  UserRole.student,
                                );
                              },
                              child: Text(
                                ksLogin,
                                style: TextStyle(
                                  color: kcWhite,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
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
              Positioned(
                left: -30,
                right: 0,
                top: 90,
                child: Image.asset(kiLoginTopLogo),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
