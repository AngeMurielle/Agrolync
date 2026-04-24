import 'package:flutter/material.dart';
import 'package:flutter_agrolync_pro/Features/Logistics/data/ui/screens/complete.dart';

class Delivery extends StatefulWidget {
  final List<Map<String, dynamic>>? completedDeliveries;

  const Delivery({super.key, this.completedDeliveries});

  @override
  State<Delivery> createState() => _DeliveryState();
}

class _DeliveryState extends State<Delivery> {
  final Color primaryGreen = const Color(0xFF015E38);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deliveries = widget.completedDeliveries ?? [];
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Light background for contrast
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
        children: [
          // Show only completed deliveries from My Routes
          if (deliveries.isEmpty)
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: Column(
                  children: [
                    Icon(Icons.check_circle_outline,
                        size: 64, color: Colors.grey[300]),
                    const SizedBox(height: 12),
                    const Text(
                      "No completed deliveries yet",
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Complete deliveries from 'My Routes' to see them here",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
            )
          else
            ...deliveries.map((delivery) => _buildTripCard(
                  context: context,
                  tripId: delivery['tripId'],
                  location: delivery['location'],
                  date: delivery['date'],
                  time: delivery['time'],
                  earnings: delivery['earnings'],
                  icon: delivery['icon'],
                  status: delivery['status'],
                )),
        ],
      ),
    );
  }

  Widget _buildTripCard({
    required BuildContext context,
    required String tripId,
    required String location,
    required String date,
    required String time,
    required String earnings,
    required IconData icon,
    String status = 'delivered',
  }) {
    bool isDelivered = status == 'delivered';

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Circular Icon Container
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F3EF),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: const Color(0xFF015E38), size: 24),
              ),
              const SizedBox(width: 15),
              // Trip Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "TRIP ID: #$tripId",
                      style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      location,
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "$date • $time",
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ],
                ),
              ),
              // Status Badge
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: isDelivered
                      ? const Color(0xFFD4E9E2)
                      : const Color(0xFFFFF3CD),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(
                      isDelivered ? Icons.check_circle : Icons.schedule,
                      color: isDelivered
                          ? const Color(0xFF015E38)
                          : const Color(0xFF856404),
                      size: 14,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      isDelivered ? "DELIVERED" : "PENDING",
                      style: TextStyle(
                          color: isDelivered
                              ? const Color(0xFF015E38)
                              : const Color(0xFF856404),
                          fontSize: 9,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(height: 1),
          const SizedBox(height: 15),
          // Earnings and Action Button
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("EARNINGS",
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    earnings,
                    style: const TextStyle(
                        color: Color(0xFF015E38),
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              if (isDelivered)
                ElevatedButton.icon(
                  onPressed: () => _showReceiptModal(
                    context,
                    tripId: tripId,
                    location: location,
                    date: date,
                    time: time,
                    earnings: earnings,
                  ),
                  icon: const Icon(Icons.receipt_long, size: 16),
                  label: const Text("View Receipt"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF1F4F2),
                    foregroundColor: Colors.black87,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                )
              else
                ElevatedButton.icon(
                  onPressed: () => _markAsCompleted(tripId),
                  icon: const Icon(Icons.check_circle, size: 16),
                  label: const Text("Complete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF015E38),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 12),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _markAsCompleted(String tripId) {
    final deliveries = widget.completedDeliveries;
    if (deliveries == null) return;
    // Find the delivery and mark as completed
    final index = deliveries.indexWhere((d) => d['tripId'] == tripId);
    if (index != -1) {
      deliveries[index]['status'] = 'delivered';
    }

    // Navigate to completion screen
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DeliveryCompleteScreen(
          orderId: tripId,
          earnings:
              deliveries.firstWhere((d) => d['tripId'] == tripId)['earnings'],
          jobData: deliveries.firstWhere((d) => d['tripId'] == tripId),
        ),
      ),
    );
  }

  void _showReceiptModal(
    BuildContext context, {
    required String tripId,
    required String location,
    required String date,
    required String time,
    required String earnings,
  }) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        builder: (context) => Container(
              color: Colors.white,
              child: DraggableScrollableSheet(
                initialChildSize: 0.8,
                minChildSize: 0.6,
                maxChildSize: 0.95,
                builder: (context, scrollController) => SingleChildScrollView(
                  controller: scrollController,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Handle Bar
                        Center(
                          child: Container(
                            width: 40,
                            height: 4,
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Header with close button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Delivery Receipt",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF015E38),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F3EF),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(Icons.close,
                                    size: 20, color: Color(0xFF015E38)),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Receipt Content Box
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: const Color(0xFFE8F3EF), width: 1),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: [
                              // Checkmark Icon
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD4E9E2),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Icon(
                                  Icons.check_circle,
                                  color: Color(0xFF015E38),
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 16),

                              // Status
                              const Text(
                                "Delivery Completed",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF015E38),
                                ),
                              ),
                              const SizedBox(height: 20),

                              // Divider
                              Divider(color: const Color(0xFFE8F3EF)),
                              const SizedBox(height: 16),

                              // Trip Details
                              _buildReceiptRow(
                                label: "Trip ID",
                                value: "#$tripId",
                              ),
                              const SizedBox(height: 12),
                              _buildReceiptRow(
                                label: "Delivery Location",
                                value: location,
                                isMultiline: true,
                              ),
                              const SizedBox(height: 12),
                              _buildReceiptRow(
                                label: "Date",
                                value: date,
                              ),
                              const SizedBox(height: 12),
                              _buildReceiptRow(
                                label: "Time",
                                value: time,
                              ),

                              const SizedBox(height: 16),
                              Divider(color: const Color(0xFFE8F3EF)),
                              const SizedBox(height: 16),

                              // Earnings Section
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Total Earnings",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey,
                                    ),
                                  ),
                                  Text(
                                    earnings,
                                    style: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF015E38),
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 24),

                              // Additional Info
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFE8F3EF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Payment Method",
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF015E38),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    const Text(
                                      "Wallet Transfer",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF015E38),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      "Reference ID: REF-${215945}",
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Download/Print Button
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton.icon(
                                  onPressed: () => _downloadReceipt(
                                    context,
                                    tripId: tripId,
                                    location: location,
                                    date: date,
                                    time: time,
                                    earnings: earnings,
                                  ),
                                  icon: const Icon(Icons.download),
                                  label: const Text("Download Receipt"),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF015E38),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Close Button
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton(
                                  onPressed: () => Navigator.pop(context),
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 12),
                                    side: const BorderSide(
                                        color: Color(0xFF015E38), width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  child: const Text("Close",
                                      style: TextStyle(
                                          color: Color(0xFF015E38),
                                          fontWeight: FontWeight.w600)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Widget _buildReceiptRow({
    required String label,
    required String value,
    bool isMultiline = false,
  }) {
    return Row(
      crossAxisAlignment:
          isMultiline ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.end,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            maxLines: isMultiline ? 3 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  IconData _getIconForJob(String jobTitle) {
    if (jobTitle.toLowerCase().contains('potato')) {
      return Icons.agriculture;
    } else if (jobTitle.toLowerCase().contains('coffee')) {
      return Icons.local_cafe;
    } else if (jobTitle.toLowerCase().contains('cocoa')) {
      return Icons.grain;
    } else if (jobTitle.toLowerCase().contains('produce') ||
        jobTitle.toLowerCase().contains('fresh')) {
      return Icons.eco;
    } else {
      return Icons.local_shipping;
    }
  }

  Future<void> _downloadReceipt(
    BuildContext context, {
    required String tripId,
    required String location,
    required String date,
    required String time,
    required String earnings,
  }) async {
    try {
      // Generate receipt content
      final receiptContent = _generateReceiptContent(
        tripId: tripId,
        location: location,
        date: date,
        time: time,
        earnings: earnings,
      );

      // Create a file name with timestamp
      final fileName =
          'receipt_${tripId}_${DateTime.now().millisecondsSinceEpoch}.txt';

      // Show success dialog
      if (!context.mounted) return;

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F3EF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.check_circle,
                    color: Color(0xFF015E38), size: 24),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Text(
                  "Receipt Downloaded",
                  style: TextStyle(
                    color: Color(0xFF015E38),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Your receipt has been saved successfully.",
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9F9F9),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFE8F3EF)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "File Details",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Name: $fileName",
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF015E38),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Trip ID: #$tripId",
                      style: const TextStyle(
                        fontSize: 11,
                        color: Color(0xFF015E38),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                "Done",
                style: TextStyle(
                  color: Color(0xFF015E38),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    } catch (e) {
      // Show error dialog
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error downloading receipt: $e'),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  String _generateReceiptContent({
    required String tripId,
    required String location,
    required String date,
    required String time,
    required String earnings,
  }) {
    final timestamp = DateTime.now();
    const appName = "AGROLYNC PRO";

    return '''
================================================================================
                              $appName
                         DELIVERY RECEIPT
================================================================================

Date Generated: ${timestamp.toString().substring(0, 19)}

================================================================================
                            DELIVERY DETAILS
================================================================================

Trip ID:                    #$tripId
Delivery Location:          $location
Date of Delivery:           $date
Time of Delivery:           $time

================================================================================
                            PAYMENT SUMMARY
================================================================================

Total Earnings:             $earnings
Payment Method:             Wallet Transfer
Status:                     COMPLETED ✓

Reference ID:               REF-${DateTime.now().millisecondsSinceEpoch.toString().substring(4, 10)}

================================================================================
                            ADDITIONAL INFO
================================================================================

The funds have been successfully transferred to your wallet.
You can check your wallet balance in the App.

For any inquiries or disputes, please contact support@agrolyncpro.com

================================================================================
                            THANK YOU!
        Your dedication to excellent delivery service is appreciated.
================================================================================

This is an electronically generated receipt and does not require a signature.
''';
  }
}
