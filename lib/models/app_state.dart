import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AppState extends ChangeNotifier {
  int selectedIndex = 0;
  String username = '';
  Map<String, dynamic> userData = {};
  bool isLoading = false;
  String? error;
  Map<String, dynamic> selectedCursus = {};
  Map<String, dynamic> selectedCampus = {};
  String? _token;
  DateTime? _tokenExpiry;

  final ApiService apiService = ApiService();

  AppState() {
    _initializeData();
  }

  Future<String> _getValidToken() async {
    // Check if token exists and is not expired
    if (_token != null && _tokenExpiry != null && DateTime.now().isBefore(_tokenExpiry!)) {
      return _token!;
    }

    // Get new token if expired or not exists
    _token = await apiService.getToken();
    _tokenExpiry = DateTime.now().add(Duration(hours: 2));
    return _token!;
  }

  Future<void> _initializeData() async {
    try {
      isLoading = true;
      notifyListeners();

      // for debug
      // userData = await apiService.getUser(username);

      if (userData.isNotEmpty &&
          userData['cursus_users'] != null &&
          userData['cursus_users'].isNotEmpty) {
        try {
          selectedCursus = userData['cursus_users'].firstWhere(
            (cursus) => cursus['cursus_id'] == 21,
          );
        } catch (e) {
          List<Map<String, dynamic>> inProgress = (userData['cursus_users'] as List)
              .where((cursus) => cursus['end_at'] == null)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();

          if (inProgress.isNotEmpty) {
            inProgress.sort((a, b) {
              String? aDate = a['begin_at'];
              String? bDate = b['begin_at'];
              if (aDate == null || bDate == null) return 0;
              return DateTime.parse(bDate).compareTo(DateTime.parse(aDate));
            });
            selectedCursus = inProgress.first;
          } else {
            selectedCursus = Map<String, dynamic>.from((userData['cursus_users'] as List).first);
          }
        }
      }

      if (userData.isNotEmpty &&
          userData['campus'] != null &&
          userData['campus'].isNotEmpty) {
        try {
          selectedCampus = userData['campus'].firstWhere(
            (campus) => campus['id'] == 1,
          );
        } catch (e) {
          List<Map<String, dynamic>> campuses = (userData['campus'] as List)
              .map((e) => Map<String, dynamic>.from(e))
              .toList();
          campuses.sort((a, b) {
            String? aDate = a['updated_at'];
            String? bDate = b['updated_at'];
            if (aDate == null || bDate == null) return 0;
            return DateTime.parse(bDate).compareTo(DateTime.parse(aDate));
          });
          selectedCampus = campuses.first;
        }
      }

      isLoading = false;
      notifyListeners();
    } catch (e) {
      error = e.toString();
      isLoading = false;
      notifyListeners();
      print('Error initializing data: $e');
    }
  }

  setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  Future<void> searchUser(String name) async {
    isLoading = true;
    error = null;
    notifyListeners();

    try {
      final token = await _getValidToken();
      print('Token: $token');
      userData = await apiService.getUser(name, token);
      username = name;
      await _initializeData();
      selectedIndex = 1;
    } catch (e) {
      error = e.toString();
      print('Error searching user: $e');
    }

    isLoading = false;
    notifyListeners();
  }

  void updateSelectedCursus(Map<String, dynamic> newCursus) {
    selectedCursus = newCursus;
    notifyListeners();
  }
}
