import 'package:flutter/material.dart';
import '../utils/constants.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return Padding(
      // مسافات من الجوانب ومن فوق وتحت
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 30, vertical: 80),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. الصورة الشخصية
                _buildProfileImage(),
                const SizedBox(width: 50),
                
                // 2. الكلام والمعلومات (بتاخد باقي المساحة المتاحة)
                Expanded(child: _buildAboutText(isDesktop)),
                const SizedBox(width: 50),
                
                // 3. كروت الإحصائيات
                _buildStats(isDesktop: true),
              ],
            )
          : Column(
              children: [
                _buildProfileImage(),
                const SizedBox(height: 40),
                _buildAboutText(isDesktop),
                const SizedBox(height: 40),
                _buildStats(isDesktop: false),
              ],
            ),
    );
  }

  // ---------------------------------------------------------
  // 1. الجزء الخاص بالصورة الشخصية
  // ---------------------------------------------------------
  Widget _buildProfileImage() {
    return Container(
      width: 300,
      height: 300,
      decoration: BoxDecoration(
        color: cardColor, // لون خلفية الكارت من ملف الألوان
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        // ⚠️ تأكد إنك تحط صورتك الشخصية في مجلد الصور وتسميها profile.png مثلاً
        child: Image.asset(
          'assets/images/profile (2).jpg', // مسار صورتك الشخصية
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => const Center(
            child: Icon(Icons.person, size: 100, color: textGrey), // أيكون مؤقت لو الصورة مش موجودة
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------
  // 2. الجزء الخاص بالنصوص (About Me والمعلومات)
  // ---------------------------------------------------------
  Widget _buildAboutText(bool isDesktop) {
    return Column(
      crossAxisAlignment: isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: "About ", style: TextStyle(color: textWhite)),
              TextSpan(text: "Me", style: TextStyle(color: primaryColor)),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Text(
          "I'm a passionate mobile app developer, currently studying Computer Science at the Arab Open University. I love turning ideas into real apps and I'm always eager to learn new technologies and improve my skills.",
          style: const TextStyle(color: textGrey, fontSize: 16, height: 1.6),
          textAlign: isDesktop ? TextAlign.left : TextAlign.center,
        ),
        const SizedBox(height: 30),
        
        // تفاصيل الجامعة والتخرج
        Wrap(
          spacing: 30, // مسافة أفقية
          runSpacing: 20, // مسافة عمودية في الموبايل
          alignment: isDesktop ? WrapAlignment.start : WrapAlignment.center,
          children: [
            _infoItem(Icons.school, "University", "Arab Open University"),
            _infoItem(Icons.calendar_month, "Expected Graduation", "2027"),
          ],
        ),
      ],
    );
  }

  // تصميم أيقونة ومعلومة (زي الجامعة)
  Widget _infoItem(IconData icon, String title, String subtitle) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: primaryColor, size: 30),
        const SizedBox(width: 15),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(color: textGrey, fontSize: 12)),
            const SizedBox(height: 5),
            Text(subtitle, style: const TextStyle(color: textWhite, fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ],
    );
  }

  // ---------------------------------------------------------
  // 3. الجزء الخاص بكروت الإحصائيات (مشاريع، خبرة، تقنيات)
  // ---------------------------------------------------------
  Widget _buildStats({required bool isDesktop}) {
    // في اللاب توب هيبقوا تحت بعض، في الموبايل هيبقوا جنب بعض أو تحت بعض حسب الشاشة
    return isDesktop
        ? Column(
            children: [
              _statCard(Icons.work, "4+", "Projects Completed"),
              const SizedBox(height: 20),
              _statCard(Icons.timer, "2+", "Years Learning"),
              const SizedBox(height: 20),
              _statCard(Icons.code, "5+", "Technologies"),
            ],
          )
        : Wrap(
            spacing: 15,
            runSpacing: 15,
            alignment: WrapAlignment.center,
            children: [
              _statCard(Icons.work, "4+", "Projects Completed"),
              _statCard(Icons.timer, "2+", "Years Learning"),
              _statCard(Icons.code, "5+", "Technologies"),
            ],
          );
  }

  // تصميم الكارت الواحد
  Widget _statCard(IconData icon, String title, String subtitle) {
    return Container(
      width: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryColor, size: 24),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: textWhite, fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 5),
                Text(subtitle, style: const TextStyle(color: textGrey, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}