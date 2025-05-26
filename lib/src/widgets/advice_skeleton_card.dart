import 'package:flutter/material.dart';

class AdviceSkeletonCard extends StatelessWidget {
  const AdviceSkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(16),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Row(
          children: [
            // círculo gris para el icono
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(22),
              ),
            ),
            const SizedBox(width: 12),
            // barras grises para título y subtítulo
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 14,
                    width: double.infinity,
                    color: Colors.grey.shade300,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    height: 12,
                    width: 120,
                    color: Colors.grey.shade300,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
