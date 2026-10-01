import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'animated_image_carousel.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeroSection extends StatelessWidget {
  final GlobalKey projectsKey;

  const HeroSection({super.key, required this.projectsKey});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? 100 : 30,
        vertical: 50,
      ),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: _buildTextContent(isDesktop: isDesktop)),
                const SizedBox(width: 40), // مسافة بين الكلام والصور
                const Expanded(
                  child: AnimatedImageCarousel(),
                ), // 🔥 استدعينا الأنيميشن هنا
              ],
            )
          : Column(
              children: [
                _buildTextContent(isDesktop: isDesktop),
                const SizedBox(height: 50),
                const AnimatedImageCarousel(), // 🔥 استدعينا الأنيميشن هنا للموبايل
              ],
            ),
    );
  }

  // الجزء الخاص بالكلام اللي على الشمال
  // ضفنا (isDesktop) عشان نخلي الكلام يتوسط في الموبايل ويبقى عالشمال في اللاب توب
  Widget _buildTextContent({required bool isDesktop}) {
    return Column(
      crossAxisAlignment: isDesktop
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        const Text("Hi, I'm", style: TextStyle(color: textWhite, fontSize: 24)),
        const SizedBox(height: 10),
        RichText(
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
          text: const TextSpan(
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: "Andro ",
                style: TextStyle(color: textWhite),
              ),
              TextSpan(
                text: "Ehab",
                style: TextStyle(color: primaryColor),
              ),
            ],
          ),
        ),
        const Text(
          "Mobile App Developer",
          style: TextStyle(
            color: textWhite,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Text(
          "I build modern, responsive and user-friendly mobile applications using Flutter, Android (Kotlin) and clean code practices.",
          style: const TextStyle(color: textGrey, fontSize: 16, height: 1.5),
          textAlign: isDesktop
              ? TextAlign.left
              : TextAlign.center, // توسيط في الموبايل
        ),
        const SizedBox(height: 30),

        // استخدمنا Wrap بدل Row عشان لو شاشة الموبايل صغيرة الزراير تنزل تحت بعض بدل ما تعمل إيرور
        Wrap(
          spacing: 20, // المسافة الأفقية بين الزراير
          runSpacing: 20, // المسافة العمودية لو نزلوا سطر جديد
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // التأكد إن القسم موجود في الشاشة
                if (projectsKey.currentContext != null) {
                  Scrollable.ensureVisible(
                    projectsKey.currentContext!,
                    duration: const Duration(milliseconds: 800), // سرعة السكرول
                    curve: Curves.easeInOutCubic, // شكل النعومة
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "View My Work",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            OutlinedButton(
              onPressed: () async {
                const String phoneNumber = '201289566080';
                const String message =
                    'Hello Andro, I would like to talk about a project!';
                final Uri whatsappUrl = Uri.parse(
                  'https://wa.me/$phoneNumber?text=${Uri.encodeComponent(message)}',
                );

                try {
                  if (await canLaunchUrl(whatsappUrl)) {
                    await launchUrl(
                      whatsappUrl,
                      mode: LaunchMode.externalApplication,
                    );
                  } else {
                    debugPrint('Could not launch WhatsApp');
                  }
                } catch (e) {
                  debugPrint('Error launching WhatsApp: $e');
                }
              },
              style: ButtonStyle(
                // 1. تغيير لون الخلفية لما الماوس يقف على الزرار
                backgroundColor: WidgetStateProperty.resolveWith<Color>((
                  states,
                ) {
                  if (states.contains(WidgetState.hovered)) {
                    return Colors.greenAccent.withOpacity(
                      0.15,
                    ); // لون أخضر شفاف خفيف
                  }
                  return Colors.transparent; // الخلفية الشفافة العادية
                }),

                // 2. تغيير لون وحجم الإطار (البوردر) عشان ينور
                side: WidgetStateProperty.resolveWith<BorderSide>((states) {
                  if (states.contains(WidgetState.hovered)) {
                    return const BorderSide(
                      color: Colors.greenAccent,
                      width: 2,
                    ); // بوردر أخضر واضح
                  }
                  return const BorderSide(
                    color: Colors.white54,
                    width: 1,
                  ); // البوردر العادي
                }),
                // 4. باقي إعدادات الزرار الثابتة
                padding: WidgetStateProperty.all(
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

                // 5. نعومة الأنيميشن أثناء التغيير
                animationDuration: const Duration(milliseconds: 300),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Let's Talk on WhatsApp",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  SizedBox(width: 12),
                  FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.greenAccent,
                    size: 22,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
