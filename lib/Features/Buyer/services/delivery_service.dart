enum CameroonRegion { sameTown, northRegion, otherRegions }

class DeliveryService {
  static const double taxRate = 0.05; // 5% Tax

  static double calculateShippingFee({
    required double subtotal,
    required CameroonRegion region,
  }) {
    switch (region) {
      case CameroonRegion.sameTown:
        return subtotal * 0.07; // 7% delivery for same town
      case CameroonRegion.otherRegions:
        return subtotal * 0.12; // 12% delivery for different town
      case CameroonRegion.northRegion:
        return subtotal * 0.15; // 15% delivery for North Cameroon
    }
  }

  static double calculateTax(double subtotal) {
    return subtotal * taxRate;
  }
}
