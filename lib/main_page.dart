import 'package:bmi_cal/constants.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // define variables
  int height = 150;
  int weight = 50;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20), // padding for the whole container
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.male, size: 150),
                            Text('Male'),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(), // separated the two columns
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Column(
                          children: const [
                            Icon(Icons.female, size: 150),
                            Text('Female'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 50), // add dynamic space value
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const Text('Height'),
                            Text(
                              '$height',
                              style: TextStyle(
                                color:
                                    kTextColor, // use the constant from the constants.dart file
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      if (height > 50) {
                                        height--;
                                      }
                                    });
                                    print(height);
                                  },
                                  child: const Icon(Icons.remove, size: 40),
                                ),
                                const SizedBox(
                                  width: 12,
                                ), // add dynamic space value
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      if (height < 220) {
                                        height++;
                                      }
                                    });
                                    print('H P');
                                  },
                                  child: const Icon(Icons.add, size: 40),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Spacer(), // separated the two columns
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Column(
                          children: [
                            const Text('Weight'),
                            Text(
                              '$weight',
                              style: TextStyle(
                                color:
                                    kTextColor, // use the constant from the constants.dart file
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      if (weight > 30) {
                                        weight--;
                                      }
                                    });
                                    print("W M");
                                  },
                                  child: const Icon(Icons.remove, size: 40),
                                ),
                                const SizedBox(
                                  width: 12,
                                ), // add dynamic space value
                                FloatingActionButton(
                                  onPressed: () {
                                    setState(() {
                                      if (weight < 200) {
                                        weight++;
                                      }
                                    });
                                    print('W P');
                                  },
                                  child: const Icon(Icons.add, size: 40),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Column(
                children: [
                  Text('BMI'),
                  Text(
                    '22.3',
                    style: kInputLabelColor.copyWith(
                      color: kOutputTextColor, // add style from constants.dart
                      fontSize: 60,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // function define for calculating BMI
  void calculateBMI() {}
}
