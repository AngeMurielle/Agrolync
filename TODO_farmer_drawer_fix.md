# Farmer Drawer Fix - TODO

## Steps
- [x] 1. Fix `lib/Features/Farmer/profile/profile.dart` - Replace `CircleAvatar(backgroundImage: NetworkImage(...))` with `ClipOval` + `Image.network`/`Image.file` with `errorBuilder` fallback.
- [x] 2. Fix `lib/Features/Farmer/drawer.dart` - Replace root `Column` with `ListView(padding: EdgeInsets.zero)` to make drawer scrollable.
- [x] 3. Fix `lib/Features/Farmer/Home.dart` - Add `onBackgroundImageError` fallback to app-bar `CircleAvatar`.
- [ ] 4. Hot-restart app and verify no exceptions when opening farmer drawer.

