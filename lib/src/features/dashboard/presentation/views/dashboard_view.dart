import 'package:flutter/material.dart';
import 'package:flutter_popup/flutter_popup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:sencees/src/features/authentication/controllers/user_controller.dart';
import 'package:sencees/src/features/authentication/presentation/views/login_view.dart';
import 'package:sencees/src/features/communication_analyzer/presentation/views/communication_analyzer_view.dart';
import 'package:sencees/src/features/communication_assist/presentation/views/communication_assist_view.dart';
import 'package:sencees/src/features/envirosens_aware/presentation/views/envirosens_aware_view.dart';
import 'package:sencees/src/features/warnalert_aware/presentation/views/warnalert_aware_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    ref.read(userControllerProvider.notifier).fetchUser();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userState = ref.watch(userControllerProvider).asData?.value;

    final titles = [
      "Communication\nAnalyzer",
      "Communication\nAssist",
      "WarnAlert\nAware",
      "EnviroSens\nAware",
    ];
    final subtitles = [
      "Stay Connected",
      "Stay Aware",
      "Stay Safe",
      "Stay Informed",
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Hi! Good Morning ,",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                        ),
                        Text(
                          '${userState?.firstName} ${userState?.lastName}',
                          style: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  CustomPopup(
                    backgroundColor: Theme.of(context).dialogBackgroundColor,
                    arrowColor: Theme.of(context).dialogBackgroundColor,
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () async {},
                          child: const SizedBox(
                            width: 100,
                            height: 40,
                            child: Row(
                              children: [
                                Icon(Icons.person_2_outlined),
                                SizedBox(width: 8),
                                Text(
                                  'Amount',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                          height: 10,
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        InkWell(
                          onTap: () async {},
                          child: const SizedBox(
                            width: 100,
                            height: 40,
                            child: Row(
                              children: [
                                Icon(Icons.settings_outlined),
                                SizedBox(width: 8),
                                Text(
                                  'Settings',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 100,
                          height: 10,
                          child: Divider(
                            height: 1,
                            thickness: 1,
                            color: Colors.grey,
                          ),
                        ),
                        InkWell(
                          onTap: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.remove("accessToken");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginView(),
                              ),
                            );
                          },
                          child: const SizedBox(
                            width: 100,
                            height: 40,
                            child: Row(
                              children: [
                                Icon(Icons.logout),
                                SizedBox(width: 8),
                                Text(
                                  'Logout',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 25, // Adjust the radius as needed
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                  ),
                ],
              ),
              Center(
                child: SizedBox(
                  height: 250,
                  child: Image.asset(
                    'assets/images/dash_img3.png',
                    fit: BoxFit.cover, // Adjust how the image fits
                  ),
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.70,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    final animationPath = 'assets/lottie/${index + 1}.json';

                    // Define the pages to navigate to
                    final pages = [
                      const CommunicationAnalyzerView(),
                      const CommunicationAssistView(),
                      const WarnAlertAwareView(),
                      const EnvirosensAware(),
                    ];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => pages[index],
                          ),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: Padding(
                                  padding: (index == 1 || index == 3) ? const EdgeInsets.all(14.0) : EdgeInsets.zero,
                                  child: Lottie.asset(
                                    animationPath,
                                    controller: _controller,
                                    onLoaded: (composition) {
                                      _controller
                                        ..duration = composition.duration
                                        ..repeat();
                                    },
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    titles[index],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    subtitles[index],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
    );
  }
}
