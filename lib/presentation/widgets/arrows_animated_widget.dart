import 'package:flutter/material.dart';

class ArrowsAnimatedWidget extends StatefulWidget {
  const ArrowsAnimatedWidget({super.key, this.isDown = false, this.size = 40});
  final bool isDown;
  final double size;

  @override
  State<ArrowsAnimatedWidget> createState() => _ArrowsAnimatedWidgetState();
}

class _ArrowsAnimatedWidgetState extends State<ArrowsAnimatedWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeTop;
  late Animation<double> _fadeBottom;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat();

    _fadeTop = Tween<double>(
      begin: 1.0,
      end: 0.3,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);

    _fadeBottom = Tween<double>(
      begin: 0.3,
      end: 1.0,
    ).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            FadeTransition(
              opacity: _fadeTop,
              child: Icon(
                widget.isDown
                    ? Icons.keyboard_arrow_down
                    : Icons.keyboard_arrow_up,
                size: widget.size,
                color: Colors.white,
              ),
            ),
            Positioned(
              bottom: 10,
              child: FadeTransition(
                opacity: _fadeBottom,
                child: Icon(
                  widget.isDown
                      ? Icons.keyboard_arrow_down
                      : Icons.keyboard_arrow_up,
                  size: widget.size,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
