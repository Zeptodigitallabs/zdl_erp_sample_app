import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zdl_erp_sample_app/utils/colors.dart';

import '../../../utils/image_paths.dart';
import '../../../utils/strings.dart';
import 'login_viewModel.dart';

class LoginView extends StatelessWidget {
  String userType;
   LoginView({super.key,required this.userType});


  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<LoginViewModel>(context);
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
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 36,vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                        ),
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
                                )),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "$ksHi $userType",
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: kcPrimary,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  ksMsg1,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: kcGrey,
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          ],
                        ),

                        Container(
              padding: const EdgeInsets.all(5),
              child: FutureBuilder(
                future: viewModel.getSelectedSchool(),
                builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                  final selectedSchool = snapshot.data ?? 'Select School';

                  return GestureDetector(
                    onTap: () {
                      showModalBottomSheet<void>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent, // so your container's radius is visible
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
                                    image: AssetImage(
                                      kiBg,
                                    ),
                                  ),
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              ksSelectSchool,
                                              style: TextStyle(
                                                fontSize: 16,
                                                color: kcPrimary,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            GestureDetector(
                                              onTap: () => Navigator.pop(context),
                                              child: const CircleAvatar(
                                                radius: 16,
                                                child: Icon(Icons.close),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      SizedBox(
                                        height: 300,
                                        child: ListView.builder(
                                          itemCount: viewModel.schools.length,
                                          itemBuilder: (context, index) {
                                            final school = viewModel.schools[index][0];
                                            final schoolBaseUrl = viewModel.schools[index][1];

                                            return GestureDetector(
                                              onTap: () {
                                                viewModel.setSelectedSchool(school,schoolBaseUrl);
                                                Navigator.pop(context); // Close sheet
                                              },
                                              child: Card(
                                                color: kcWhite,
                                                elevation: 3,
                                                child: ListTile(
                                                  selected: viewModel.selectedSchool == school,
                                                  selectedTileColor: kcVeryLightPrimary,
                                                  title: Text(
                                                    school,
                                                    style: TextStyle(
                                                      color: kcBlack,
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  trailing: Icon(Icons.arrow_forward, color: kcBlack),
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
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: kcPrimary,width: 1),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kcPrimary,width: 1),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: kcPrimary, width: 2),
                          ),
                          labelStyle: TextStyle(
                            fontSize: 14,
                            color: kcPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                          hintStyle: TextStyle(
                            color: kcPrimary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          prefixIcon: Icon(Icons.school_rounded, color: kcPrimary),
                          suffixIcon: Icon(Icons.arrow_drop_down_rounded,
                              color: kcPrimary, size: 28),
                          labelText: selectedSchool,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: viewModel.usernameController,
                          style: TextStyle(
                              color: kcPrimary, fontSize: 14, fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kcPrimary),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kcPrimary, width: 2),
                              ),
                              labelStyle: TextStyle(
                                  fontSize: 14,
                                  color: kcPrimary,
                                  fontWeight: FontWeight.w600),
                              focusColor: kcPrimary,
                              hintStyle: TextStyle(
                                  color: kcPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600),
                              prefixIcon: Icon(
                                Icons.person,
                                color: kcPrimary,
                              ),
                              labelText: ksUserName),
                          cursorColor: kcPrimary,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          controller: viewModel.passwordController,
                          style: TextStyle(
                              color: kcPrimary, fontSize: 14, fontWeight: FontWeight.w600),
                          decoration: InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kcPrimary),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: kcPrimary, width: 2),
                            ),
                            labelStyle: TextStyle(
                                fontSize: 14,
                                color: kcPrimary,
                                fontWeight: FontWeight.w600),
                            focusColor: kcPrimary,
                            hintStyle: TextStyle(
                                color: kcPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            prefixIcon: Icon(
                              Icons.lock_open_rounded,
                              color: kcPrimary,
                            ),
                            labelText: ksPassword,
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  viewModel.setObscureText(!viewModel.isObScureText);
                                },
                                child: viewModel.isObScureText
                                    ? Icon(
                                  Icons.visibility,
                                  color: kcPrimary,
                                )
                                    : Icon(
                                  Icons.visibility_off,
                                  color: kcPrimary,
                                )),
                          ),
                          obscureText: viewModel.isObScureText,
                          cursorColor: kcPrimary,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: kcPrimary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              onPressed: (){
                                viewModel.authenticateUser(
                        viewModel.usernameController.text,
                                    viewModel.passwordController.text,
                                  context,
                                  userType
                                );
                              },
                              child: Text(
                                ksLogin,
                                style: TextStyle(
                                    color: kcWhite,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16),
                              )),
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
      Scaffold(
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                       viewModel.onBackPressed(context);
                       },
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: kcPrimary,
                    )),
                const SizedBox(
                  width: 12,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$ksHi Student",
                      style: TextStyle(
                          fontSize: 18,
                          color: kcPrimary,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      ksMsg1,
                      style: TextStyle(
                        fontSize: 14,
                        color: kcGrey,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              ],
            ),

            /*F.schoolItems.isEmpty
                ? Container()
                : Container(
              padding: const EdgeInsets.all(5),
              child: FutureBuilder(
                future: viewModel.getSelectedSchool(),
                builder: (BuildContext context,
                    AsyncSnapshot<dynamic> snapshot) {
                  return GestureDetector(
                    onTap: () {
                      viewModel
                          .showSchoolSelectionBottomSheet(snapshot.data);
                    },
                    child: TextField(
                      enabled: false,
                      style: context.bodyMedium!.copyWith(
                          color: kcPrimary,
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                      decoration: InputDecoration(
                          labelStyle: context.bodyMedium!.copyWith(
                              fontSize: 14,
                              color: kcPrimary,
                              fontWeight: FontWeight.w600),
                          focusColor: blackColor,
                          hintStyle: context.bodyMedium!.copyWith(
                              color: kcPrimary,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                          prefixIcon: Icon(
                            Icons.school_rounded,
                            color: kcPrimary,
                          ),
                          suffixIcon: Icon(
                            Icons.arrow_drop_down_rounded,
                            color: F.kcPrimary,
                            size: 28,
                          ),
                          labelText: snapshot.data),
                    ),
                  );
                },
              ),
            ),*/
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: viewModel.usernameController,
              style: TextStyle(
                  color: kcPrimary, fontSize: 14, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kcPrimary),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kcPrimary, width: 2),
                  ),
                  labelStyle: TextStyle(
                      fontSize: 14,
                      color: kcPrimary,
                      fontWeight: FontWeight.w600),
                  focusColor: kcPrimary,
                  hintStyle: TextStyle(
                      color: kcPrimary,
                      fontSize: 14,
                      fontWeight: FontWeight.w600),
                  prefixIcon: Icon(
                    Icons.person,
                    color: kcPrimary,
                  ),
                  labelText: ksUserName),
              cursorColor: kcPrimary,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFormField(
              controller: viewModel.passwordController,
              style: TextStyle(
                  color: kcPrimary, fontSize: 14, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kcPrimary),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: kcPrimary, width: 2),
                ),
                labelStyle: TextStyle(
                    fontSize: 14,
                    color: kcPrimary,
                    fontWeight: FontWeight.w600),
                focusColor: kcPrimary,
                hintStyle: TextStyle(
                    color: kcPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600),
                prefixIcon: Icon(
                  Icons.lock_open_rounded,
                  color: kcPrimary,
                ),
                labelText: ksPassword,
                suffixIcon: GestureDetector(
                    onTap: () {
                      viewModel.setObscureText(!viewModel.isObScureText);
                    },
                    child: viewModel.isObScureText
                        ? Icon(
                      Icons.visibility,
                      color: kcPrimary,
                    )
                        : Icon(
                      Icons.visibility_off,
                      color: kcPrimary,
                    )),
              ),
              obscureText: viewModel.isObScureText,
              cursorColor: kcPrimary,
            ),
            const SizedBox(
              height: 20,
            ),
            /*viewModel.isBusy
                ? Center(
              child: CircularProgressIndicator(
                color: kcPrimary,
              ),
            )
                :*/ Center(
                  child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kcPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  onPressed: (){
                    /*viewModel.authenticateUser(
                        usernameController.text, passwordController.text);*/
                  },
                  child: Text(
                    ksLogin,
                    style: TextStyle(
                        color: kcWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  )),
                ),


          ],
        ),
      )
    );
  }
}


