import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Shared/Components.dart';

class OnBoarding extends StatefulWidget {
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int currentIndex = 0;
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      buildOnBoard("assets/images/onboarding1.png",
          "Add Items to Cart and Confirm Order", context),
      buildOnBoard(
          "assets/images/onboarding2.png", "Track Your Order", context),
      buildOnBoard("assets/images/onboarding3.png",
          "Pay on Delivery Enjoy your Shopping", context),
    ];

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              children: pages,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              physics: BouncingScrollPhysics(),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              navigateToLogin(context);
            },
            child: const Text(
              "Get Started",
              style: TextStyle(fontSize: 18),
            ),
            style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(const Color(0xff3b75a8))),
          ),
          const SizedBox(height: 30),
          SmoothPageIndicator(
            controller: pageController,
            count: pages.length,
            effect: const ColorTransitionEffect(
                dotHeight: 12, dotWidth: 12, activeDotColor: Color(0xff3b75a8)),
          ),
          const SizedBox(height: 30),
        ],
      ),
      floatingActionButton: TextButton(
        onPressed: () {
          if (currentIndex != pages.length - 1) {
            pageController.nextPage(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOutQuad);
          } else {
            navigateToLogin(context);
          }
        },
        child: const Icon(Icons.arrow_forward_ios),
        style: ButtonStyle(
            textStyle: MaterialStateProperty.all(
                const TextStyle(color: Color(0xff3b75a8)))),
      ),
    );
  }
}
