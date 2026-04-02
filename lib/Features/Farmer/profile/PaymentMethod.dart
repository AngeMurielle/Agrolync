import 'package:flutter/material.dart';

class PaymentMethodPage extends StatefulWidget {
  const PaymentMethodPage({super.key});

  @override
  State<PaymentMethodPage> createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  // Brand Colors
  static const Color brandGreen = Color(0xFF026139);
  static const Color darkTextColor = Color(0xFF1E293B);
  static const Color subTextColor = Color(0xFF64748B);
  static const Color dangerRed = Color(0xFFEF4444);

  // Phone number states
  String mtnNumber = "+237 682 087 287";
  String orangeNumber = "+237 652 152 809";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Payment Methods',
          style: TextStyle(
              color: darkTextColor, fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Linked Accounts",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: darkTextColor),
            ),
            const SizedBox(height: 16),

            // MTN Card
            _buildPaymentCard(
              name: "MTN MoMo",
              number: mtnNumber,
              logoPath: 'assets/images/mtn_logo.jpg',
              onEdit: () => _showEditDialog("MTN MoMo", mtnNumber, (newVal) {
                setState(() => mtnNumber = newVal);
              }),
            ),
            const SizedBox(height: 12),

            // Orange Card
            _buildPaymentCard(
              name: "Orange Money",
              number: orangeNumber,
              logoPath: 'assets/images/orange_logo.jpg',
              onEdit: () =>
                  _showEditDialog("Orange Money", orangeNumber, (newVal) {
                setState(() => orangeNumber = newVal);
              }),
            ),

            const SizedBox(height: 24),
            _buildSafetyBox(),
          ],
        ),
      ),
      bottomNavigationBar: _buildSupportFooter(),
    );
  }

  Widget _buildPaymentCard({
    required String name,
    required String number,
    required String logoPath,
    required VoidCallback onEdit,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          // Real Image Logo
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              logoPath,
              height: 48,
              width: 48,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                height: 48,
                width: 48,
                color: Colors.grey[200],
                child: const Icon(Icons.broken_image, size: 20),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: darkTextColor,
                        fontSize: 16)),
                Text(number,
                    style: const TextStyle(color: subTextColor, fontSize: 14)),
              ],
            ),
          ),
          TextButton(
            onPressed: onEdit,
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFFF1F5F9),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: const Text("Edit",
                style:
                    TextStyle(color: brandGreen, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // Edit Dialog Logic
  void _showEditDialog(
      String provider, String currentNumber, Function(String) onSave) {
    TextEditingController controller =
        TextEditingController(text: currentNumber);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $provider"),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            labelText: "Phone Number",
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                    content: Text("$provider number updated successfully!")),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: brandGreen),
            child: const Text("Save Changes",
                style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildSafetyBox() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF1F2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFFECDD3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Safety & Management",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: darkTextColor,
                  fontSize: 16)),
          const SizedBox(height: 8),
          const Text(
              "Removing a method will stop all future automatic payouts.",
              style: TextStyle(color: subTextColor, fontSize: 14)),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {},
            child: const Row(
              children: [
                Text("Remove account",
                    style: TextStyle(
                        color: dangerRed, fontWeight: FontWeight.bold)),
                SizedBox(width: 8),
                Icon(Icons.delete_outline, color: dangerRed, size: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSupportFooter() {
    return Container(
      // Increased margin and internal padding for more height
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 30),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 25),
      decoration: BoxDecoration(
        color: brandGreen,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: brandGreen.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 5))
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Need Help?",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
              SizedBox(height: 4),
              Text(
                "Contact Farmer Support 24/7",
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.headset_mic_outlined,
                  color: Colors.white, size: 32),
            ),
          ),
        ],
      ),
    );
  }
}
