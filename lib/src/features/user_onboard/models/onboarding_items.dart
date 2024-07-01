import '../repository/onboarding_info.dart';

class OnboardingItems {
  List<OnboardingInfo> items = [
    OnboardingInfo(
        title: "Stay Connected",
        descriptions:
            "Receive notifications when someone nearby speaks to you, ensuring you never miss important interactions",
        image: "assets/onboarding/image1.png"),
    OnboardingInfo(
        title: "Stay Aware",
        descriptions:
            "This feature enables the app to detect and notify users whenever a vehicle horn is sounded in their vicinity while they are traveling",
        image: "assets/onboarding/image2.png"),
    OnboardingInfo(
        title: "Stay Informed",
        descriptions:
            "Explore Your Surroundings with Environment Sound Feedback. helping them stay connected and aware of their surroundings",
        image: "assets/onboarding/image3.png"),
    OnboardingInfo(
        title: "Stay Safe",
        descriptions:
            "Receive Timely Alerts for Natural Disasters. App provides users with warnings for various natural disasters, helping them stay safe and informed.",
        image: "assets/onboarding/image4.png"),
  ];
}
