import 'package:flutter/material.dart';
import '../core/widgets/SidebarDrawer.dart';
import '../core/widgets/option_card.dart';
import 'category_widgets.dart';
import 'category_controller.dart';

class CategoryPage extends StatefulWidget {
  final VoidCallback onDifficultySelected;
  final void Function(String) onDrawerItemClick;
  final String currentPage;
  const CategoryPage({
    super.key,
    required this.onDifficultySelected,
    required this.onDrawerItemClick,
    required this.currentPage,
  });

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool isDrawerOpen = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            'assets/images/bgimg.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.menu, size: 28, color: Colors.white),
              onPressed: () => setState(() => isDrawerOpen = true),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal:16, vertical: 12),
            child: Column(
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Image.asset(
                    'assets/images/logoimg.jpg',
                    width: 180,
                    height: 180,
                  ),
                ),
                const SizedBox(height: 40),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: OptionCard(
                    title: 'ጀማሪ',
                    subtitle: '3 ጥያቄ * 3 ደቂቃ',
                    onClick: widget.onDifficultySelected,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: OptionCard(
                    title: 'መካከለኛ',
                    subtitle: '3 ጥያቄ * 3 ደቂቃ',
                    onClick: widget.onDifficultySelected,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: OptionCard(
                    title: 'አዋቂ',
                    subtitle: '3 ጥያቄ * 3 ደቂቃ',
                    onClick: widget.onDifficultySelected,
                  ),
                ),

                const Spacer(),
                buildBackButton(context),
                const SizedBox(height: 26),
              ],
            ),
          ),
        ),

        if (isDrawerOpen)
          SidebarDrawer(
            items: const ["ጥያቄ - ፈተና ክብደት", "መለያ", "የፈተና ማህደር", "ንባብ"],
            onItemClick: (item) {
              setState(() => isDrawerOpen = false);

              if (item != widget.currentPage) {
                widget.onDrawerItemClick(item);
              }
            },
            onClose: () {
              setState(() => isDrawerOpen = false);
            },
          ),

      ],
    );
  }
}
