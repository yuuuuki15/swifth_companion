import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AppState extends ChangeNotifier {
  int selectedIndex = 1;
  String username = 'ykawakit';
  Map<String, dynamic> userData = {};
  bool isLoading = false;
  String? error;

  final ApiService apiService = ApiService();

  AppState() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      isLoading = true;
      notifyListeners();

      userData = await apiService.getUser(username);
      print('login: ${userData['login']}');

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
      userData = await apiService.getUser(name);
      username = name;
      selectedIndex = 1;
    } catch (e) {
      error = e.toString();
      print('Error: $e');
    }

    isLoading = false;
    notifyListeners();
  }
}
