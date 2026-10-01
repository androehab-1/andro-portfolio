import 'package:flutter/material.dart';
import '../utils/constants.dart';
import 'dart:html' as html;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  Future<void> downloadCVDirectly() async {
  try {
    final ByteData data = await rootBundle.load('assets/cv.pdf');
    final Uint8List bytes = data.buffer.asUint8List();
    
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'Andro_CV.pdf') 
      ..style.display = 'none';

    html.document.body?.children.add(anchor);
    anchor.click();

    html.document.body?.children.remove(anchor);
    html.Url.revokeObjectUrl(url);
  } catch (e) {
    print("Error downloading file: $e");
  }
}

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 1. اللوجو والاسم
          Row(
            children: [
              Text("AE", style: TextStyle(color: primaryColor, fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              const Text("Andro Ehab", style: TextStyle(color: textWhite, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          
          // 2. اللينكات (تظهر في اللاب توب فقط مؤقتاً)
          if (isDesktop)
            Row(
              children: [
                _navItem("Home"),
                _navItem("About"),
                _navItem("Skills"),
                _navItem("Projects"),
                _navItem("Services"),
                _navItem("Contact"),
              ],
            ),


            

          ElevatedButton(
  onPressed: () async {
    await downloadCVDirectly();
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: primaryColor, // تأكد إن primaryColor متعرف عندك
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
  ),
  child: const Text("Download My CV", style: TextStyle(color: Colors.white)),
)
        ],
      ),
    );
  }

  Widget _navItem(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        title,
        style: const TextStyle(color: textWhite, fontSize: 14),
      ),
    );
  }
}