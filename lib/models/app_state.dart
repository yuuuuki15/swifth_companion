import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AppState extends ChangeNotifier {
  int selectedIndex = 1;
  String username = 'ykawakit';
  Map<String, dynamic> userData = {};
  bool isLoading = false;
  String? error;
  Map<String, dynamic> selectedCursus = {};
  Map<String, dynamic> selectedCampus = {};

  final ApiService apiService = ApiService();

  AppState() {
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      isLoading = true;
      notifyListeners();

      userData = await apiService.getUser(username);

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
            // priority Paris campus
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

      selectedCursus = selectedCursus;
      selectedCampus = selectedCampus;
      print('selectedCampus: $selectedCampus');
      print('selectedCursus: $selectedCursus');

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

  void updateSelectedCursus(Map<String, dynamic> newCursus) {
    selectedCursus = newCursus;
    notifyListeners();
  }
}
