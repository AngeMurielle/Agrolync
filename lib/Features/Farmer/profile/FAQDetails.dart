import 'package:flutter/material.dart';

class FAQDetailPage extends StatelessWidget {
  final String title;
  final String content;

  const FAQDetailPage({super.key, required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Color(0xFF026139)),
        title: Text(title, style: const TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            Text(
              content,
              style: const TextStyle(fontSize: 16, height: 1.6, color: Colors.black87),
            ),
            const SizedBox(height: 40),
            const Divider(),
            const Text("Was this helpful?", style: TextStyle(fontWeight: FontWeight.bold)),
            Row(
              children: [
                TextButton(onPressed: () {}, child: const Text("Yes")),
                TextButton(onPressed: () {}, child: const Text("No")),
              ],
            )
          ],
        ),
      ),
    );
  }
}