import 'package:flutter/material.dart';
import '../models/app_state.dart';

class HomeButton extends StatelessWidget {
  final AppState appState;

  HomeButton({required this.appState});

  @override
  Widget build(BuildContext context) {
    return Padding(
    padding: const EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF333333),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
        onPressed: () {
          appState.setSelectedIndex(0);
          appState.username = '';
        },
        child: Text("Back to Home"),
      ),
    );
  }
}
