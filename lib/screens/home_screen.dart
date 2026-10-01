import 'package:flutter/material.dart';
import 'package:protoflio/widgets/about_section.dart';
import 'package:protoflio/widgets/contact_education_section.dart';
import 'package:protoflio/widgets/footer_section.dart';
import 'package:protoflio/widgets/projects_section.dart';
import 'package:protoflio/widgets/services_section.dart';
import 'package:protoflio/widgets/skills_section.dart';
import '../utils/constants.dart';
import '../widgets/navbar.dart';
import '../widgets/hero_section.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final GlobalKey projectsKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor, // استخدام لون الخلفية من ملف الثوابت
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🔥 مسحنا كلمة const من هنا
            const NavBar(),
            HeroSection(
              projectsKey: projectsKey,
            ), // 🔥 بعتنا المفتاح هنا (الخط الأحمر هيختفي)
            const AboutSection(),
            const SkillsSection(),
            const ServicesSection(),
            ProjectsSection(
              key: projectsKey,
            ), // 🔥 ربطنا القسم بالمفتاح عشان السكرول يقف عنده
            const ContactEducationSection(),
            const FooterSection(),
          ],
        ),
      ),
    );
  }
}
