import 'package:drip_skulls/presentation/widgets/entrance_screen.dart';
import 'package:drip_skulls/presentation/widgets/underworld_section.dart';
import 'package:flutter/material.dart';
import 'dart:html' as html;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Check if we're coming back from video
    final currentUrl = html.window.location.href;
    final shouldShowUnderworld = currentUrl.contains('from_video=true');

    return Scaffold(
      body:
          shouldShowUnderworld
              ? const UnderworldSection()
              : const EntranceScreen(),
    );
  }
}
