import 'dart:async';
import 'package:flutter/material.dart';

class AnimatedImageCarousel extends StatefulWidget {
  const AnimatedImageCarousel({super.key});

  @override
  State<AnimatedImageCarousel> createState() => _AnimatedImageCarouselState();
}

class _AnimatedImageCarouselState extends State<AnimatedImageCarousel> {
  final List<String> images = [
    'assets/images/image1.png',
    'assets/images/image2(1).png',
    'assets/images/image3.png',
  ];

  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // 1. تقليل وقت التقليب: هنا الصورة هتتغير كل ثانيتين بدل 3 ثواني
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % images.length;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 550,
      width: double.infinity,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.center,
        children: [
          _buildAnimatedImage(index: (currentIndex + 1) % images.length, position: 'left'),
          _buildAnimatedImage(index: (currentIndex + 2) % images.length, position: 'right'),
          _buildAnimatedImage(index: currentIndex, position: 'center'),
        ],
      ),
    );
  }

  Widget _buildAnimatedImage({required int index, required String position}) {
    final isCenter = position == 'center';
    final isLeft = position == 'left';

    final Alignment alignment = isCenter 
        ? const Alignment(0.0, 0.0) 
        : (isLeft ? const Alignment(-0.6, 0.0) : const Alignment(0.6, 0.0));

    final double angle = isCenter ? 0 : (isLeft ? -0.15 : 0.15);
    final double opacity = isCenter ? 1.0 : 0.5;
    final double scale = isCenter ? 0.8 : 0.55;

    // حددنا وقت الأنيميشن في متغير عشان نغيره بسهولة في كل الأماكن مرة واحدة
    // 2. إبطاء الحركة: خلينا وقت الأنيميشن 1500 مللي ثانية (ثانية ونص) بدل 800 مللي ثانية
    const animationDuration = Duration(milliseconds: 1700);

    return AnimatedAlign(
      duration: animationDuration, // استخدام مدة الحركة الجديدة هنا
      curve: Curves.easeInOutCubic,
      alignment: alignment,
      key: ValueKey(images[index]),
      child: AnimatedOpacity(
        duration: animationDuration, // وهنا
        opacity: opacity,
        child: AnimatedContainer(
          duration: animationDuration, // وهنا
          curve: Curves.easeInOutCubic,
          height: 550,
          transform: Matrix4.identity()
            ..rotateZ(angle)
            ..scale(scale),
          transformAlignment: Alignment.center,
          decoration: BoxDecoration(
            boxShadow: isCenter
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 40,
                      spreadRadius: 10,
                    ),
                  ]
                : [],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Image.asset(
            images[index],
            fit: BoxFit.contain,
            filterQuality: FilterQuality.high,
          ),
        ),
      ),
    );
  }
}