import 'package:flutter/material.dart';

class TransitionSection extends StatelessWidget {
  const TransitionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF0f0e0e), Color(0xFF2c1810), Color(0xFF4a2c17)],
        ),
        image: const DecorationImage(
          image: AssetImage(
            'assets/images/ChatGPT Image Jul 31, 2025, 03_00_19 AM.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(
            0.5,
          ), // Dark overlay for text readability
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.pets, size: 80, color: Colors.brown),
              SizedBox(height: 20),
              Text(
                'Underground Layer',
                style: TextStyle(
                  fontFamily: 'DoubleFeature',
                  color: Colors.white,
                  fontSize: 35,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      offset: Offset(2, 2),
                      blurRadius: 6,
                      color: Colors.black,
                    ),
                    Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 15,
                      color: Colors.brown,
                    ),
                    Shadow(
                      offset: Offset(0, 5),
                      blurRadius: 20,
                      color: Colors.orange,
                    ),
                  ],
                ),
              ),
              Text(
                'Rats and pipes beneath the earth',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 3,
                      color: Colors.black,
                    ),
                    Shadow(
                      offset: Offset(0, 0),
                      blurRadius: 8,
                      color: Colors.brown,
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
