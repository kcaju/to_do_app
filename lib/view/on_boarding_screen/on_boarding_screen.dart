import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:to_do_app/utils/color_constants.dart';
import 'package:to_do_app/view/on_boarding_screen/pages/page1.dart';
import 'package:to_do_app/view/on_boarding_screen/pages/page2.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.lightblue,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 700,
              child: PageView(
                controller: _controller,
                children: [Page1(), Page2()],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SmoothPageIndicator(
              controller: _controller,
              count: 2,
              effect: ExpandingDotsEffect(
                  activeDotColor: ColorConstants.mainwhite,
                  dotColor: ColorConstants.mainblack),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
