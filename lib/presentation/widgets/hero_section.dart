import 'package:flutter/material.dart';
import '../widgets/underworld_section.dart';

class HeroSection extends StatelessWidget {
  final ScrollController scrollController;
  const HeroSection({super.key, required this.scrollController});

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
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          // Positioned button in the center of the doors
          Positioned(
            left:
                MediaQuery.of(context).size.width * 0.5 -
                75, // Center horizontally
            top:
                MediaQuery.of(context).size.height *
                0.45, // Position at door level
            child: GestureDetector(
              onTap: () {
                // Navigate directly to Underworld Section (page 3)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => Scaffold(body: const UnderworldSection()),
                  ),
                );
              },
              child: Container(
                width: 150,
                height: 60,
                decoration: BoxDecoration(
                  color: const Color(0xFF8B4513), // Wood brown color
                  border: Border.all(color: const Color(0xFF654321), width: 3),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                    BoxShadow(
                      color: const Color(0xFF654321).withOpacity(0.4),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    'ENTER',
                    style: TextStyle(
                      fontFamily: 'DoubleFeature',
                      color: Color(0xFFFFE4B5), // Light wood text color
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black,
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
