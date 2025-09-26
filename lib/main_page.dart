import 'package:bmi_cal/constants.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  // define variables
  int height = 150;
  int weight = 50;
  String gender = '';
  late double bmi = calculateBMI(height: height, weight: weight);

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late AnimationController _bmiAnimationController;
  late Animation<double> _bmiAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _bmiAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _bmiAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _bmiAnimationController,
        curve: Curves.elasticOut,
      ),
    );

    _animationController.forward();
    _bmiAnimationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _bmiAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // App Title
                  Container(
                    margin: const EdgeInsets.only(bottom: 30),
                    child: const Text(
                      'BMI Calculator',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  // Gender Selection
                  Row(
                    children: [
                      Expanded(
                        child: _buildGenderCard(
                          gender: 'M',
                          icon: Icons.male,
                          label: 'Male',
                          color: const Color(0xFF4FC3F7),
                          isSelected: gender == 'M',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildGenderCard(
                          gender: 'F',
                          icon: Icons.female,
                          label: 'Female',
                          color: const Color(0xFFF48FB1),
                          isSelected: gender == 'F',
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Height and Weight Controls
                  Row(
                    children: [
                      Expanded(
                        child: _buildControlCard(
                          title: 'Height',
                          value: height,
                          unit: 'cm',
                          onDecrease: () => _updateHeight(-1),
                          onIncrease: () => _updateHeight(1),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildControlCard(
                          title: 'Weight',
                          value: weight,
                          unit: 'kg',
                          onDecrease: () => _updateWeight(-1),
                          onIncrease: () => _updateWeight(1),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 40),

                  // BMI Result
                  ScaleTransition(
                    scale: _bmiAnimation,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            _getBMIColor(bmi).withOpacity(0.8),
                            _getBMIColor(bmi).withOpacity(0.4),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: _getBMIColor(bmi).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          const Text(
                            'Your BMI',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            bmi.toStringAsFixed(1),
                            style: const TextStyle(
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              getResult(bmi),
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            _getBMIDescription(bmi),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // BMI Scale Indicator
                  _buildBMIScale(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGenderCard({
    required String gender,
    required IconData icon,
    required String label,
    required Color color,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          this.gender = gender;
        });
        _bmiAnimationController.reset();
        _bmiAnimationController.forward();
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? color.withOpacity(0.2)
              : const Color(0xFF16213E).withOpacity(0.8),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? color : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: Column(
          children: [
            Icon(icon, size: 80, color: isSelected ? color : Colors.white54),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildControlCard({
    required String title,
    required int value,
    required String unit,
    required VoidCallback onDecrease,
    required VoidCallback onIncrease,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E).withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white70,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                '$value',
                style: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                unit,
                style: const TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(icon: Icons.remove, onPressed: onDecrease),
              _buildControlButton(icon: Icons.add, onPressed: onIncrease),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF4FC3F7).withOpacity(0.2),
          shape: BoxShape.circle,
          border: Border.all(color: const Color(0xFF4FC3F7), width: 1),
        ),
        child: Icon(icon, color: const Color(0xFF4FC3F7), size: 24),
      ),
    );
  }

  Widget _buildBMIScale() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF16213E).withOpacity(0.8),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Text(
            'BMI Categories',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          _buildBMICategoryItem(
            'Underweight',
            '< 18.5',
            const Color(0xFF42A5F5),
          ),
          _buildBMICategoryItem(
            'Normal weight',
            '18.5 - 24.9',
            const Color(0xFF66BB6A),
          ),
          _buildBMICategoryItem(
            'Overweight',
            '25.0 - 29.9',
            const Color(0xFFFF7043),
          ),
          _buildBMICategoryItem('Obesity', '≥ 30.0', const Color(0xFFEF5350)),
        ],
      ),
    );
  }

  Widget _buildBMICategoryItem(String category, String range, Color color) {
    bool isCurrentCategory = getResult(bmi) == category;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isCurrentCategory ? color.withOpacity(0.2) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              category,
              style: TextStyle(
                fontSize: 14,
                color: isCurrentCategory ? Colors.white : Colors.white70,
                fontWeight: isCurrentCategory
                    ? FontWeight.w600
                    : FontWeight.normal,
              ),
            ),
          ),
          Text(
            range,
            style: TextStyle(
              fontSize: 12,
              color: isCurrentCategory ? Colors.white : Colors.white54,
            ),
          ),
        ],
      ),
    );
  }

  void _updateHeight(int change) {
    setState(() {
      int newHeight = height + change;
      if (newHeight >= 50 && newHeight <= 220) {
        height = newHeight;
        bmi = calculateBMI(height: height, weight: weight);
        _bmiAnimationController.reset();
        _bmiAnimationController.forward();
      }
    });
  }

  void _updateWeight(int change) {
    setState(() {
      int newWeight = weight + change;
      if (newWeight >= 30 && newWeight <= 200) {
        weight = newWeight;
        bmi = calculateBMI(height: height, weight: weight);
        _bmiAnimationController.reset();
        _bmiAnimationController.forward();
      }
    });
  }

  Color _getBMIColor(double bmi) {
    if (bmi < 18.5) {
      return const Color(0xFF42A5F5); // Blue for underweight
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return const Color(0xFF66BB6A); // Green for normal
    } else if (bmi >= 25 && bmi < 29.9) {
      return const Color(0xFFFF7043); // Orange for overweight
    } else {
      return const Color(0xFFEF5350); // Red for obesity
    }
  }

  String _getBMIDescription(double bmi) {
    if (bmi < 18.5) {
      return 'You may need to gain weight for optimal health.';
    } else if (bmi >= 18.5 && bmi < 24.9) {
      return 'Great! You have a healthy weight.';
    } else if (bmi >= 25 && bmi < 29.9) {
      return 'Consider a balanced diet and regular exercise.';
    } else {
      return 'Consult with a healthcare professional.';
    }
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
