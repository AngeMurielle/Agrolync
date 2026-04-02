import 'package:flutter/material.dart';

void showCashOutModal(BuildContext context) {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  
  // Define Brand Colors
  const Color primaryGreen = Color(0xFF015E38);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.white, // Ensure modal background is White
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    builder: (context) => Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle bar for better UX
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const Text(
              "Mobile Money Withdrawal",
              style: TextStyle(
                fontSize: 20, 
                fontWeight: FontWeight.bold, 
                color: primaryGreen, // Text in Brand Green
              ),
            ),
            const SizedBox(height: 25),
            
            // Payment Method Dropdown
            DropdownButtonFormField<String>(
              dropdownColor: Colors.white,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                labelText: "Payment Method",
                labelStyle: const TextStyle(color: Colors.grey),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: primaryGreen, width: 2),
                ),
              ),
              hint: const Text("Select method"),
              items: const [
                DropdownMenuItem(value: "OM", child: Text("Orange Money")),
                DropdownMenuItem(value: "Momo", child: Text("MTN MoMo")),
              ],
              validator: (value) => value == null ? "Please select a method" : null,
              onChanged: (val) {},
            ),
            const SizedBox(height: 15),
            
            // Phone Number Field
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              cursorColor: primaryGreen,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "6xxxxxxxx",
                labelText: "Phone Number",
                labelStyle: const TextStyle(color: Colors.grey),
                prefixIcon: const Icon(Icons.phone, color: primaryGreen),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: primaryGreen, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Enter a phone number";
                if (!RegExp(r'^6[0-9]{8}$').hasMatch(value)) {
                  return "Invalid number (ex: 690123456)";
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            
            // Amount Field
            TextFormField(
              controller: amountController,
              keyboardType: TextInputType.number,
              cursorColor: primaryGreen,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: "Ex: 5000",
                labelText: "Amount (XAF)",
                labelStyle: const TextStyle(color: Colors.grey),
                prefixText: "XAF ",
                prefixStyle: const TextStyle(color: primaryGreen, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: primaryGreen, width: 2),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Enter an amount";
                final amount = double.tryParse(value);
                if (amount == null || amount < 100) return "Minimum 100 XAF";
                return null;
              },
            ),
            const SizedBox(height: 30),
            
            // Full-Width Confirm Button
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Withdrawal request for ${amountController.text} XAF sent!"),
                        backgroundColor: primaryGreen,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryGreen,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text(
                  "Confirm Withdrawal",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    ),
  );
}