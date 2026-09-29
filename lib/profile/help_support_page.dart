import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  // ================= EMAIL =================

  Future<void> _sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@bjio.com',
      queryParameters: {
        'subject': 'BJIO Support',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  // ================= CALL =================

  Future<void> _callSupport() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+919999999999',
    );

    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Help & Support",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ================= SEARCH =================

            TextField(
              decoration: InputDecoration(
                hintText: "Search for help...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 25),

            // ================= CONTACT US =================

            const Text(
              "Contact Us",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // LIVE CHAT
            _contactTile(
              icon: Icons.chat_bubble_outline,
              title: "Live Chat",
              subtitle: "Chat with our support team",
              onTap: () {
                context.pushNamed('liveChat');
              },
            ),

            // EMAIL
            _contactTile(
              icon: Icons.email_outlined,
              title: "Email",
              subtitle: "Send us an email",
              onTap: _sendEmail,
            ),

            // CALL
            _contactTile(
              icon: Icons.phone_outlined,
              title: "Call Us",
              subtitle: "Talk to our support team",
              onTap: _callSupport,
            ),

            const SizedBox(height: 25),

            // ================= FAQ =================

            const Text(
              "Frequently Asked Questions",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ExpansionTile(
              leading: const Icon(Icons.shopping_bag_outlined),
              title: const Text(
                "How can I track my order?",
              ),
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Go to My Orders and select the order "
                    "you want to track.",
                  ),
                ),
              ],
            ),

            ExpansionTile(
              leading: const Icon(Icons.cancel_outlined),
              title: const Text(
                "Can I cancel my order?",
              ),
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "You can cancel your order before it "
                    "has been shipped.",
                  ),
                ),
              ],
            ),

            ExpansionTile(
              leading: const Icon(Icons.currency_rupee),
              title: const Text(
                "When will I receive my refund?",
              ),
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Refunds are usually processed within "
                    "5-7 business days.",
                  ),
                ),
              ],
            ),

            ExpansionTile(
              leading: const Icon(Icons.assignment_return_outlined),
              title: const Text(
                "How can I return a product?",
              ),
              children: const [
                Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    "Open My Orders, select the product, "
                    "and choose the Return option.",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ================= REPORT PROBLEM =================

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Report problem functionality
                },
                icon: const Icon(Icons.report_problem_outlined),
                label: const Text("Report a Problem"),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // ================= CONTACT TILE =================

  Widget _contactTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 1,
      margin: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 6,
        ),

        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade50,
          child: Icon(
            icon,
            color: Colors.blue,
          ),
        ),

        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),

        subtitle: Text(subtitle),

        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
        ),

        onTap: onTap,
      ),
    );
  }
}