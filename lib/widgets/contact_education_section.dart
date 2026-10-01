import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../utils/constants.dart';

class ContactEducationSection extends StatelessWidget {
  const ContactEducationSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isDesktop = width > 900;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: isDesktop ? 100 : 30, vertical: 80),
      child: isDesktop
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // النصف الأيسر: التعليم والخبرة (زي ما هو بدون تعديل)
                Expanded(child: _buildEducationExperience()),
                const SizedBox(width: 80),
                // النصف الأيمن: فورم التواصل (استدعينا الكلاس الجديد هنا)
                const Expanded(child: ContactFormWidget()), 
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEducationExperience(),
                const SizedBox(height: 60),
                const ContactFormWidget(), // استدعينا الكلاس الجديد هنا
              ],
            ),
    );
  }

  // ==========================================
  // 1. قسم التعليم والخبرات (Timeline)
  // ==========================================
  Widget _buildEducationExperience() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
            children: [
              TextSpan(text: "Education & ", style: TextStyle(color: textWhite)),
              TextSpan(text: "Experience", style: TextStyle(color: primaryColor)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          "My journey so far",
          style: TextStyle(color: textGrey, fontSize: 16),
        ),
        const SizedBox(height: 40),

        // التايم لاين (الخط الزمني)
        _buildTimelineItem(
          date: "Expected 2027",
          title: "Computer Science Degree",
          subtitle: "Arab Open University",
        ),
        _buildTimelineItem(
          date: "Jun 2025 - Dec 2025",
          title: "Mobile App Development Track",
          subtitle: "Digital Egypt Pioneers Initiative (DEPI)",
        ),
        _buildTimelineItem(
          date: "Summer Internship",
          title: "Summer Internship Program",
          subtitle: "Mobile App Devolper (Aou)",
        ),
        _buildTimelineItem(
          date: "Certificate",
          title: "Python Programming language",
          subtitle: "Arab Open University (Aou)",
          isLast: true, // إخفاء الخط بعد آخر عنصر
        ),
      ],
    );
  }

  // تصميم عنصر التايم لاين (نقطة وخط)
  Widget _buildTimelineItem({
    required String date,
    required String title,
    required String subtitle,
    bool isLast = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // النقطة والخط العمودي
        Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 5),
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: bgColor,
                shape: BoxShape.circle,
                border: Border.all(color: primaryColor, width: 3),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 90, // طول الخط الفاصل بين الخبرات
                color: primaryColor.withOpacity(0.3),
              ),
          ],
        ),
        const SizedBox(width: 20),
        // المحتوى (التاريخ، العنوان، المكان)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(date, style: const TextStyle(color: primaryColor, fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(title, style: const TextStyle(color: textWhite, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 5),
              Text(subtitle, style: const TextStyle(color: textGrey, fontSize: 14)),
              const SizedBox(height: 20), // مسافة سفلية
            ],
          ),
        ),
      ],
    );
  }
}

// ==========================================
// 2. قسم فورم التواصل (تم تحويله لـ StatefulWidget للتحكم في الداتا)
// ==========================================
class ContactFormWidget extends StatefulWidget {
  const ContactFormWidget({super.key});

  @override
  State<ContactFormWidget> createState() => _ContactFormWidgetState();
}

class _ContactFormWidgetState extends State<ContactFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  
  bool _isLoading = false;

  Future<void> _sendMessage() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      // ⚠️ حط الرابط اللي أخدته من Formspree هنا بدل YOUR_FORM_ID_HERE
      final response = await http.post(
        Uri.parse('https://formspree.io/f/xbglwygz'), 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': _nameController.text,
          'email': _emailController.text,
          'message': _messageController.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _nameController.clear();
        _emailController.clear();
        _messageController.clear();
        
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Message sent successfully! I will reply soon.'),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } else {
        throw Exception('Failed to send message');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Oops! Something went wrong. Please try again.'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: "Contact ", style: TextStyle(color: textWhite)),
                  TextSpan(text: "Me", style: TextStyle(color: primaryColor)),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Let's work together!",
              style: TextStyle(color: textGrey, fontSize: 16),
            ),
            const SizedBox(height: 30),

            _buildTextField(
              controller: _nameController,
              label: "Full Name",
              hint: "Your name",
              validator: (value) => value!.isEmpty ? "Please enter your name" : null,
            ),
            const SizedBox(height: 20),
            
            _buildTextField(
              controller: _emailController,
              label: "Email Address",
              hint: "your@email.com",
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) return "Please enter your email";
                final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                if (!emailRegex.hasMatch(value)) return "Please enter a valid email address";
                return null;
              },
            ),
            const SizedBox(height: 20),
            
            _buildTextField(
              controller: _messageController,
              label: "Message",
              hint: "Your message...",
              maxLines: 4,
              validator: (value) => value!.isEmpty ? "Please enter a message" : null,
            ),
            const SizedBox(height: 30),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: _isLoading ? null : _sendMessage,
                icon: _isLoading 
                    ? const SizedBox.shrink() 
                    : const Icon(Icons.send, color: Colors.white, size: 18),
                label: _isLoading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                      )
                    : const Text("Send Message", style: TextStyle(color: Colors.white, fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int maxLines = 1,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: textWhite, fontSize: 14)),
        const SizedBox(height: 10),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: const TextStyle(color: textWhite),
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: textGrey.withOpacity(0.5)),
            filled: true,
            fillColor: bgColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: primaryColor, width: 1),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.redAccent, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}