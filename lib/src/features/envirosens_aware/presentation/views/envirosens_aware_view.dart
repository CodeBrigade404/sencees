import 'package:flutter/material.dart';
import 'package:sencees/src/features/envirosens_aware/classes/custom_snack_bar.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sencees/src/features/envirosens_aware/classes/model.dart';
import 'package:sencees/src/features/envirosens_aware/constants.dart';
import 'package:sencees/src/features/envirosens_aware/presentation/views/listening_screen.dart';

class EnvirosensAware extends StatefulWidget {
  const EnvirosensAware({super.key});

  @override
  State<EnvirosensAware> createState() => _EnvirosensAwareState();
}

class _EnvirosensAwareState extends State<EnvirosensAware> {
  List<Model> models = [];
  Model? selectedModel;
  bool isLoading = false;

  // Allows fetching models in creating the context
  Future<void> loadModels() async {
    setState(() => isLoading = true);
    try {
      List<Model> fetchedModels = await fetchModels();
      setState(() {
        models = fetchedModels;
        selectedModel = models.isNotEmpty ? models.first : null;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            backColor: kWarningRedColor,
            time: 3,
            title: 'Failed to fetch models'),
      );
      print('Error fetching models: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  // Allows fetching models through button
  Future<List<Model>> fetchModels() async {
    final uri = Uri.parse(
        'https://4tnwcv11y4.execute-api.ap-south-1.amazonaws.com/get_approved_models');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // print(data);
      if (data['status'] == 'success') {
        List<dynamic> jobs = data['jobs'];
        return jobs.map((job) => Model.fromJson(job)).toList();
      } else {
        throw Exception('Failed to fetch models');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        CustomSnackBar(
            backColor: kWarningRedColor,
            time: 3,
            title: 'Failed to connect to API'),
      );
      throw Exception('Failed to connect to API');
    }
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case "warning":
        return Icons.warning;
      case "EnvirosensAware":
        return Icons.home;
      case "location_city":
        return Icons.location_city;
      case "nightlight_round":
        return Icons.nightlight_round;
      case "factory":
        return Icons.factory;
      case "nature":
        return Icons.nature;
      case "work":
        return Icons.work;
      case "park":
        return Icons.park;
      case "directions_car":
        return Icons.directions_car;
      case "tune":
        return Icons.tune;
      case "pets":
        return Icons.pets;
      case "train":
        return Icons.train;
      case "phone_in_talk":
        return Icons.phone_in_talk;
      case "alarm":
        return Icons.alarm;
      case "child_care":
        return Icons.child_care;
      default:
        return Icons.auto_awesome; // Fallback icon
    }
  }

  @override
  void initState() {
    super.initState();
    loadModels();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          onRefresh: fetchModels,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image:
                      AssetImage("assets/images/background/noise_image.webp"),
                  fit: BoxFit.cover),
            ),
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(color: kDeepBlueColor),
                  )
                : Column(
                    children: [
                      Container(
                          margin: const EdgeInsets.symmetric(vertical: 16.0),
                          child: const Text(
                            "Welcome!",
                            style: kHeadingTextStyle,
                          )),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3, // Number of columns
                              mainAxisSpacing: 10.0, // Vertical spacing
                              // crossAxisSpacing: 10.0, // Horizontal spacing
                              childAspectRatio: 0.7, // Make tiles square
                            ),
                            itemCount: models.length,
                            itemBuilder: (context, index) {
                              final item = models[index];
                              return _buildTile(item);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _buildTile(Model model) {
    return Column(
      children: [
        Material(
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioUploader(
                    jobId: model.jobId,
                    approveName: model.approveName,
                  ),
                ),
              );
            },
            splashColor: kOceanBlueColor.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              padding: const EdgeInsets.all(30.0),
              decoration: BoxDecoration(
                color: kOceanBlueColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Icon(
                _getIconData(model.iconName),
                size: 50,
                color: kOceanBlueColor,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Text(
          model.approveName, // Display approve name
          textAlign: TextAlign.center,
          style: kSubTitleTextStyle,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
