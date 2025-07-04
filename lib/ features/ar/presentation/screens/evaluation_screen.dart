import 'package:flutter/material.dart';
import '../../../../main.dart';
import 'ar_screen.dart';


class EvaluationScreen extends StatelessWidget {
  const EvaluationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FF),
      body: SafeArea(
        child: Column(
          children: [
            // Gradient App Bar
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFa78bfa), Color(0xFFf472b6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
                  const Text('AI Evaluation', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22)),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 16),
                    // Icon and Title
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(colors: [Color(0xFFa78bfa), Color(0xFFf472b6)]),
                      ),
                      padding: const EdgeInsets.all(18),
                      child: const Icon(Icons.flash_on, color: Colors.white, size: 36),
                    ),
                    const SizedBox(height: 18),
                    const Text('AI Evaluation Results', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                    const SizedBox(height: 8),
                    const Text(
                      "Here's what our AI thinks about this look",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    // Confidence Score
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 28),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.06),
                            blurRadius: 16,
                            offset: const Offset(0, 6),
                          ),
                        ],
                      ),
                      child: Column(
                        children: const [
                          Text('92%', style: TextStyle(color: Color(0xFFa21caf), fontWeight: FontWeight.bold, fontSize: 44)),
                          SizedBox(height: 8),
                          Text('Confidence Score', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          SizedBox(height: 4),
                          Text('This style suits you very well!', style: TextStyle(color: Colors.black54)),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),
                    // Detailed Analysis
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Detailed Analysis', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                    const SizedBox(height: 14),
                    _AnalysisCard(
                      icon: Icons.check_circle,
                      iconColor: Colors.green,
                      title: 'Face Shape Match',
                      subtitle: 'Perfect for oval face shapes',
                    ),
                    const SizedBox(height: 10),
                    _AnalysisCard(
                      icon: Icons.color_lens,
                      iconColor: Color(0xFF60a5fa),
                      title: 'Color Harmony',
                      subtitle: 'Complements your skin tone beautifully',
                    ),
                    const SizedBox(height: 10),
                    _AnalysisCard(
                      icon: Icons.show_chart,
                      iconColor: Color(0xFFa78bfa),
                      title: 'Style Trend',
                      subtitle: 'Currently trending and timeless',
                    ),
                    const SizedBox(height: 28),
                    // AI Suggestions
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('AI Suggestions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFBEA),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFFFF3CD)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Icon(Icons.tips_and_updates, color: Color(0xFFFFC107)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Enhancement Tip\nConsider adding subtle curtain bangs to frame your face even better. This would boost your match score to 94%! ',
                              style: TextStyle(color: Color(0xFF856404)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Maintenance & Styling
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Maintenance & Styling', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _StyledBullet(color: Colors.green, text: 'Low maintenance - perfect for busy lifestyles'),
                          SizedBox(height: 8),
                          _StyledBullet(color: Colors.blue, text: 'Works well with your natural hair texture'),
                          SizedBox(height: 8),
                          _StyledBullet(color: Colors.purple, text: 'Versatile for both casual and formal looks'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (_) => const ARScreen()),
                                    (route) => false,
                              );
                            },
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              side: const BorderSide(color: Color(0xFFE0E0E0)),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Try Another', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87)),
                          ),
                        ),
                        const SizedBox(width: 18),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(builder: (_) => MainNavigation(initialIndex: 3)),
                                    (route) => false,
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 18),
                              backgroundColor: const Color(0xFFa78bfa),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: const Text('Book Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AnalysisCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  const _AnalysisCard({required this.icon, required this.iconColor, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 28),
          const SizedBox(width: 14),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 2),
              Text(subtitle, style: const TextStyle(color: Colors.black54)),
            ],
          ),
        ],
      ),
    );
  }
}

class _StyledBullet extends StatelessWidget {
  final Color color;
  final String text;
  const _StyledBullet({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(child: Text(text, style: const TextStyle(fontSize: 15))),
      ],
    );
  }
}