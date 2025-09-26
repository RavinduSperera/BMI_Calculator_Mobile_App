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
  String gender = '';
  late double bmi = calculateBMI(height: height, weight: weight);

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
                  GestureDetector(
                    onTap: () {
                      print("Male");
                      setState(() {
                        gender = 'M'; // should be define by an enum
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: gender == 'M'
                            ? Color.fromARGB(255, 79, 73, 190).withAlpha(150)
                            : Color.fromARGB(255, 24, 41, 150).withAlpha(75),
                        borderRadius: BorderRadius.circular(15),
                      ),

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
                  ),
                  const Spacer(), // separated the two columns
                  GestureDetector(
                    onTap: () {
                      print("Female");
                      setState(() {
                        gender = 'F'; // should be define by an enum
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: gender == 'F'
                            ? Color(0xFFF48FB1).withAlpha(150)
                            : Color(0xFFF48FB1).withAlpha(75),
                        borderRadius: BorderRadius.circular(15),
                      ),

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
                                        bmi = calculateBMI(
                                          height: height,
                                          weight: weight,
                                        );
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
                                        bmi = calculateBMI(
                                          height: height,
                                          weight: weight,
                                        );
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
                                        bmi = calculateBMI(
                                          height: height,
                                          weight: weight,
                                        );
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
                                        bmi = calculateBMI(
                                          height: height,
                                          weight: weight,
                                        );
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
                    bmi.toStringAsFixed(2), // showing only 2 decimal places
                    style: kInputLabelColor.copyWith(
                      color: kOutputTextColor, // add style from constants.dart
                      fontSize: 60,
                    ),
                  ),
                  SizedBox(height: 100),
                  Text(
                    getResult(bmi),
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
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
  double calculateBMI({required int height, required int weight}) {
    return (weight / (height * height)) * 10000; // formula
  }

  // function for inform the level and status of the bmi
  String getResult(double bmi) {
    String level = '';
    if (bmi < 18.5) {
      level = 'Underweight';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      level = 'Normal weight';
    } else if (bmi >= 25 && bmi < 29.9) {
      level = 'Overweight';
    } else {
      level = 'Obesity';
    }
    return level;
  }
}
