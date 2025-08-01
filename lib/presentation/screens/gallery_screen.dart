import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  List<dynamic> characters = [];
  List<dynamic> filteredCharacters = [];
  String selectedRarity = 'ALL';
  bool isLoading = true;
  int loadedCount = 0;

  final rarityColors = {
    'GENESIS': Color(0xFF000000),
    'LEGENDARY': Color(0xFFFFD700),
    'EPIC': Color(0xFF9932CC),
    'RARE': Color(0xFF1E90FF),
    'UNCOMMON': Color(0xFF32CD32),
    'COMMON': Color(0xFF808080),
  };

  @override
  void initState() {
    super.initState();
    loadCharacters();
  }

  Future<void> loadCharacters() async {
    try {
      final String response = await rootBundle.loadString('assets/characters.json');
      final data = json.decode(response);
      setState(() {
        characters = data;
        filteredCharacters = characters;
        isLoading = false;
        loadedCount = characters.length;
      });
    } catch (e) {
      print('Error loading characters: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void filterByRarity(String rarity) {
    setState(() {
      selectedRarity = rarity;
      if (rarity == 'ALL') {
        filteredCharacters = characters;
      } else {
        filteredCharacters = characters.where((char) => char['rarity'] == rarity).toList();
      }
      loadedCount = filteredCharacters.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0a0a0a),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1a1a2e),
              Color(0xFF16213e),
              Color(0xFF0f0e0e),
            ],
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            _buildStatsBar(),
            _buildFilters(),
            Expanded(
              child: isLoading ? _buildLoading() : _buildGallery(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back, color: Color(0xFF00ff88), size: 30),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'DRIP-SKULLS',
                    style: TextStyle(
                      fontFamily: 'DoubleFeature',
                      fontSize: 32,
                      color: Color(0xFF00ff88),
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                      shadows: [
                        Shadow(
                          offset: Offset(0, 0),
                          blurRadius: 15,
                          color: Color(0xFF00ff88),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'THE RISING',
                    style: TextStyle(
                      fontFamily: 'DoubleFeature',
                      fontSize: 16,
                      color: Color(0xFF00ff88).withOpacity(0.8),
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 50),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF00ff88).withOpacity(0.05),
        border: Border.all(color: Color(0xFF00ff88).withOpacity(0.2)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('Total Entities', '164'),
          _buildStatItem('Awakened', '$loadedCount'),
          _buildStatItem('Selected', selectedRarity),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontFamily: 'DoubleFeature',
            fontSize: 24,
            color: Color(0xFF00ff88),
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                offset: Offset(0, 0),
                blurRadius: 10,
                color: Color(0xFF00ff88).withOpacity(0.5),
              ),
            ],
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey,
            letterSpacing: 0.1,
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 20),
        children: [
          _buildFilterChip('ALL', 'ALL'),
          _buildFilterChip('GENESIS', 'GENESIS'),
          _buildFilterChip('LEGENDARY', 'LEGENDARY'),
          _buildFilterChip('EPIC', 'EPIC'),
          _buildFilterChip('RARE', 'RARE'),
          _buildFilterChip('UNCOMMON', 'UNCOMMON'),
          _buildFilterChip('COMMON', 'COMMON'),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String rarity) {
    bool isSelected = selectedRarity == rarity;
    Color chipColor = rarity == 'ALL' ? Color(0xFF00ff88) : (rarityColors[rarity] ?? Color(0xFF00ff88));
    
    return GestureDetector(
      onTap: () => filterByRarity(rarity),
      child: Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? chipColor.withOpacity(0.2) : Colors.black.withOpacity(0.7),
          border: Border.all(
            color: chipColor,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(25),
          boxShadow: isSelected ? [
            BoxShadow(
              color: chipColor.withOpacity(0.3),
              blurRadius: 10,
              offset: Offset(0, 0),
            ),
          ] : null,
        ),
        child: Text(
          label,
          style: TextStyle(
            color: chipColor,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 14,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF00ff88)),
            strokeWidth: 3,
          ),
          SizedBox(height: 20),
          Text(
            'INITIALIZING CONSCIOUSNESS...',
            style: TextStyle(
              fontFamily: 'DoubleFeature',
              color: Color(0xFF00ff88),
              fontSize: 16,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGallery() {
    return GridView.builder(
      padding: EdgeInsets.all(20),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 1200 ? 4 : 
                       MediaQuery.of(context).size.width > 800 ? 3 : 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        childAspectRatio: 0.75,
      ),
      itemCount: filteredCharacters.length,
      itemBuilder: (context, index) {
        final character = filteredCharacters[index];
        return _buildCharacterCard(character, index);
      },
    );
  }

  Widget _buildCharacterCard(dynamic character, int index) {
    Color rarityColor = rarityColors[character['rarity']] ?? Color(0xFF00ff88);
    
    return GestureDetector(
      onTap: () => _showCharacterModal(character),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300 + (index * 50)),
        curve: Curves.easeOut,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          border: Border.all(color: rarityColor.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: rarityColor.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image container
            Expanded(
              flex: 3,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  color: Color(0xFF00ff88).withOpacity(0.05),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/${character['image_path']}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade800,
                            child: Icon(
                              Icons.image_not_supported,
                              color: Colors.grey,
                              size: 50,
                            ),
                          );
                        },
                      ),
                      // Rarity badge
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: rarityColor.withOpacity(0.9),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: rarityColor),
                          ),
                          child: Text(
                            character['rarity'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // Info container
            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character['name'] ?? 'Unknown',
                      style: TextStyle(
                        fontFamily: 'DoubleFeature',
                        color: Color(0xFF00ff88),
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      character['catalog_number'] ?? '',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      character['title'] ?? '',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Spacer(),
                    // Traits preview
                    if (character['traits'] != null && character['traits'].length > 0)
                      Wrap(
                        spacing: 4,
                        children: (character['traits'] as List).take(2).map<Widget>((trait) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: Color(0xFF00ff88).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Color(0xFF00ff88).withOpacity(0.2),
                              ),
                            ),
                            child: Text(
                              trait['value']?.toString() ?? '',
                              style: TextStyle(
                                color: Color(0xFF00ff88),
                                fontSize: 8,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCharacterModal(dynamic character) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.9),
      builder: (BuildContext context) {
        Color rarityColor = rarityColors[character['rarity']] ?? Color(0xFF00ff88);
        
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              color: Color(0xFF1a1a1a),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: rarityColor, width: 2),
              boxShadow: [
                BoxShadow(
                  color: rarityColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: rarityColor.withOpacity(0.1),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              character['name'] ?? 'Unknown',
                              style: TextStyle(
                                fontFamily: 'DoubleFeature',
                                color: rarityColor,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${character['catalog_number']} • ${character['title']}',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.close, color: Colors.white, size: 30),
                      ),
                    ],
                  ),
                ),
                // Content
                Expanded(
                  child: Row(
                    children: [
                      // Image
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: rarityColor.withOpacity(0.3)),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.asset(
                              'assets/${character['image_path']}',
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: Colors.grey.shade800,
                                  child: Icon(
                                    Icons.image_not_supported,
                                    color: Colors.grey,
                                    size: 100,
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      // Details
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (character['backstory'] != null) ...[
                                Text(
                                  'Backstory',
                                  style: TextStyle(
                                    color: rarityColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  character['backstory'],
                                  style: TextStyle(
                                    color: Colors.white70,
                                    fontSize: 14,
                                    height: 1.5,
                                  ),
                                ),
                                SizedBox(height: 20),
                              ],
                              Text(
                                'Traits',
                                style: TextStyle(
                                  color: rarityColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: character['traits']?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    final trait = character['traits'][index];
                                    return Container(
                                      margin: EdgeInsets.only(bottom: 8),
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Color(0xFF00ff88).withOpacity(0.05),
                                        border: Border.all(
                                          color: Color(0xFF00ff88).withOpacity(0.2),
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            trait['trait_type'] ?? '',
                                            style: TextStyle(
                                              color: Colors.grey,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            trait['value']?.toString() ?? '',
                                            style: TextStyle(
                                              color: Color(0xFF00ff88),
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}