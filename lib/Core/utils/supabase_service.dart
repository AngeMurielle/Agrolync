import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static SupabaseClient get _client => Supabase.instance.client;

  static Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signUp(
      email: email,
      password: password,
    );
  }

  static Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  static Future<void> signOut() async {
    await _client.auth.signOut();
  }

  static Future<Map<String, dynamic>?> getCurrentUserProfile() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return null;

      final response =
          await _client.from('users').select('*').eq('id', user.id).single();

      return response as Map<String, dynamic>?;
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> createUserProfile({
    required String userId,
    required String fullName,
    required String email,
    required String role,
    String? phoneNumber,
  }) async {
    try {
      final response = await _client
          .from('users')
          .insert({
            'id': userId,
            'full_name': fullName,
            'email': email,
            'role': role,
            'phone_number': phoneNumber,
            'is_verified': false,
            'wallet_balance': 0,
          })
          .select()
          .single();

      return response as Map<String, dynamic>?;
    } catch (e) {
      return null;
    }
  }

  static Future<List<Map<String, dynamic>>> getActiveProducts() async {
    try {
      final response =
          await _client.from('products').select('*').eq('status', 'ACTIVE');

      return List<Map<String, dynamic>>.from(response as List<dynamic>);
    } catch (e) {
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getUserOrders() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return [];

      final response =
          await _client.from('orders').select('*').eq('user_id', user.id);

      return List<Map<String, dynamic>>.from(response as List<dynamic>);
    } catch (e) {
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getUserWalletTransactions() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return [];

      final response = await _client
          .from('wallet_transactions')
          .select('*')
          .eq('user_id', user.id)
          .order('date', ascending: false);

      return List<Map<String, dynamic>>.from(response as List<dynamic>);
    } catch (e) {
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getCurrentUserAddresses() async {
    try {
      final user = _client.auth.currentUser;
      if (user == null) return [];

      final response = await _client
          .from('addresses')
          .select('*')
          .eq('user_id', user.id)
          .order('created_at', ascending: false);

      return List<Map<String, dynamic>>.from(response as List<dynamic>);
    } catch (e) {
      return [];
    }
  }
}
