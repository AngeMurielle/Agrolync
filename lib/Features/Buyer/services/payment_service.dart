import 'dart:async';

enum PaymentMethod { orangeMoney, mtnMomo }

class PaymentService {
  // Simulates a network call to the payment gateway
  static Future<bool> processPayment({
    required String phoneNumber,
    required double amount,
    required PaymentMethod method,
  }) async {
    // 1. Simulate network delay (e.g., waiting for the USSD prompt on the phone)
    await Future.delayed(const Duration(seconds: 3));

    // 2. Simulation Logic:
    // For testing, we'll assume payments to numbers starting with '6' are successful
    if (phoneNumber.startsWith('6') && phoneNumber.length >= 9) {
      return true; // Success
    } else {
      return false; // Failure (Simulating insufficient funds or user cancellation)
    }
  }
}