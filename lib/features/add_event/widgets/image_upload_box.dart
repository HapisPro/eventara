import 'dart:io';

import 'package:flutter/material.dart';

class ImageUploadBox extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;
  final String placeholderText;
  final double height;

  const ImageUploadBox({
    super.key,
    required this.image,
    required this.onTap,
    this.placeholderText = "Upload Gambar",
    this.height = 180,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              theme.colorScheme.primary,
              theme.colorScheme.primary.withOpacity(0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: image == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 48,
                      color: theme.colorScheme.onPrimary,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      placeholderText,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: theme.colorScheme.onPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.file(
                      image!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
