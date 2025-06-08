import 'package:flutter/material.dart';

class OptionCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onClick;

  const OptionCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.onClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        color: const Color.fromARGB(255, 240, 221, 224),
        elevation: 4,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onClick,
          child: Padding(
            padding: const EdgeInsets.all(16), // Slightly increased padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
