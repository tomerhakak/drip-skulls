import 'package:drip_skulls/presentation/widgets/hero_section.dart';
import 'package:drip_skulls/presentation/widgets/transition_section.dart';
import 'package:drip_skulls/presentation/widgets/underworld_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: _scrollController,
        children: [
          HeroSection(scrollController: _scrollController),
          const TransitionSection(),
          const UnderworldSection(),
        ],
      ),
    );
  }
}
