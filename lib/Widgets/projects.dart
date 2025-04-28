import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/app_state.dart';

class Projects extends StatelessWidget {
  const Projects({
    super.key,
    required this.appState,
  });

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            color: Color(0xFFFFFFFF),
            child: Column(
              children: [
                Center(
                  child: Text(
                    'Projects',
                    style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ),
                if (appState.userData['projects_users'] != null) ...[
                  ...List.from(appState.userData['projects_users']).map((project) {
                    return Card(
                      color: Color(0xFFfafafa),
                      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: ListTile(
                        title: Text(
                          project['project']['name'],
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: Text(
                          project['validated?'] == true
                            ? 'succeeded with ${project['final_mark']?.toStringAsFixed(0) ?? 'N/A'}'
                            : project['validated?'] == false
                              ? 'failed with ${project['final_mark']?.toStringAsFixed(0) ?? 'N/A'}'
                              : 'in progress',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            color: project['validated?'] == true
                              ? Color(0xFF4CAF50)
                              : project['validated?'] == false
                                ? Color(0xFFF44336)
                                : Color(0xFF333333),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ] else ...[
                  Text('No projects found'),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
