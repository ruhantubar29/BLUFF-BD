import 'package:flutter/material.dart';

class GameCard extends StatelessWidget {
  final String title;
  final String description;
  final String? imagePath;
  final VoidCallback? onTap;

  const GameCard({
    super.key,
    required this.title,
    required this.description,
    this.imagePath,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.surface,
            boxShadow: [
              BoxShadow(
                blurRadius: 12,
                offset: const Offset(0, 5),
                color: Colors.black.withValues(alpha: 0.12),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              Expanded(
                child: imagePath != null
                    ? Image.asset(
                        imagePath!,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : const Center(
                        child: Icon(
                          Icons.games,
                          size: 50,
                        ),
                      ),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                      ),
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