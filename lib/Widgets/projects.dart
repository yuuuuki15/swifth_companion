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
    // Get the selected cursus ID
    final selectedCursusId = appState.selectedCursus['cursus_id'];

    // Filter projects for the selected cursus
    final filteredProjects = appState.userData['projects_users'] != null
        ? List.from(appState.userData['projects_users'])
            .where((project) => project['cursus_ids'].contains(selectedCursusId))
            .toList()
        : [];

    return SizedBox(
      height: 400,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: 1000),
            decoration: BoxDecoration(
              color: Color(0xFFFFFFFF),
              border: Border.all(
                color: Color(0xFFCCCCCC),
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Projects',
                      style: GoogleFonts.inter(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      child: Column(
                        children: [
                          if (filteredProjects.isNotEmpty) ...[
                            ...filteredProjects.map((project) {
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
                            Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 20),
                                child: Text(
                                  'No projects found',
                                  style: GoogleFonts.inter(
                                    fontSize: 16,
                                    color: Color(0xFF666666),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
