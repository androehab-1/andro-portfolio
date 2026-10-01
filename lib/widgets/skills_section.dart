import 'package:flutter/material.dart';
import '../utils/constants.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 800;

    // 🔥 التعديل الأول: استخدام Container وإعطاؤه عرض الشاشة بالكامل
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 30, vertical: 80),
      child: Column(
        crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          // 1. عنوان القسم
          RichText(
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
            text: const TextSpan(
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
              children: [
                TextSpan(text: "Skills & ", style: TextStyle(color: textWhite)),
                TextSpan(text: "Technologies", style: TextStyle(color: primaryColor)),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Tools and technologies I work with",
            style: const TextStyle(color: textGrey, fontSize: 16),
            textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          ),
          const SizedBox(height: 50),

          // 2. شبكة الكروت
          // 🔥 التعديل التاني: تغليف الـ Wrap بـ Center عشان الكروت تفضل في النص
          Center(
            child: Wrap(
              spacing: 20, // المسافة الأفقية بين الكروت
              runSpacing: 20, // المسافة العمودية
              alignment: WrapAlignment.center,
              children: [
                _buildSkillCard(iconPath: 'assets/images/Flutter Logo.png', title: 'Flutter', subtitle: 'Dart'),
                _buildSkillCard(iconPath: 'assets/images/kotlin logo.png', title: 'Kotlin', subtitle: 'Android'),
                _buildSkillCard(iconPath: 'assets/images/Java Logo.png', title: 'Java', subtitle: 'Android'),
                _buildSkillCard(iconPath: 'assets/images/compose.png', title: 'Jetpack Compose', subtitle: 'Android UI'),
                _buildSkillCard(iconPath: 'assets/images/studio.png', title: 'Android Studio', subtitle: 'IDE'),
                _buildSkillCard(iconPath: 'assets/images/Git vs_ GitHub vs.png', title: 'Git & GitHub', subtitle: 'Version Control'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // تصميم كارت المهارة الواحد
  Widget _buildSkillCard({required String iconPath, required String title, required String subtitle}) {
    return Container(
      width: 160,
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: primaryColor.withOpacity(0.1)), // حد خفيف للكارت
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // لوجو التقنية
          SizedBox(
            height: 50,
            width: 50,
            child: Image.asset(
              iconPath,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.code, color: primaryColor, size: 40),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            style: const TextStyle(color: textWhite, fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(color: textGrey, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}