import 'package:flutter/material.dart';

class GlassyIconButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final double width;
  final bool isDanger;

  const GlassyIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
    this.width = 165,
    this.isDanger = false,
  });

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isDanger
        ? const Color(0x5C330000) // rouge foncé translucide
        : const Color(0x5C001931); // bleu foncé translucide

    final borderColor = isDanger
        ? const Color(0xFFFF8888) // rouge clair
        : const Color(0xFFA1E3FD); // bleu clair

    final iconColor = isDanger ? Colors.redAccent : Colors.white;

    return SizedBox(
      width: width,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon, size: 20, color: iconColor),
        label: Text(
          label,
          style: TextStyle(
            fontFamily: 'Orbitron',
            fontSize: 12,
            color: iconColor,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: iconColor,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: borderColor, width: 2),
          ),
          shadowColor: isDanger
              ? Colors.red.withOpacity(0.4)
              : Colors.blue.withOpacity(0.4),
          elevation: 5,
        ),
      ),
    );
  }
}
