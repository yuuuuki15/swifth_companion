import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AppState extends ChangeNotifier {
  int	selectedIndex = 1;
  String	username = '';
  Map<String, dynamic>	userData = {};
  bool	isLoading = false;
  String?	error;

  final ApiService	apiService = ApiService();

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
