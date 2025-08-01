import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:audioplayers/audioplayers.dart';
import 'dart:math' as math;

class UnderworldSection extends StatefulWidget {
  const UnderworldSection({super.key});

  @override
  State<UnderworldSection> createState() => _UnderworldSectionState();
}

class _UnderworldSectionState extends State<UnderworldSection>
    with TickerProviderStateMixin {
  bool _showStoryModal = false;
  bool _showCommunityModal = false;
  bool _showMenu = false;
  bool _flashRight = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMuted = false;
  bool _musicStarted = false;
  late AnimationController _blinkController;

  @override
  void initState() {
    super.initState();
    // Start music automatically when entering this screen
    _playBackgroundMusic();

    // Initialize blinking animation
    _blinkController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _blinkController.dispose();
    super.dispose();
  }

  void _playBackgroundMusic() {
    if (!_musicStarted) {
      _audioPlayer.play(AssetSource('sounds/background_music.mp3'));
      _audioPlayer.setReleaseMode(ReleaseMode.loop);
      setState(() {
        _musicStarted = true;
        _isMuted = false;
      });
    }
  }

  void _toggleMute() {
    setState(() {
      if (!_musicStarted) {
        _playBackgroundMusic();
      } else {
        _isMuted = !_isMuted;
        if (_isMuted) {
          _audioPlayer.pause();
        } else {
          _audioPlayer.resume();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/underworld_background.png'),
          fit: BoxFit.fill, // Fill entire screen without black sides
        ),
      ),
      child: Stack(
        children: [
          // Flash effect for right side
          if (_flashRight)
            Positioned.fill(
              child: Container(color: Colors.white.withOpacity(0.3)),
            ),

          // Right side - Second character area (NULL Story)
          Positioned(
            right: 0,
            top: 0,
            width: MediaQuery.of(context).size.width * 0.5,
            height: MediaQuery.of(context).size.height,
            child: GestureDetector(
              onTap: () {
                // Flash effect
                setState(() => _flashRight = true);
                Future.delayed(const Duration(milliseconds: 150), () {
                  setState(() => _flashRight = false);
                });

                // Show story modal
                setState(() => _showStoryModal = true);
              },
              child: Container(
                color: Colors.transparent,
                child: const Center(
                  child: Tooltip(
                    message: 'Click to read NULL Story',
                    child: Icon(
                      Icons.menu_book,
                      color: Colors.transparent,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Music control button
          Positioned(
            bottom: 20,
            left: 20,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFFD2B48C), // Light tan
                    Color(0xFFA0522D), // Sienna
                    Color(0xFF8B4513), // SaddleBrown
                  ],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: const Color(0xFF2F1B14), width: 3),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF8B4513).withOpacity(0.8),
                    blurRadius: 15,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: IconButton(
                onPressed: _toggleMute,
                icon: Icon(
                  _musicStarted && !_isMuted
                      ? Icons.volume_up
                      : Icons.volume_off,
                  color: const Color(0xFF2F1B14),
                  size: 28,
                  shadows: [
                    Shadow(
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                      color: const Color(0xFFD2B48C),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Blinking indicator on the right character
          Positioned(
            right: MediaQuery.of(context).size.width * 0.25 - 15,
            top: MediaQuery.of(context).size.height * 0.3,
            child: AnimatedBuilder(
              animation: _blinkController,
              builder: (context, child) {
                return Opacity(
                  opacity:
                      (0.3 +
                          0.7 *
                              (1 +
                                  math.sin(
                                    _blinkController.value * 2 * math.pi,
                                  )) /
                              2),
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFFD2B48C), // Light tan
                          Color(0xFFA0522D), // Sienna
                          Color(0xFF8B4513), // SaddleBrown
                        ],
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFF2F1B14),
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF8B4513).withOpacity(0.9),
                          blurRadius: 25,
                          offset: const Offset(0, 0),
                        ),
                        BoxShadow(
                          color: const Color(0xFFD2B48C).withOpacity(0.6),
                          blurRadius: 35,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        '!',
                        style: TextStyle(
                          color: Color(0xFF2F1B14),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              offset: Offset(1, 1),
                              blurRadius: 2,
                              color: Color(0xFFD2B48C),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Logo Menu Button
          Positioned(
            top: 20,
            right: 20,
            child: GestureDetector(
              onTap: () => setState(() => _showMenu = !_showMenu),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(35),
                  border: Border.all(color: const Color(0xFF2F1B14), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF8B4513).withOpacity(0.8),
                      blurRadius: 15,
                      offset: const Offset(0, 0),
                    ),
                    BoxShadow(
                      color: const Color(0xFF654321).withOpacity(0.4),
                      blurRadius: 20,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: Image.asset(
                    'assets/images/PixelSkull_Logo_Transparent.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Color(0xFFD2B48C), // Tan
                              Color(0xFFA0522D), // Sienna
                              Color(0xFF8B4513), // SaddleBrown
                              Color(0xFF654321), // Dark Brown
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            '💀',
                            style: TextStyle(
                              fontSize: 30,
                              shadows: [
                                Shadow(
                                  offset: Offset(2, 2),
                                  blurRadius: 4,
                                  color: Color(0xFF2F1B14),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),

          // Menu Dropdown
          if (_showMenu) _buildMenu(),

          // Story Modal
          if (_showStoryModal) _buildStoryModal(),

          // Community Modal
          if (_showCommunityModal) _buildCommunityModal(),

          // Bottom Text
          Positioned(
            bottom: 15,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'PIXELSKULL 2025',
                style: TextStyle(
                  fontFamily: 'monospace',
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  shadows: [
                    Shadow(
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                      color: Colors.black.withOpacity(0.8),
                    ),
                    Shadow(
                      offset: const Offset(1, 1),
                      blurRadius: 8,
                      color: const Color(0xFF8B4513).withOpacity(0.6),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryModal() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.9),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2F1B14), // Very Dark Brown
                  Color(0xFF1a1a2e), // Dark Blue-Gray
                  Color(0xFF2F1B14), // Very Dark Brown
                ],
              ),
              border: Border.all(color: const Color(0xFF8B4513), width: 4),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8B4513).withOpacity(0.8),
                  blurRadius: 25,
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: const Color(0xFFD2B48C).withOpacity(0.3),
                  blurRadius: 35,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFD2B48C), // Light tan
                        Color(0xFFA0522D), // Sienna
                        Color(0xFF8B4513), // SaddleBrown
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '💀 THE NULL ENTITY 💀',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: Color(0xFF2F1B14),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              color: Color(0xFFD2B48C),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed:
                            () => setState(() => _showStoryModal = false),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'THE NULL ENTITY',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Color(0xFFD2B48C),
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Color(0xFF8B4513),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'NULL was the first to awaken. A being of pure digital essence, it possessed the power to manipulate code itself. Legend says that NULL holds the key to the ultimate truth about the digital underworld - a secret so powerful it could reshape reality itself.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Born from the remnants of a failed AI experiment, NULL exists between the spaces of binary code. Its skull glows with an ethereal light, each pixel containing infinite possibilities. When NULL appears, the very fabric of the digital realm bends to its will.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'THE PROPHECY',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Color(0xFFD2B48C),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.8,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Color(0xFF8B4513),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Ancient protocols speak of NULL\'s return to the digital throne. When the binary stars align and the quantum gates open, NULL will lead the skull army to reclaim the lost data kingdoms and establish a new order in the cyber realm.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 30),
                        const Text(
                          'Seek NULL among the 164 awakened souls, for only those who understand the void can master the infinite.',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Color(0xFFD2B48C),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.6,
                            fontStyle: FontStyle.italic,
                            letterSpacing: 1,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Color(0xFF8B4513),
                              ),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildMenu() {
    return Positioned(
      top: 110,
      right: 20,
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFD2B48C), // Light tan
              Color(0xFFC19A6B), // Medium tan
              Color(0xFFA0522D), // Sienna
            ],
          ),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: const Color(0xFF2F1B14), width: 4),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF654321).withOpacity(0.8),
              blurRadius: 25,
              offset: const Offset(0, 8),
            ),
            BoxShadow(
              color: const Color(0xFF2F1B14).withOpacity(0.6),
              blurRadius: 15,
              offset: const Offset(0, 0),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title
              Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: const Text(
                  'UNDERGROUND LAYER',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2F1B14),
                    letterSpacing: 1.5,
                    shadows: [
                      Shadow(
                        offset: Offset(1, 1),
                        blurRadius: 2,
                        color: Color(0xFFD2B48C),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // X (Twitter) Button
              _buildRetroButton('Follow Us', Icons.link, () {
                html.window.open('https://x.com/dj_upanddown', '_blank');
                setState(() => _showMenu = false);
              }),

              // OpenSea Store Button
              _buildRetroButton('Our Store', Icons.shopping_bag, () {
                html.window.open(
                  'https://opensea.io/collection/dripskulls-67969847',
                  '_blank',
                );
                setState(() => _showMenu = false);
              }),

              // Story Button
              _buildRetroButton('Our Story', Icons.book, () {
                setState(() {
                  _showMenu = false;
                  _showStoryModal = true;
                });
              }),

              // Community Button
              _buildRetroButton('Join Community', Icons.groups, () {
                setState(() {
                  _showMenu = false;
                  _showCommunityModal = true;
                });
              }),

              // Music Button
              _buildRetroButton(
                _musicStarted && !_isMuted ? 'Music On' : 'Music Off',
                _musicStarted && !_isMuted ? Icons.volume_up : Icons.volume_off,
                () {
                  _toggleMute();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRetroButton(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF8B4513), // SaddleBrown
                Color(0xFF654321), // DarkBrown
                Color(0xFF2F1B14), // Very Dark Brown
              ],
            ),
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: const Color(0xFF2F1B14), width: 3),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF2F1B14).withOpacity(0.8),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: const Color(0xFFD2B48C).withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(-2, -2),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: const Color(0xFFD2B48C),
                size: 20,
                shadows: [
                  Shadow(
                    offset: const Offset(1, 1),
                    blurRadius: 2,
                    color: Colors.black.withOpacity(0.8),
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'monospace',
                  color: Color(0xFFD2B48C),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  shadows: [
                    Shadow(
                      offset: Offset(1, 1),
                      blurRadius: 2,
                      color: Colors.black,
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

  Widget _buildCommunityModal() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.9),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF2F1B14), // Very Dark Brown
                  Color(0xFF1a1a2e), // Dark Blue-Gray
                  Color(0xFF2F1B14), // Very Dark Brown
                ],
              ),
              border: Border.all(color: const Color(0xFF8B4513), width: 4),
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF8B4513).withOpacity(0.8),
                  blurRadius: 25,
                  offset: const Offset(0, 0),
                ),
                BoxShadow(
                  color: const Color(0xFFD2B48C).withOpacity(0.3),
                  blurRadius: 35,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFFD2B48C), // Light tan
                        Color(0xFFA0522D), // Sienna
                        Color(0xFF8B4513), // SaddleBrown
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(21),
                      topRight: Radius.circular(21),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        '🧠 JOIN THE DRIP-SKULLS COMMUNITY 🧠',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          color: Color(0xFF2F1B14),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                          shadows: [
                            Shadow(
                              offset: Offset(2, 2),
                              blurRadius: 3,
                              color: Color(0xFFD2B48C),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed:
                            () => setState(() => _showCommunityModal = false),
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'DRIP-SKULLS: RISING FROM THE FORGOTTEN',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Color(0xFFD2B48C),
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.8,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Color(0xFF8B4513),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'In a post-collapse digital wasteland, remnants of lost souls begin to reawaken. These aren\'t just skeletons. They\'re not monsters. They\'re memories given form. They\'re Drip-Skulls.\n\nEach Drip-Skull is a unique entity, reconstructed by an unstable AI using fragments of human identity — warriors, rebels, dreamers, traitors. But the resurrection isn\'t perfect. Each Skull returns with a single emotional echo: the DRIP. That drop is all that remains of who they were.\n\nThey rise from below, not above — from ruined cities, forgotten bunkers, corrupted code tunnels. Their world isn\'t the metaverse. It\'s beneath it.\n\nThe Underground Layer is where they gather. It\'s not a party. It\'s a memory web. The more Skulls connect, the more the truth resurfaces. This is not about hype — it\'s about history.\n\nSome were built to burn. Others were built to lead. And some... were built to erase.\n\nEach Skull holds a story. Some are still being written.\n\nThey\'re not dead. They\'re just... remembering.\n\nDrip-Skulls is more than an NFT collection. It\'s a resurrection of identity, wrapped in digital bones. It\'s your chance to be part of a story that doesn\'t forget.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 25),
                        const Text(
                          '🧠 JOIN THE DRIP-SKULLS COMMUNITY',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Color(0xFFD2B48C),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Color(0xFF8B4513),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          'This isn\'t a club. It\'s not a membership. It\'s a reawakening.\n\nTo join us, you must do what they couldn\'t: Claim a soul. Own a memory. Become a Skull.\n\nEvery Drip-Skull carries a forgotten identity. When you hold one — you hold the key to the Underground Layer. Your access. Your drip. Your connection.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '🎭 WHAT HAPPENS WHEN YOU JOIN?',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Color(0xFFD2B48C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Color(0xFF8B4513),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Text(
                          '🔓 Full access to the community layer\n🧬 Lore drops & hidden storylines\n🗝️ Private calls with the Council of the Forgotten\n🧠 First to unlock new memory packs\n👑 And maybe... discover who you used to be',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.8,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '🎁 SOON:',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            color: Color(0xFFD2B48C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                            shadows: [
                              Shadow(
                                offset: Offset(2, 2),
                                blurRadius: 4,
                                color: Color(0xFF8B4513),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Those who hold early will get something only the dead deserve.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.6,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
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
