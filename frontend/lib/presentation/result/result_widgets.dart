import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'result_page.dart';

Widget buildBackground() {
  return Positioned.fill(
    child: Image.asset(
      'assets/images/background.png',
      fit: BoxFit.cover,
    ),
  );
}

Widget buildResultBody(BuildContext context, ResultScreen widget, void Function(void Function()) setState) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    child: Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Center(
            child: Image.asset(
              'assets/images/logo.png',
              width: 180,
              height: 180,
            ),
          ),
        ),
        const SizedBox(height: 40),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 32),
          decoration: BoxDecoration(
            color: const Color(0xFFFFECEC),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: Text(
            '${widget.score} / ${widget.total}',
            style: const TextStyle(
              fontSize: 24,
              color: Color(0xFF7C1626),
            ),
          ),
        ),
        const SizedBox(height: 45),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFFF8DDE0),
            borderRadius: BorderRadius.circular(25),
          ),
          alignment: Alignment.center,
          child: const Text(
            'እርማት',
            style: TextStyle(
              fontSize: 20,
              color: Color(0xFF7C1626),
            ),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          decoration: BoxDecoration(
            color: const Color(0xFFFFECEC),
            borderRadius: BorderRadius.circular(20),
          ),
          alignment: Alignment.center,
          child: const Text(
            'እርሱ ብሎ ውእቱ ካለ እርሷ ብሎ ____    መልስ፡ ይእቲ',
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF7C1626),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 80),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF8DDE0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () => GoRouter.of(context).go('/category'),
                  child: const Text(
                    'ደግመህ ውሰድ',
                    style: TextStyle(color: Color(0xFF7C1626)),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 25),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF8DDE0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: widget.onNextClick,
                  child: const Text(
                    'ጨርስ',
                    style: TextStyle(color: Color(0xFF7C1626)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

