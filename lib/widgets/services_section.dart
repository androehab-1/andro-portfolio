import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 30, vertical: 80),
      child: Column(
        crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            text: const TextSpan(
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: "My ", style: TextStyle(color: textWhite)),
                TextSpan(text: "Services", style: TextStyle(color: primaryColor)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "What I can do for you",
            style: const TextStyle(color: textGrey, fontSize: 16),
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          ),
          const SizedBox(height: 50),

          // 🔥 التعديل هنا: استخدام IntrinsicHeight لمنع الكراش
          isDesktop
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _buildServiceCard(
                          icon: Icons.phone_iphone,
                          title: 'Mobile App Development',
                          description: 'Build high-quality mobile apps for Android and iOS using Flutter and native technologies.',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildServiceCard(
                          icon: Icons.android,
                          title: 'Android Development',
                          description: 'Create modern Android apps using Kotlin and Jetpack Compose with clean architecture.',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildServiceCard(
                          icon: Icons.flutter_dash,
                          title: 'Flutter Development',
                          description: 'Develop fast, beautiful and responsive apps with Flutter and Dart.',
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildServiceCard(
                          icon: Icons.design_services,
                          title: 'UI Implementation',
                          description: 'Turn your designs into pixel-perfect and responsive mobile app interfaces.',
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _buildServiceCard(
                      icon: Icons.phone_iphone,
                      title: 'Mobile App Development',
                      description: 'Build high-quality mobile apps for Android and iOS using Flutter and native technologies.',
                    ),
                    const SizedBox(height: 20),
                    _buildServiceCard(
                      icon: Icons.android,
                      title: 'Android Development',
                      description: 'Create modern Android apps using Kotlin and Jetpack Compose with clean architecture.',
                    ),
                    const SizedBox(height: 20),
                    _buildServiceCard(
                      icon: Icons.flutter_dash,
                      title: 'Flutter Development',
                      description: 'Develop fast, beautiful and responsive apps with Flutter and Dart.',
                    ),
                    const SizedBox(height: 20),
                    _buildServiceCard(
                      icon: Icons.design_services,
                      title: 'UI Implementation',
                      description: 'Turn your designs into pixel-perfect and responsive mobile app interfaces.',
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({required IconData icon, required String title, required String description}) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryColor.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: primaryColor, size: 30),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(color: textWhite, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(color: textGrey, fontSize: 14, height: 1.5),
          ),
        ],
      ),
    );
  }
}