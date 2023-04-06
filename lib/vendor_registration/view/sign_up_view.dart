import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/firebase_auth_view_model.dart';
import 'package:sportner_venue_manager/utils/global_colors.dart';
import 'package:sportner_venue_manager/utils/global_values.dart';
import 'package:sportner_venue_manager/utils/navigations.dart';
import 'package:sportner_venue_manager/utils/textstyles.dart';
import 'package:sportner_venue_manager/vendor_registration/view_model/sign_up_view_model.dart';
import '../components/login_button_widget.dart';
import '../components/registering_text_widget.dart';
import '../components/text_form_field.dart';

class VendorSignUpScreen extends StatefulWidget {
  const VendorSignUpScreen({super.key});

  @override
  State<VendorSignUpScreen> createState() => _VendorSignUpScreenState();
}

class _VendorSignUpScreenState extends State<VendorSignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController countryCode = TextEditingController();

  @override
  void initState() {
    countryCode.text = "+91";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //    const SystemUiOverlayStyle(statusBarColor: MyColors.appMainGreenColor));
    final signUpProvider = context.watch<SignUpViewModel>();
    TextEditingController userNameController =
        signUpProvider.userNameController;
    TextEditingController phoneController = signUpProvider.phoneController;
    TextEditingController passController = signUpProvider.passController;
    TextEditingController confirfPassController =
        signUpProvider.confirfPassController;
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset("assets/login_top.svg"),
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MySize.kHeight50,
                        Text("Create Account",
                            style: MyTextStyles.loginHeadingStyle),
                        const Text(
                          "Hey, Let's get rolling",
                          style: TextStyle(
                            color: MyColors.kGreyColor,
                          ),
                        ),
                        MySize.kHeight40,
                        TextFormWidget(
                          isUser: true,
                          controller: userNameController,
                          labelText: 'Name',
                          textFieldIcon: Icons.person_outline,
                          keyType: TextInputType.text,
                        ),
                        TextFormWidget(
                          isPhone: true,
                          controller: phoneController,
                          labelText: 'Phone',
                          textFieldIcon: Icons.phone_iphone,
                          keyType: TextInputType.number,
                        ),
                        TextFormWidget(
                          isPassword: true,
                          controller: passController,
                          labelText: 'Password',
                          textFieldIcon: Icons.lock_outline,
                          keyType: TextInputType.text,
                        ),
                        TextFormWidget(
                          isConfPass: true,
                          controller: confirfPassController,
                          labelText: 'Confirm Password',
                          textFieldIcon: Icons.lock_outline,
                          keyType: TextInputType.text,
                        ),
                        MySize.kHeight10,
                        Container(
                          padding: const EdgeInsets.only(left: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black12,
                          ),
                          width: double.infinity,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Add Gov. approve Document",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: MyColors.kButtonColor),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: MyColors.appMainGreenColor,
                                  ),
                                  width: 90,
                                  height: 30,
                                  child: const Center(
                                      child: Text(
                                    "Choose file",
                                    style: TextStyle(
                                      color: MyColors.kWhiteColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                        MySize.kHeight40,
                        LoginButtonWidget(
                          title: "CREATE ACCOUNT",
                          onPressed: userNameController.text.isEmpty ||
                                  phoneController.text.isEmpty ||
                                  passController.text.isEmpty ||
                                  confirfPassController.text.isEmpty
                              ? null
                              : () async {
                                  if (_formKey.currentState!.validate()) {
                                    await context
                                        .read<FirebaseAuthViewModel>()
                                        .fireBasePhoneAuth(context);
                                  }
                                },
                        ),
                        MySize.kHeight30,
                        RegisteringText(
                          leftText: 'Already have an account? ',
                          rightText: "Login",
                          onTap: () {
                            Navigator.pushReplacementNamed(
                                context, NavigatorClass.loginScreen);
                            context.read<SignUpViewModel>().clearTextField();
                            context
                                .read<SignUpViewModel>()
                                .checkTextFieldisEmpty();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
