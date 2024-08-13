import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/utils/color_constants.dart';
import 'package:to_do_app/utils/image_constants.dart';
import 'package:to_do_app/view/home_screen/home_screen.dart';
import 'package:to_do_app/view/on_boarding_screen/on_boarding_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController pass = TextEditingController();
  late final SharedPreferences prefs;
  @override
  void initState() {
    login();
    super.initState();
  }

  login() async {
    prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = await prefs.getBool('isLoggedIn') ?? false;
    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightblue,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                ImageConstants.logo,
                height: 90,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Welcome !!",
              style: TextStyle(
                  color: ColorConstants.mainwhite,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Create your timing !",
              style: TextStyle(
                  color: ColorConstants.mainwhite,
                  fontSize: 18,
                  fontWeight: FontWeight.normal),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (name.text.isNotEmpty) {
                          return null;
                        } else {
                          return "Enter your Name";
                        }
                      },
                      style: TextStyle(color: ColorConstants.mainwhite),
                      controller: name,
                      decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: TextStyle(color: ColorConstants.mainwhite),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (pass.text.isNotEmpty) {
                          return null;
                        } else {
                          return "Enter a password";
                        }
                      },
                      style: TextStyle(color: ColorConstants.mainwhite),
                      obscureText: true,
                      controller: pass,
                      decoration: InputDecoration(
                          hintText: "Password",
                          suffixIcon: Icon(
                            Icons.visibility_off,
                            color: ColorConstants.mainwhite,
                          ),
                          hintStyle: TextStyle(color: ColorConstants.mainwhite),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                    ),
                  ],
                ),
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: ColorConstants.blue3),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    await prefs.setString('name', name.text);
                    await prefs.setString('phone', pass.text);
                    await prefs.setBool('isLoggedIn', true);
                    if (formKey.currentState!.validate()) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OnBoardingScreen(),
                        ),
                      );
                    } else {
                      print("Not validated");
                    }
                  },
                  style: ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(ColorConstants.blue3),
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)))),
                  child: Text(
                    "TAKE ME IN",
                    style: TextStyle(
                        color: ColorConstants.mainwhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
