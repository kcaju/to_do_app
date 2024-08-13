import 'package:flutter/material.dart';
import 'package:to_do_app/utils/color_constants.dart';
import 'package:to_do_app/utils/image_constants.dart';

class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(ImageConstants.pic2),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Organize Your Tasks",
            style: TextStyle(
                color: ColorConstants.mainwhite,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Keep your tasks organized by category,priority or due date..",
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Swipe >>",
                style: TextStyle(color: ColorConstants.mainwhite, fontSize: 18),
              )
            ],
          )
        ],
      ),
      decoration: BoxDecoration(
        color: ColorConstants.green1,
      ),
    );
  }
}
