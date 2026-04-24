# Fix Plan

## Step 1: Fix `complete.dart` line 231
- [x] Change `Delivery(completedJob: jobData)` to `Delivery(completedDeliveries: jobData != null ? [jobData] : null)`

## Step 2: Fix `delivered.dart` state references
- [x] Replace bare `completedDeliveries` references inside `_DeliveryState` with `widget.completedDeliveries` (with null-safety handling).

## Step 3: Verify
- [x] Run `flutter analyze` — no issues found in the two files.

