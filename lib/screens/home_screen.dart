import 'package:flutter/material.dart';
import '../models/app_state.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();
    String username = '';

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
              if (appState.error != null)
                Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    // color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    appState.error!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              Container(
                width: MediaQuery.of(context).size.width * 0.5,
                constraints: BoxConstraints(minWidth: 300, maxWidth: 600),
                decoration: BoxDecoration(
                //   color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Search by username",
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: TextStyle(color: Color(0xff1e3629)),
                      ),
                      style: TextStyle(
                        color: Color(0xFF333333),
                        fontSize: 16,
                      ),
                      onChanged: (value) {
                        username = value;
                      },
                      onFieldSubmitted: (_) {
                        if (username.isNotEmpty) {
                          appState.searchUser(username);
                        }
                      },
                    ),
                    SizedBox(height: 20),
                    if (appState.isLoading)
                      CircularProgressIndicator()
                    else
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          foregroundColor: Color(0xff1e3629),
                        ),
                        onPressed: () {
                          if (username.isNotEmpty) {
                            appState.searchUser(username);
                          }
                        },
                        child: Text("search")
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
