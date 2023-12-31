import 'package:agriappadmin/model/login_model.dart';
import 'package:agriappadmin/provider/login_provider.dart';
import 'package:agriappadmin/screen/NBForgotPasswordScreen.dart';
import 'package:agriappadmin/screen/NBHomeScreen.dart';
import 'package:agriappadmin/screen/NBSingUpScreen.dart';
import 'package:agriappadmin/utils/NBColors.dart';
import 'package:agriappadmin/utils/NBImages.dart';
import 'package:agriappadmin/utils/NBWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class NBSignInScreen extends StatefulWidget {
  static String tag = '/NBSignInScreen';

  @override
  NBSignInScreenState createState() => NBSignInScreenState();
}

class NBSignInScreenState extends State<NBSignInScreen> {
  final _signInFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  FocusNode emailFocus = FocusNode();
  FocusNode passwordFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    var loginNotifier = Provider.of<LoginNotifier>(context);

    return Consumer<LoginNotifier>(builder: (context, LoginNotifier, child) {
      LoginNotifier.getPrefs();
      print(LoginNotifier.entrypoint);
      return Scaffold(
        body: SingleChildScrollView(
          child: Form(
            key: _signInFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                100.height,
                Text('Welcome to\nNews Blog', style: boldTextStyle(size: 30)),
                30.height,
                nbAppTextFieldWidget(
                  emailController,
                  'Email Address',
                  TextFieldType.EMAIL,
                  focus: emailFocus,
                  nextFocus: passwordFocus,
                ),
                16.height,
                nbAppTextFieldWidget(
                    passwordController, 'Password', TextFieldType.PASSWORD,
                    focus: passwordFocus),
                16.height,
                Align(
                  alignment: Alignment.centerRight,
                  child: Text('Forgot Password?',
                          style: boldTextStyle(color: NBPrimaryColor))
                      .onTap(
                    () {
                      NBForgotPasswordScreen().launch(context);
                    },
                  ),
                ),
                16.height,
                nbAppButtonWidget(
                  context,
                  'Sign In',
                  () {
                    //print("JHHHH");
                    // NBHomeScreen().launch(context);
                    if (_signInFormKey.currentState!.validate()) {
                      LoginModel model = LoginModel(
                          email: emailController.text,
                          password: passwordController.text);
                      loginNotifier.userLogin(model);
                    } else {
                      Get.snackbar("Sign Failed", "Check Your Credential",
                          colorText: Colors.white,
                          backgroundColor: Colors.red,
                          icon: const Icon(Icons.add_alert));
                    }
                  },
                ),
                30.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account?', style: primaryTextStyle()),
                    Text(' Sign Up',
                            style: boldTextStyle(color: NBPrimaryColor))
                        .onTap(
                      () {
                        //NBSingUpScreen().launch(context);
                      },
                    ),
                  ],
                ),
                50.height,
                Row(
                  children: [
                    Divider(thickness: 2).expand(),
                    8.width,
                    Text('Or Sign In with', style: secondaryTextStyle()),
                    8.width,
                    Divider(thickness: 2).expand(),
                  ],
                ),
                16.height,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppButton(
                      child: Row(
                        children: [
                          Image.asset(NBFacebookLogo, width: 20, height: 20),
                          8.width,
                          Text('Facebook',
                              style: primaryTextStyle(color: white)),
                        ],
                      ),
                      onTap: () {},
                      width: (context.width() - (3 * 16)) * 0.5,
                      color: NBFacebookColor,
                      elevation: 0,
                    ).cornerRadiusWithClipRRect(20),
                    16.width,
                    AppButton(
                      child: Row(
                        children: [
                          Image.asset(NBGoogleLogo, width: 20, height: 20),
                          8.width,
                          Text('Google', style: primaryTextStyle(color: black)),
                        ],
                      ),
                      onTap: () {},
                      width: (context.width() - (3 * 16)) * 0.5,
                      elevation: 0,
                      shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(width: 1, color: grey),
                      ),
                    ),
                  ],
                ),
              ],
            ).paddingOnly(left: 16, right: 16),
          ),
        ),
      );
    });
  }
}
