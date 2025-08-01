import 'package:flutter/material.dart';
import 'dart:html' as html; // For video playback on web
import 'underworld_section.dart';

class EntranceScreen extends StatefulWidget {
  const EntranceScreen({super.key});

  @override
  State<EntranceScreen> createState() => _EntranceScreenState();
}

class _EntranceScreenState extends State<EntranceScreen> {
  void _startVideo() {
    print('🎬 Redirecting to video intro page...');
    // Redirect to dedicated video HTML page
    html.window.location.href = './video_intro.html';
  }

  void _navigateToUnderworld() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(body: const UnderworldSection()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/images/ChatGPT Image Aug 1, 2025, 06_59_45 PM.png',
          ),
          fit: BoxFit.fill, // Fill entire screen without black sides
        ),
      ),
      child: Stack(
        children: [
          // Enter button positioned at the doors
          Positioned(
            left: MediaQuery.of(context).size.width * 0.5 - 75,
            top: MediaQuery.of(context).size.height * 0.45,
            child: GestureDetector(
              onTap: _startVideo,
              child: Container(
                width: 150,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFF654321), width: 3),
                  borderRadius: BorderRadius.circular(8),
                  // Wood texture effect
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFA0522D), // Lighter wood
                      Color(0xFF8B4513), // Main wood color
                      Color(0xFF654321), // Darker wood
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.7),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: const Color(0xFF654321).withOpacity(0.5),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'ENTER',
                    style: TextStyle(
                      fontFamily: 'DoubleFeature',
                      color: Color(0xFFFFFACD), // Creamy wood text color
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black,
                        ),
                        Shadow(
                          offset: Offset(1, 1),
                          blurRadius: 2,
                          color: Color(0xFF654321),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
