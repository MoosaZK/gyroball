import 'package:flutter/material.dart';
import 'package:sensors_plus/sensors_plus.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double x = 0.0;
  double y = 0.0;

  @override
  void initState() {
    super.initState();
    gyroscopeEvents.listen((GyroscopeEvent event) {
      setState(() {
        // Apply low-pass filter
        x = lowPassFilter(event.x, x);
        y = lowPassFilter(event.y, y);
        print(x + y);
      });
    });
  }

  // Simple low-pass filter function
  double lowPassFilter(double newValue, double oldValue) {
    const alpha = 0.9; // Adjust this value for more or less smoothing

    return alpha * newValue + (1 - alpha) * oldValue;
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;

    // Calculate the new position of the ball based on gyroscope data
    double newPositionX = x * 50; // Adjust the multiplier for sensitivity
    double newPositionY = y * 50;

    return Scaffold(
      body: Center(
        child: Transform.translate(
          offset: Offset(newPositionY, newPositionX),
          child: Hero(
            tag: 1,
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
