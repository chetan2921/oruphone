import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FaqWidget extends StatelessWidget {
  const FaqWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            // Fetch FAQs when the button is pressed
            final List<FAQ> faqs = await fetchFAQs();
            // Show FAQs in a dialog
            showFAQsDialog(context, faqs);
          },
          child: Text('Show FAQs'),
        ),
      ),
    );
  }
}

class FAQ {
  final String id;
  final String question;
  final String answer;

  FAQ({
    required this.id,
    required this.question,
    required this.answer,
  });

  factory FAQ.fromJson(Map<String, dynamic> json) {
    return FAQ(
      id: json['_id'],
      question: json['question'],
      answer: json['answer'],
    );
  }
}

Future<List<FAQ>> fetchFAQs() async {
  try {
    final response = await http.get(Uri.parse('http://40.90.224.241:5000/faq'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> faqsJson = data['FAQs'];
      return faqsJson.map((json) => FAQ.fromJson(json)).toList();
    } else {
      throw Exception(
          'Failed to load FAQs: Status Code ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to load FAQs: $e');
  }
}

void showFAQsDialog(BuildContext context, List<FAQ> faqs) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('FAQs'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: faqs.length,
            itemBuilder: (context, index) {
              final faq = faqs[index];
              return ExpansionTile(
                title: Text(faq.question),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(faq.answer),
                  ),
                ],
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}
