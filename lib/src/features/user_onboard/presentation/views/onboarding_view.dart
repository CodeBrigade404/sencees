import 'package:flutter/material.dart';
import 'package:sencees/src/core/components/app_default_button.dart';
import 'package:sencees/src/core/constants/app_colors.dart';
import 'package:sencees/src/features/authentication/presentation/views/login_view.dart';
import 'package:sencees/src/features/user_onboard/models/onboarding_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      bottomSheet: Container(
        color: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage
            ? Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: AppDefaultButton(
                    text: "Get Started",
                    backgroundColor: AppColors.appLightBlue,
                    onPressed: () async {
                      final prefs = await SharedPreferences.getInstance();
                      prefs.setBool("onboarding", true);
                      if (!context.mounted) return;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginView()));
                    }),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Skip Button
                  TextButton(
                      onPressed: () => pageController
                          .jumpToPage(controller.items.length - 1),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.appDarkGray,
                      ),
                      child: const Text("Skip")),

                  // Indicator
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(index,
                        duration: const Duration(milliseconds: 600),
                        curve: Curves.easeIn),
                    effect: ExpandingDotsEffect(
                        dotHeight: 12,
                        dotWidth: 15,
                        activeDotColor: AppColors.appYellow,
                        dotColor: Theme.of(context).disabledColor),
                  ),

                  // Next Button
                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn),
                      style: TextButton.styleFrom(
                        foregroundColor: AppColors.appDarkGray,
                      ),
                      child: const Text("Next")),
                ],
              ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
            onPageChanged: (index) => setState(
                () => isLastPage = controller.items.length - 1 == index),
            itemCount: controller.items.length,
            controller: pageController,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(controller.items[index].image),
                  const SizedBox(height: 15),
                  Text(
                    controller.items[index].title,
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 15),
                  Text(controller.items[index].descriptions,
                      style: const TextStyle(
                          color: AppColors.appDarkGray, fontSize: 17),
                      textAlign: TextAlign.center),
                ],
              );
            }),
      ),
    );
  }
}
