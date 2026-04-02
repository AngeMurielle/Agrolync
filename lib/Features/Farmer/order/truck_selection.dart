import 'package:flutter/material.dart';

class TruckSelectionPage extends StatefulWidget {
  final Map<String, dynamic> order;
  final Function(Map<String, dynamic>) onTruckSelected;

  const TruckSelectionPage({
    super.key,
    required this.order,
    required this.onTruckSelected,
  });

  @override
  State<TruckSelectionPage> createState() => _TruckSelectionPageState();
}

class _TruckSelectionPageState extends State<TruckSelectionPage> {
  final Color brandGreen = const Color(0xFF026139);
  String? selectedTruckId;

  final List<Map<String, dynamic>> availableTrucks = [
    {
      'id': 'TRK-001',
      'driver': 'John Doe',
      'vehicle': 'Toyota Hilux',
      'capacity': '2.5 tons',
      'rating': 4.8,
      'distance': '2.3 km away',
      'eta': '15 mins',
      'price': '2,500 XAF',
      'status': 'Available',
      'image': 'assets/images/truck1.png', // Placeholder
    },
    {
      'id': 'TRK-002',
      'driver': 'Mike Johnson',
      'vehicle': 'Ford Ranger',
      'capacity': '3.0 tons',
      'rating': 4.6,
      'distance': '3.8 km away',
      'eta': '22 mins',
      'price': '3,000 XAF',
      'status': 'Available',
      'image': 'assets/images/truck2.png', // Placeholder
    },
    {
      'id': 'TRK-003',
      'driver': 'Sarah Wilson',
      'vehicle': 'Chevrolet Colorado',
      'capacity': '2.8 tons',
      'rating': 4.9,
      'distance': '5.1 km away',
      'eta': '35 mins',
      'price': '2,800 XAF',
      'status': 'Available',
      'image': 'assets/images/truck3.png', // Placeholder
    },
    {
      'id': 'TRK-004',
      'driver': 'David Brown',
      'vehicle': 'Nissan Navara',
      'capacity': '3.5 tons',
      'rating': 4.7,
      'distance': '1.8 km away',
      'eta': '12 mins',
      'price': '3,200 XAF',
      'status': 'Available',
      'image': 'assets/images/truck4.png', // Placeholder
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FBF9),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: brandGreen),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Select Delivery Truck",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          // Order Summary
          Container(
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    widget.order['image'] ?? 'assets/images/maize.jpg',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.order['item'] ?? 'Product',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        'Order ${widget.order['id']}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE8F3EE),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text(
                    'Ready for Pickup',
                    style: TextStyle(
                      color: Color(0xFF026139),
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Available Trucks List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: availableTrucks.length,
              itemBuilder: (context, index) {
                final truck = availableTrucks[index];
                final isSelected = selectedTruckId == truck['id'];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isSelected ? brandGreen : Colors.grey.shade200,
                      width: isSelected ? 2 : 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedTruckId = truck['id'];
                      });
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              // Truck Image Placeholder
                              Container(
                                width: 60,
                                height: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Icon(
                                  Icons.local_shipping,
                                  color: Color(0xFF026139),
                                  size: 30,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          truck['driver'],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        if (isSelected)
                                          Icon(
                                            Icons.check_circle,
                                            color: brandGreen,
                                            size: 24,
                                          ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${truck['vehicle']} • ${truck['capacity']}',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: Colors.amber,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${truck['rating']}',
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Icon(
                                          Icons.location_on,
                                          color: Colors.grey.shade500,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          truck['distance'],
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    color: Colors.grey.shade500,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    'ETA: ${truck['eta']}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                truck['price'],
                                style: TextStyle(
                                  color: brandGreen,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Confirm Button
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.white,
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: selectedTruckId != null
                    ? () {
                        final selectedTruck = availableTrucks.firstWhere(
                          (truck) => truck['id'] == selectedTruckId,
                        );
                        widget.onTruckSelected(selectedTruck);
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Truck selected! Waiting for driver confirmation..."),
                            backgroundColor: Color(0xFF026139),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: brandGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  disabledBackgroundColor: Colors.grey.shade300,
                ),
                child: const Text(
                  "Confirm Truck Selection",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
