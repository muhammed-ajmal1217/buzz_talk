import 'package:buzztalk/views/add_story_screen/widgets/gradient_border_painer.dart';
import 'package:flutter/material.dart';

class GradientBorderPaint extends StatefulWidget {
  final bool animate;

  const GradientBorderPaint({Key? key, required this.animate}) : super(key: key);

  @override
  _GradientBorderPaintState createState() => _GradientBorderPaintState();
}

class _GradientBorderPaintState extends State<GradientBorderPaint>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    if (widget.animate) {
      _animationController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant GradientBorderPaint oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate) {
      _animationController.repeat();
    } else {
      _animationController.stop();
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Gradient get _gradient => const LinearGradient(
    colors: [
      Color.fromARGB(255, 170, 0, 255),
      Color.fromARGB(255, 82, 255, 255),
      Color.fromARGB(255, 105, 163, 240),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: CustomPaint(
        size: const Size(double.infinity, double.infinity),
        painter: GradientBorderPainter(
          radius: 40,
          strokeWidth: 2,
          gradient: _gradient,
        ),
      ),
    );
  }
}
