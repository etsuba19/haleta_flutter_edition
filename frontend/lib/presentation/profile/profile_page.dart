import 'package:flutter/material.dart';
import '../core/widgets/SidebarDrawer.dart';
import 'profile_widgets.dart';

class ProfileScreen extends StatefulWidget {
  final void Function(String) onDrawerItemClick;
  final VoidCallback onBackClick;
  final String currentPage;

  const ProfileScreen({
    super.key,
    required this.onDrawerItemClick,
    required this.onBackClick,
    required this.currentPage,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isDrawerOpen = false;

  void closeDrawer() {
    setState(() => isDrawerOpen = false);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/bgimg.jpg', fit: BoxFit.cover),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Menu Button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.menu, color: Colors.white),
                      onPressed: () => setState(() => isDrawerOpen = true),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Icon(Icons.account_circle, size: 150, color: Color.fromARGB(255, 240, 221, 224)),
                const SizedBox(height: 24),
                const Text("ሰላማዊት", style: TextStyle(fontSize: 36, color: Colors.white)),
                const SizedBox(height: 16),
                EditProfileButton(),
                const SizedBox(height: 26),
                ArchiveButton(),
                const SizedBox(height: 8),
                FavoriteButton(),
                const Spacer(),
                Image.asset('assets/images/logoimg.jpg', width: 170, height: 170),
                const SizedBox(height: 10),
                LogoutButton(onPressed: widget.onBackClick),
              ],
            ),
          ),
        ),
        if (isDrawerOpen) ...[
          GestureDetector(
            onTap: closeDrawer,
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          SidebarDrawer(
            items: const ["ጥያቄ - ፈተና ክብደት", "መለያ", "የፈተና ማህደር", "ንባብ"],
            onItemClick: (item) {
              closeDrawer();
              if (item != widget.currentPage) {
                widget.onDrawerItemClick(item);
              }
            },
            onClose: closeDrawer,
          ),
        ],
      ],
    );
  }
}
