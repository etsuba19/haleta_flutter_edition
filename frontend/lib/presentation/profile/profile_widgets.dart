import 'package:flutter/material.dart';

class EditProfileButton extends StatelessWidget {
  const EditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 56.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: const Text(
          "መገለጫዎን ይቀይሩ",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}

class ArchiveButton extends StatelessWidget {
  const ArchiveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 240, 221, 224),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // minimumSize: const Size(double.infinity, 44),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("▅ ▇ ▃", style: TextStyle(fontSize: 12, color: Color(0xFF7C1626))),
            SizedBox(width: 16),
            Text("የፈተና ማህደር", style: TextStyle(fontSize: 18, color: Color(0xFF7C1626))),
          ],
        ),
      ),
    );
  }
}

class FavoriteButton extends StatelessWidget {
  const FavoriteButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 240, 221, 224),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          // minimumSize: const Size(double.infinity, 44),
        ),
        child: const Text(
          "🖤 የተመረጡ ፈተናዎች",
          style: TextStyle(fontSize: 18, color: Color(0xFF7C1626)),
        ),
      ),
    );
  }
}

class LogoutButton extends StatelessWidget {
  final VoidCallback onPressed;
  const LogoutButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 240, 221, 224),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: const Text(
        "ከመለያ ውጣ",
        style: TextStyle(fontSize: 16, color: Color(0xFF7C1626)),
      ),
      )
    );
  }
}


