import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_circle_color_picker/flutter_circle_color_picker.dart';
import 'dart:math' as math;

import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class ColorPickerScreen extends StatefulWidget {
  const ColorPickerScreen({super.key});

  @override
  _ColorPickerScreenState createState() => _ColorPickerScreenState();
}

class _ColorPickerScreenState extends State<ColorPickerScreen> {
  Color currentColor = Colors.red;
  double brightness = 1.0;
  double saturation = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Color Picker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircleColorPicker(
            onChanged: (color) {
              setState(() => currentColor = color);
            },
            size: const Size(300, 300),
            strokeWidth: 12,
            thumbSize: 36,
          ),
          CustomArcSliderScreen(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularSlider(
                label: 'Brightness',
                value: brightness,
                onChanged: (value) {
                  setState(() => brightness = value);
                },
              ),
              CircularSlider(
                label: 'Saturation',
                value: saturation,
                onChanged: (value) {
                  setState(() => saturation = value);
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Implement white light functionality
                },
                style:
                    ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
                child: const Text('White Light'),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
                child: const Text('Effects'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class CircularSlider extends StatelessWidget {
  final String label;
  final double value;
  final ValueChanged<double> onChanged;

  const CircularSlider({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white)),
        const SizedBox(height: 10),
        Container(
          width: 150,
          height: 150,
          child: CustomPaint(
            painter: CircularSliderPainter(value),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onPanUpdate: (details) {
                final RenderBox box = context.findRenderObject() as RenderBox;
                final center = box.size.center(Offset.zero);
                final position = details.localPosition - center;
                final double angle =
                    (position.direction + math.pi) % (2 * math.pi);
                onChanged(angle / (2 * math.pi));
              },
            ),
          ),
        ),
      ],
    );
  }
}

class CircularSliderPainter extends CustomPainter {
  final double value;

  CircularSliderPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    // Draw background circle
    final backgroundPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;
    canvas.drawCircle(center, radius, backgroundPaint);

    // Draw active arc
    final activePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * value,
      false,
      activePaint,
    );

    // Draw thumb
    final thumbPaint = Paint()..color = Colors.white;
    final thumbAngle = 2 * math.pi * value - math.pi / 2;
    final thumbX = center.dx + radius * math.cos(thumbAngle);
    final thumbY = center.dy + radius * math.sin(thumbAngle);
    canvas.drawCircle(Offset(thumbX, thumbY), 15, thumbPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class CustomArcSliderScreen extends StatefulWidget {
  const CustomArcSliderScreen({super.key});

  @override
  _CustomArcSliderScreenState createState() => _CustomArcSliderScreenState();
}

class _CustomArcSliderScreenState extends State<CustomArcSliderScreen> {
  double _sliderValue = 50;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(150, 150), // Smaller size
            painter: ArcSliderPainter(_sliderValue),
          ),
          Positioned(
            top: 75 - 10, // Adjust thumb position
            left: 75 - 10 + 75 * cos((_sliderValue / 100) * pi),
            child: GestureDetector(
              onPanUpdate: (details) {
                setState(() {
                  _sliderValue =
                      _calculateSliderValue(details.localPosition, 150);
                });
              },
              child: Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculateSliderValue(Offset position, double size) {
    final double radius = size / 2;
    final double dx = position.dx - radius;
    final double dy = position.dy - radius;
    final double angle = atan2(dy, dx) * 180 / pi + 180;
    return angle / 360 * 100;
  }
}

class ArcSliderPainter extends CustomPainter {
  final double value;

  ArcSliderPainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    const double startAngle = pi;
    const double sweepAngle = pi;

    for (double i = 0; i < sweepAngle; i += 0.01) {
      final double currentAngle = startAngle + i;
      final double thickness =
          lerpDouble(1, 10, i / sweepAngle)!; // Varying thickness from 2 to 12
      paint.strokeWidth = thickness;
      paint.color =
          i <= (value / 100) * sweepAngle ? Colors.green : Colors.grey;

      final Offset startPoint = Offset(
        radius + radius * cos(currentAngle),
        radius + radius * sin(currentAngle),
      );

      final Offset endPoint = Offset(
        radius + radius * cos(currentAngle + 0.01),
        radius + radius * sin(currentAngle + 0.01),
      );

      canvas.drawLine(startPoint, endPoint, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
