import 'package:flutter/material.dart';
import 'package:to_do_app/utils/color_constants.dart';
import 'package:to_do_app/utils/image_constants.dart';
import 'package:to_do_app/view/login_screen/login_screen.dart';

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(ImageConstants.pic1),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Congratulations !",
            style: TextStyle(
                color: ColorConstants.mainwhite,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "You're ready to start using your to-do app, to manage your tasks and stay organised",
            style: TextStyle(
              color: ColorConstants.mainwhite,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  child: Row(
                    children: [
                      Text(
                        "Let's GO",
                        style: TextStyle(
                          color: ColorConstants.mainwhite,
                          fontSize: 20,
                        ),
                      ),
                      Icon(
                        Icons.keyboard_double_arrow_right,
                        color: ColorConstants.mainwhite,
                        size: 18,
                      )
                    ],
                  ))
            ],
          )
        ],
      ),
      color: ColorConstants.blue1,
    );
  }
}
