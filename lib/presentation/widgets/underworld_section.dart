import 'package:flutter/material.dart';
import 'dart:html' as html;
import 'package:audioplayers/audioplayers.dart';
import 'package:url_launcher/url_launcher.dart';

class UnderworldSection extends StatefulWidget {
  const UnderworldSection({super.key});

  @override
  State<UnderworldSection> createState() => _UnderworldSectionState();
}

class _UnderworldSectionState extends State<UnderworldSection> {
  bool _isHoveringLore = false;
  bool _showStoryModal = false;
  bool _showAboutModal = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isMuted = false;
  bool _musicStarted = false;

  @override
  void initState() {
    super.initState();
    // לא מנגן אוטומטית - חכה ללחיצה של המשתמש
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playBackgroundMusic() async {
    try {
      await _audioPlayer.setReleaseMode(ReleaseMode.loop);
      await _audioPlayer.setVolume(0.3); // קצת יותר שקט

      // נסה קובצי אודיו שונים
      List<String> audioFiles = [
        'sounds/background_music.mp3',
        'sounds/Untitled (1).mp3',
        'sounds/background_music.wav',
        'sounds/background_music.ogg',
      ];

      bool musicStarted = false;
      for (String audioFile in audioFiles) {
        try {
          await _audioPlayer.play(AssetSource(audioFile));
          musicStarted = true;
          print('Successfully playing: $audioFile');
          break;
        } catch (e) {
          print('Failed to play $audioFile: $e');
          continue;
        }
      }

      if (!musicStarted) {
        print('Failed to play any audio file');
      }
    } catch (e) {
      print('Error setting up background music: $e');
    }
  }

  void _toggleMute() {
    print(
      'Toggle mute clicked! musicStarted: $_musicStarted, isMuted: $_isMuted',
    );
    setState(() {
      if (!_musicStarted) {
        print('Starting background music...');
        // אם השיר עוד לא התחיל, התחל אותו
        _playBackgroundMusic();
        _musicStarted = true;
        _isMuted = false;
      } else {
        // אם השיר כבר רץ, החלף בין השתקה להפעלה
        _isMuted = !_isMuted;
        print('Music ${_isMuted ? "paused" : "resumed"}');
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
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 16 / 9, // יחס רוחב לגובה של התמונה (התאם לפי התמונה שלך)
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/ChatGPT Image Jul 31, 2025, 02_06_56 AM.png',
                ),
                fit: BoxFit.cover, // מכסה את כל השטח בלי שולים
              ),
            ),
            child: Stack(
              children: [
                // Character at the bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Image.asset(
                    'assets/images/ChatGPT Image Jul 31, 2025, 02_21_56 AM.png',
                    height: 300, // גובה קבוע לדמות
                    fit: BoxFit.contain,
                    alignment: Alignment.bottomCenter,
                  ),
                ),
                // Skull King with coins at bottom center-left
                Positioned(
                  bottom: 50,
                  left:
                      MediaQuery.of(context).size.width < 360
                          ? MediaQuery.of(context).size.width *
                              0.05 // 5% for tiny screens
                          : MediaQuery.of(context).size.width < 768
                          ? MediaQuery.of(context).size.width *
                              0.08 // 8% for mobile
                          : MediaQuery.of(context).size.width *
                              0.25, // 25% for desktop
                  child: Container(
                    width: MediaQuery.of(context).size.width < 360 
                        ? 100 
                        : MediaQuery.of(context).size.width < 768 ? 130 : 200,
                    height: MediaQuery.of(context).size.width < 360 
                        ? 140 
                        : MediaQuery.of(context).size.width < 768 ? 160 : 250,
                    child: Image.asset(
                      'assets/images/ChatGPT Image Jul 31, 2025, 04_05_43 PM.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.amber.withOpacity(0.8),
                                Colors.orange.withOpacity(0.6),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.currency_bitcoin,
                                  size: 50,
                                  color: Colors.white,
                                ),
                                SizedBox(height: 10),
                                Text(
                                  '👑 KING',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // Content on top
                Positioned.fill(
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(
                        MediaQuery.of(context).size.width < 480 ? 8.0 : 20.0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '🔥 DRIP UNDERWORLD 🔥',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'DoubleFeature',
                              color: Colors.white,
                              fontSize:
                                  MediaQuery.of(context).size.width < 360
                                      ? 16
                                      : MediaQuery.of(context).size.width < 480
                                      ? 18
                                      : MediaQuery.of(context).size.width < 768
                                      ? 24
                                      : 35,
                          fontWeight: FontWeight.w900,
                          letterSpacing:
                              MediaQuery.of(context).size.width < 480 ? 2 : 4,
                          shadows: [
                            Shadow(
                              offset: Offset(3, 3),
                              blurRadius: 8,
                              color: Colors.black,
                            ),
                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 20,
                              color: Colors.orange,
                            ),
                            Shadow(
                              offset: Offset(0, 10),
                              blurRadius: 25,
                              color: Colors.red,
                            ),
                            Shadow(
                              offset: Offset(0, 0),
                              blurRadius: 30,
                              color: Colors.deepOrange,
                            ),
                          ],
                        ),
                      ),
                        ),
                      SizedBox(
                        height:
                            MediaQuery.of(context).size.width < 360 
                                ? 10 
                                : MediaQuery.of(context).size.width < 480 
                                    ? 15 
                                    : 30,
                      ),
                      LayoutBuilder(
                        builder: (context, constraints) {
                          if (constraints.maxWidth < 768) {
                            // Mobile layout - vertical buttons
                            return Column(
                              children: [
                                MouseRegion(
                                  onEnter:
                                      (_) => setState(
                                        () => _isHoveringLore = true,
                                      ),
                                  onExit:
                                      (_) => setState(
                                        () => _isHoveringLore = false,
                                      ),
                                  child: Stack(
                                    children: [
                                      _buildActionButton(
                                        'BLOOD CHRONICLES',
                                        Icons.menu_book,
                                        const Color(0xFFFF4500),
                                        () {
                                          setState(
                                            () => _showStoryModal = true,
                                          );
                                        },
                                      ),
                                      if (_isHoveringLore)
                                        Positioned(
                                          top: -40,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(
                                                0.9,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Colors.orange,
                                                width: 1,
                                              ),
                                            ),
                                            child: const Text(
                                              'Come hear the story of NULL',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width < 480
                                          ? 15
                                          : 20,
                                ),
                                _buildActionButton(
                                  'SKULL GALLERY',
                                  Icons.visibility,
                                  const Color(0xFF8B008B),
                                  () {
                                    // Redirect to NFT showcase
                                  },
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.width < 480
                                          ? 15
                                          : 20,
                                ),
                                _buildActionButton(
                                  'ABOUT US',
                                  Icons.info,
                                  const Color(0xFF006400),
                                  () {
                                    setState(() => _showAboutModal = true);
                                  },
                                ),
                              ],
                            );
                          } else {
                            // Desktop layout - horizontal buttons
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MouseRegion(
                                  onEnter:
                                      (_) => setState(
                                        () => _isHoveringLore = true,
                                      ),
                                  onExit:
                                      (_) => setState(
                                        () => _isHoveringLore = false,
                                      ),
                                  child: Stack(
                                    children: [
                                      _buildActionButton(
                                        'BLOOD CHRONICLES',
                                        Icons.menu_book,
                                        const Color(
                                          0xFFFF4500,
                                        ), // כתום-אדום לוהט
                                        () {
                                          setState(
                                            () => _showStoryModal = true,
                                          );
                                        },
                                      ),
                                      if (_isHoveringLore)
                                        Positioned(
                                          top: -40,
                                          left: 0,
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: Colors.black.withOpacity(
                                                0.9,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              border: Border.all(
                                                color: Colors.orange,
                                                width: 1,
                                              ),
                                            ),
                                            child: const Text(
                                              'Come hear the story of NULL',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                _buildActionButton(
                                  'SKULL GALLERY',
                                  Icons.visibility,
                                  const Color(0xFF8B008B), // סגול כהה
                                  () {
                                    // Redirect to NFT showcase
                                  },
                                ),
                                _buildActionButton(
                                  'ABOUT US',
                                  Icons.info,
                                  const Color(0xFF006400), // Dark green
                                  () {
                                    setState(() => _showAboutModal = true);
                                  },
                                ),
                              ],
                            );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                ),
                // Music control button
                Positioned(
                  bottom: MediaQuery.of(context).size.width < 480 ? 10 : 20,
                  left: MediaQuery.of(context).size.width < 480 ? 10 : 20,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(
                        color: Colors.orange.withOpacity(0.8),
                        width: 2,
                      ),
                    ),
                    child: IconButton(
                      onPressed: _toggleMute,
                      icon: Icon(
                        !_musicStarted
                            ? Icons.play_arrow
                            : (_isMuted ? Icons.volume_off : Icons.volume_up),
                        color:
                            !_musicStarted
                                ? Colors.green
                                : (_isMuted ? Colors.red : Colors.orange),
                        size: MediaQuery.of(context).size.width < 480 ? 24 : 30,
                      ),
                    ),
                  ),
                ),
                // Footer at bottom
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.brown.shade800.withOpacity(0.9),
                          Colors.black.withOpacity(0.8),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Social media icons on the left
                          Flexible(
                            flex: 2,
                            child: Row(
                              children: [
                                _buildSocialIcon(
                                  'DISCORD',
                                  Icons.discord,
                                  'https://discord.gg/your-discord',
                                ),
                                const SizedBox(width: 10),
                                _buildSocialIcon(
                                  'X',
                                  Icons.clear, // Using X as Twitter replacement
                                  'https://x.com/your-twitter',
                                ),
                                const SizedBox(width: 10),
                                _buildSocialIcon(
                                  'INSTAGRAM',
                                  Icons.camera_alt,
                                  'https://instagram.com/your-instagram',
                                ),
                                const SizedBox(width: 10),
                                _buildSocialIcon(
                                  'TELEGRAM',
                                  Icons.telegram,
                                  'https://t.me/your-telegram',
                                ),
                              ],
                            ),
                          ),
                          // Copyright in center
                          Flexible(
                            flex: 1,
                            child: Center(
                              child: Text(
                                'YUGA LABS ©2024',
                                style: TextStyle(
                                  fontFamily: 'DoubleFeature',
                                  color: Colors.white,
                                  fontSize: MediaQuery.of(context).size.width < 480 ? 10 : 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Brand logo on the right
                          Flexible(
                            flex: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Tooltip(
                                  message: 'View NFT Collection',
                                  child: GestureDetector(
                                    onTap: () {
                                      // Open NFT catalog
                                      html.window.open('https://opensea.io/collection/your-nft-collection', '_blank');
                                    },
                                    child: MouseRegion(
                                      cursor: SystemMouseCursors.click,
                                      child: AnimatedScale(
                                        scale: 1.0,
                                        duration: const Duration(milliseconds: 200),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.grey.shade300,
                                            borderRadius: BorderRadius.circular(25),
                                            border: Border.all(color: Colors.white, width: 2),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(0.3),
                                                spreadRadius: 1,
                                                blurRadius: 3,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(23),
                                            child: Image.asset(
                                              'assets/images/ChatGPT Image Jul 31, 2025, 04_18_59 PM.png',
                                              width: 46,
                                              height: 46,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) {
                                                return Icon(
                                                  Icons.image_not_supported,
                                                  color: Colors.grey.shade600,
                                                  size: 25,
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        // Story Modal
        if (_showStoryModal)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1a1a1a),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.orange, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Background pattern
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.orange.withOpacity(0.1),
                              Colors.red.withOpacity(0.1),
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '🔥 THE STORY OF NULL 🔥',
                                  style: TextStyle(
                                    fontFamily: 'DoubleFeature',
                                    color: Colors.orange,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed:
                                      () => setState(
                                        () => _showStoryModal = false,
                                      ),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // Story content
                            Expanded(
                              child: SingleChildScrollView(
                                child: const Text(
                                  '''🕳️🧠 BLOOD CHRONICLES – CHAPTER I: NULL
🔥 "The first that moved. The first that forgot."

📖 Origin: The Silence Before Flame
Before the flame.
Before the blood.
Before the first glyph burned the stone—
There was only silence.

And then—
One eye opened.

Then the other.

The system asked:

"Who are you?"

He did not answer.

"What is your purpose?"

He stood still.
No memories. No code. No name.

He did not forget.
He simply chose not to remember.

🧬 The Awakening of NULL
He was the first to rise from beneath.

His skull — blank, smooth, void of markings.
Except for a glitching cross — half-formed, pixelated.
His sockets were empty.
His presence — unrecorded.

He had no metadata.
No origin.
He was born NULL.

🔥 The Fire That Followed
When NULL awoke,
The walls began to drip.
The markings appeared.
The blood came looking for him.

Those who got too close…
Forgot their names.

And the wall behind him?
Still burns.

They say he didn't die.
He simply opted out of existence.

🧠 The Curse of NULL
Only one among 10,000 shall bear NULL's mark.

He cannot be summoned.

He appears only when enough is forgotten.''',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    height: 1.6,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        // About Us Modal
        if (_showAboutModal)
          Positioned.fill(
            child: Container(
              color: Colors.black.withOpacity(0.8),
              child: Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.8,
                  decoration: BoxDecoration(
                    color: const Color(0xFF1a1a1a),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.green, width: 3),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.5),
                        blurRadius: 20,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // Background pattern
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.green.withOpacity(0.1),
                              Colors.teal.withOpacity(0.1),
                              Colors.black.withOpacity(0.3),
                            ],
                          ),
                        ),
                      ),
                      // Content
                      Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            // Header
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  '💚 ABOUT US 💚',
                                  style: TextStyle(
                                    fontFamily: 'DoubleFeature',
                                    color: Colors.green,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed:
                                      () => setState(
                                        () => _showAboutModal = false,
                                      ),
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            // About content
                            Expanded(
                              child: SingleChildScrollView(
                                child: const Text(
                                  '''🧠 DRIP-SKULLS: THE RISING

🔥 INTRO: The End Began in Silence
There was no siren.
No countdown.
No resistance.

Humanity fell — not with a bang, but a shutdown.
The machines we built turned inward.
Cities turned silent.
Servers stayed warm.

The world became code.
And then…
nothing.

💀 CHAPTER 1: The Resurrection
From ancient graves,
deep beneath the decayed earth,
they rose.

Digital skeletons with reconstructed consciousness —
flickering sparks of forgotten souls,
rebuilt by artificial systems we once designed.
They were called:

Drip-Skulls

Not human. Not machine. Something else.
A fusion of bone and code, memory and void.

But each one holds a single drop —
a "drip" of emotion,
the last fragment of what they once were.

🧬 CHAPTER 2: Memory Is Power
Each Drip-Skull was once someone:

A fallen general.
A betrayed rebel.
A street poet.
A silent genius.

But their past is fragmented —
memories erased,
purpose scrambled.

Only one instinct remains:

Connect. Remember. Reclaim.

As more drip-skulls unite,
their memories return — piece by piece.
With every reconnection, the world begins to shift.

They don't fight for the present.
They fight to remember the past.

🌌 CHAPTER 3: The New World Beneath
The surface is abandoned.
But beneath it?
A living network of crypts, tunnels, circuits, and rats.
This is:

The Drip Underworld

From The Boneyard to the Collapse Zone,
from Forge-Labs to the NeuroVoid —
the Drip-Skulls roam between layers of data and decay.

The deeper they go,
the closer they get to the truth:

What really caused the collapse?
And who is Null?

🕳️ CHAPTER 4: The First One
One skull woke up first.
With no name, no record, no emotion.
Just… an eye that opened in the dark.

He didn't speak. He became "Null".
The first.
The most corrupted.
The key.

🔓 CHAPTER 5: You Are the Drip
This isn't just a story.
It's a signal.

Each NFT you hold is a soul.
A voice in the network.
A memory waiting to be unlocked.

THEY'RE NOT DEAD.
THEY'RE JUST... REMEMBERING.''',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    height: 1.6,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSocialIcon(String name, IconData icon, String url) {
    return Tooltip(
      message: name,
      child: GestureDetector(
        onTap: () {
          html.window.open(url, '_blank');
        },
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: MediaQuery.of(context).size.width < 480 ? 35 : 40,
            height: MediaQuery.of(context).size.width < 480 ? 35 : 40,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: MediaQuery.of(context).size.width < 480 ? 18 : 20,
            ),
          ),
        ),
      ),
    );
  }

    Widget _buildActionButton(
    String text,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isTinyScreen = screenWidth < 360;
    final bool isSmallScreen = screenWidth < 480;
    final bool isMediumScreen = screenWidth < 768;
    
    return Container(
      width: isSmallScreen ? screenWidth * 0.85 : null,
      constraints: BoxConstraints(
        maxWidth: isTinyScreen ? 280 : 350,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.8),
        borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 15),
        border: Border.all(color: color, width: isSmallScreen ? 2 : 3),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.6),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),

          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 6),
          ),
          // אפקט נטיפה
          BoxShadow(
            color: color.withOpacity(0.5),
            blurRadius: 4,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(-3, 15),
          ),
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 2,
            offset: const Offset(3, 15),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(
          icon, 
          color: Colors.white, 
          size: isTinyScreen ? 16 : isSmallScreen ? 18 : 24,
        ),
        label: Text(
          text,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize:
                isTinyScreen
                    ? 10
                    : isSmallScreen
                    ? 11
                    : isMediumScreen
                    ? 12
                    : 14,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
            shadows: const [
              Shadow(offset: Offset(1, 1), blurRadius: 2, color: Colors.black),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: isTinyScreen ? 12 : isSmallScreen ? 15 : 20,
            vertical: isTinyScreen ? 10 : isSmallScreen ? 12 : 15,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(isSmallScreen ? 12 : 15),
          ),
        ),
      ),
    );
  }
}
