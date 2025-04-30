import 'package:flutter/material.dart';
import '../Widgets/home_button.dart';
import '../models/app_state.dart';

class ErrorPage extends StatelessWidget {
  final String errorMessage;
  final AppState appState;

  ErrorPage(this.errorMessage, this.appState);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bkgrnd.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              SizedBox(height: 20),
              HomeButton(appState: appState),
            ],
          ),
        ),
      ),
    );
  }
}
