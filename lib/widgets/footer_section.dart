import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({super.key});

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        debugPrint('Could not launch $urlString');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return Container(
      width: double.infinity,
      // تظهير مسافات جانبية زي باقي السكاشن
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: isDesktop ? 100 : 30),
      decoration: BoxDecoration(
        color: bgColor,
        // خط علوي خفيف جداً لفصل الفوتر
        border: Border(
          top: BorderSide(color: textGrey.withOpacity(0.1), width: 1),
        ),
      ),
      // لو شاشة كبيرة نعرضهم جنب بعض، لو موبايل نعرضهم تحت بعض
      child: isDesktop
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLogoAndName(),
                _buildSocialIcons(),
                _buildCopyright(),
              ],
            )
          : Column(
              children: [
                _buildLogoAndName(),
                const SizedBox(height: 25),
                _buildSocialIcons(),
                const SizedBox(height: 25),
                _buildCopyright(),
              ],
            ),
    );
  }

  // 1. الجزء اللي على الشمال (اللوجو والاسم)
  Widget _buildLogoAndName() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // اللوجو (AE)
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primaryColor.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: const Text(
            "AE",
            style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
        const SizedBox(width: 15),
        // الاسم والمسمى الوظيفي
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("Andro Ehab", style: TextStyle(color: textWhite, fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(height: 3),
            Text("Mobile App Developer", style: TextStyle(color: textGrey, fontSize: 12)),
          ],
        ),
      ],
    );
  }
Widget _buildSocialIcons() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 1. GitHub Logo
        IconButton(
          onPressed: () => _launchURL('https://github.com/androehab-1'), // 👈 حط لينك جيت هاب بتاعك هنا
          icon: Image.asset(
            'assets/images/github_logo.png',
            width: 22,
            height: 22,
            color: Colors.white,
          ),
          hoverColor: primaryColor.withOpacity(0.1),
          tooltip: 'GitHub',
        ),
        const SizedBox(width: 10),
        
        // 2. LinkedIn Logo
        IconButton(
          onPressed: () => _launchURL('https://www.linkedin.com/in/andro-ehab'), // 👈 حط لينك لينكد إن بتاعك هنا
          icon: Image.asset(
            'assets/images/linkedin_logo.png', 
            width: 22,
            height: 22,
            color: Colors.white,
          ),
          hoverColor: primaryColor.withOpacity(0.1),
          tooltip: 'LinkedIn',
        ),
        const SizedBox(width: 10),
        
        // 3. Email 
        IconButton(
          // 👈 حط إيميلك هنا (mailto: بتجبر المتصفح يفتح تطبيق الإيميل)
          onPressed: () => _launchURL('mailto:androhabib47@gmail.com?subject=Portfolio%20Contact'), 
          icon: const Icon(Icons.email_outlined, color: Colors.white, size: 24),
          hoverColor: primaryColor.withOpacity(0.1),
          tooltip: 'Email Me',
        ),
      ],
    );
  }

  // 3. الجزء اللي على اليمين (حقوق الملكية)
  Widget _buildCopyright() {
    return const Text(
      "© 2026 Andro Ehab. All rights reserved.",
      style: TextStyle(color: textGrey, fontSize: 12),
      textAlign: TextAlign.center,
    );
  }
}