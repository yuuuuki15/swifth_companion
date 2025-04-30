import 'package:flutter/material.dart';
import '../models/app_state.dart';
import 'package:provider/provider.dart';
import '../Widgets/user_primary.dart';
import '../Widgets/user_secondary.dart';
import '../Widgets/skills.dart';
import '../Widgets/projects.dart';
import '../Widgets/home_button.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<AppState>();

    return Scaffold(
      backgroundColor: Color(0xFFfafafa),
      body: MyWidget(appState: appState),
    );
  }
}

class MyWidget extends StatelessWidget {
  const MyWidget({
    super.key,
    required this.appState,
  });

  final AppState appState;

  // common part of background container
  Widget _buildBackgroundContainer({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/bkgrnd.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: child,
      ),
    );
  }

  // user info section for mobile
  Widget _buildMobileUserInfo() {
    return Column(
      children: [
        if (appState.userData.isNotEmpty) ...[
          user_primary(appState: appState),
          SizedBox(height: 20),
          user_secondary(appState: appState),
        ],
      ],
    );
  }

  // user info section for desktop
  Widget _buildDesktopUserInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (appState.userData.isNotEmpty) ...[
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxHeight: 312),
              child: user_primary(appState: appState),
            ),
          ),
          SizedBox(width: 20),
          Flexible(
            child: Container(
              constraints: BoxConstraints(maxHeight: 312),
              child: user_secondary(appState: appState),
            ),
          ),
        ],
      ],
    );
  }

  // main content
  Widget _buildMainContent({required Widget userInfoSection}) {
    return Column(
      children: [
        _buildBackgroundContainer(child: userInfoSection),
        Skills(appState: appState),
        Projects(appState: appState),
        HomeButton(appState: appState),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return constraints.maxWidth < 768
                ? _buildMainContent(userInfoSection: _buildMobileUserInfo())
                : _buildMainContent(userInfoSection: _buildDesktopUserInfo());
          },
        ),
      ),
    );
  }
}
