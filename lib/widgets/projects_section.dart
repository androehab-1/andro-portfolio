import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

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
          // 1. الجزء العلوي (العنوان + زرار View All)
          if (isDesktop)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _buildHeader(),
              ],
            )
          else
            Column(
              children: [
                _buildHeader(isCenter: true),
                const SizedBox(height: 20),
              ],
            ),
          
          const SizedBox(height: 50),

          // 2. كروت المشاريع
          isDesktop
              ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: _buildProjectCard(
                          title: "Calculator App",
                          tech1: "Flutter • Dart",
                          tech2: "StatefulWidget, custom functions",
                          imagePath: "assets/images/calc.jpg",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildProjectCard(
                          title: "XO Game",
                          tech1: "Flutter • Dart",
                          tech2: "Simple & clean UI, Animations",
                          imagePath: "assets/images/xo.jpg",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildProjectCard(
                          title: "Movie Discovery App",
                          tech1: "Kotlin • Jetpack Compose",
                          tech2: "TMDB API Integration, Retrofit",
                          imagePath: "assets/images/movie.jpg",
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: _buildProjectCard(
                          title: "E-Commerce App",
                          tech1: "Flutter • Dart",
                          tech2: "Firebase, State Management",
                          imagePath: "assets/images/commerce.jpg",
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    _buildProjectCard(
                      title: "Calculator App",
                      tech1: "Flutter • Dart",
                      tech2: "StatefulWidget, custom functions",
                      imagePath: "assets/images/calc.jpg",
                    ),
                    const SizedBox(height: 20),
                    _buildProjectCard(
                      title: "XO Game",
                      tech1: "Flutter • Dart",
                      tech2: "Simple & clean UI, Animations",
                      imagePath: "assets/images/xo.jpg",
                    ),
                    const SizedBox(height: 20),
                    _buildProjectCard(
                      title: "Movie Discovery App",
                      tech1: "Kotlin • Jetpack Compose",
                      tech2: "TMDB API Integration, Retrofit",
                      imagePath: "assets/images/movie.jpg",
                    ),
                    const SizedBox(height: 20),
                    _buildProjectCard(
                      title: "E-Commerce App",
                      tech1: "Flutter • Dart",
                      tech2: "Firebase, State Management",
                      imagePath: "assets/images/commerce.jpg",
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildHeader({bool isCenter = false}) {
    return Column(
      crossAxisAlignment: isCenter ? CrossAxisAlignment.center : CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: isCenter ? TextAlign.center : TextAlign.left,
          text: const TextSpan(
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: "My ", style: TextStyle(color: textWhite)),
              TextSpan(text: "Projects", style: TextStyle(color: primaryColor)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Text(
          "Some of the apps I've built",
          style: const TextStyle(color: textGrey, fontSize: 16),
          textAlign: isCenter ? TextAlign.center : TextAlign.left,
        ),
      ],
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String tech1,
    required String tech2,
    required String imagePath,
  }) {
    return Container(
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
        mainAxisSize: MainAxisSize.min, // 🔥 التعديل هنا: يخلي الكارت ياخد مساحة محتواه بس
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Container(
              height: 160,
              width: double.infinity,
              color: bgColor,
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Icon(Icons.image_not_supported, size: 50, color: textGrey),
                ),
              ),
            ),
          ),
          
          // 🔥 التعديل هنا: إزالة الـ Expanded تماماً
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: textWhite, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 15),
                _buildBulletPoint(tech1),
                const SizedBox(height: 8),
                _buildBulletPoint(tech2),
                
                // 🔥 التعديل هنا: استبدال Spacer بمسافة ثابتة
                const SizedBox(height: 20),
                
                Divider(
                  color: textGrey.withOpacity(0.2), 
                  thickness: 1,
                  height: 30, 
                ),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Text("View Project", style: TextStyle(color: textWhite, fontSize: 13)),
                          SizedBox(width: 5),
                          Icon(Icons.arrow_outward, color: textWhite, size: 14),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: const [
                          Icon(Icons.code, color: textGrey, size: 16),
                          SizedBox(width: 5),
                          Text("GitHub", style: TextStyle(color: textGrey, fontSize: 13)),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: primaryColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(text, style: const TextStyle(color: textGrey, fontSize: 13)),
        ),
      ],
    );
  }
}