import 'package:flutter/material.dart';
import '../models/app_state.dart';

class user_primary extends StatelessWidget {
  const user_primary({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          child: Opacity(
            opacity: 0.3,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFF333333),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Color.fromARGB(255, 142, 142, 142), width: 0.7),
              ),
            ),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Color(0xFF333333),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Color.fromARGB(255, 142, 142, 142), width: 0.3),
            ),
            child: Text(
              appState.userData['location'] ?? 'unavailable',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
            decoration: BoxDecoration(
              color: Color(0xFF333333),
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              border: Border.all(color: Color.fromARGB(255, 142, 142, 142), width: 0.3),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(

                  children: [
                    Text(
                      "₳",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      appState.userData['wallet'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Ev.P",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      appState.userData['correction_point'].toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 70),
          child: Column(
            children: [
              if (appState.userData['image']['link'] != null)
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Color(0xFF35c47f), width: 2),
                  ),
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(appState.userData['image']['link']),
                  ),
                ),
              SizedBox(height: 10),
              Text(
                appState.userData['first_name'] + ' ' + appState.userData['last_name'],
                style: Theme.of(context).textTheme.titleLarge,
              ),
              // SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    appState.userData['login'],
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
              // SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    appState.selectedCursus['level'].toStringAsFixed(0),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 30),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ((appState.selectedCursus['level'] % 1) * 100)
                                  .toStringAsFixed(0) +
                                  '%',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            DropdownButton<Map<String, dynamic>>(
                              value: appState.selectedCursus,
                              items: (appState.userData['cursus_users'] as List).map((cursus) => DropdownMenuItem<Map<String, dynamic>>(
                                value: cursus,
                                child: Text(cursus['cursus']['name']),
                              )).toList(),
                              onChanged: (Map<String, dynamic>? newValue) {
                                if (newValue != null) {
                                  appState.updateSelectedCursus(newValue);
                                }
                              },
                              underline: Container(),
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              dropdownColor: Color(0xFF333333),
                            ),
                          ],
                        ),
                        // SizedBox(height: 4),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return Stack(
                              children: [
                                Container(
                                  height: 10,
                                  width: constraints.maxWidth,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                ),
                                Container(
                                  height: 10,
                                  width: constraints.maxWidth * 0.21,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                    color: Color(0xFF35c47f),
                                  ),
                                ),
                              ],
                            );
                          }
                        )
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
