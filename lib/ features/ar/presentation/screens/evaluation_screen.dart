import 'package:flutter/material.dart';
import '../../../../main.dart';
import 'ar_screen.dart';
import '../widgets/gradient_app_bar.dart';
import '../widgets/confidence_score_card.dart';
import '../widgets/analysis_card.dart';
import '../widgets/ai_suggestions_card.dart';
import '../widgets/maintenance_styling_card.dart';
import '../widgets/evaluation_action_buttons.dart';

class EvaluationScreen extends StatelessWidget {
  const EvaluationScreen({Key? key}) : super(key: key);

  void _goToARScreen(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const ARScreen()),
      (route) => false,
    );
  }

  void _goToBooking(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => MainNavigation(initialIndex: 3)),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F6FF),
      body: SafeArea(
        child: Column(
          children: [
            GradientAppBar(
              onBack: () => Navigator.of(context).pop(),
              title: 'AI Evaluation',
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
                    const ConfidenceScoreCard(
                      score: '92%',
                      message: 'This style suits you very well!',
                    ),
                    const SizedBox(height: 28),
                    // Detailed Analysis
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Detailed Analysis', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                    const SizedBox(height: 14),
                    const AnalysisCard(
                      icon: Icons.check_circle,
                      iconColor: Colors.green,
                      title: 'Face Shape Match',
                      subtitle: 'Perfect for oval face shapes',
                    ),
                    const SizedBox(height: 10),
                    const AnalysisCard(
                      icon: Icons.color_lens,
                      iconColor: Color(0xFF60a5fa),
                      title: 'Color Harmony',
                      subtitle: 'Complements your skin tone beautifully',
                    ),
                    const SizedBox(height: 10),
                    const AnalysisCard(
                      icon: Icons.show_chart,
                      iconColor: Color(0xFFa78bfa),
                      title: 'Style Trend',
                      subtitle: 'Currently trending and timeless',
                    ),
                    const SizedBox(height: 28),
                    // AI Suggestions
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('AI Suggestions', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                    const SizedBox(height: 12),
                    const AiSuggestionsCard(
                      suggestion: 'Enhancement Tip\nConsider adding subtle curtain bangs to frame your face even better. This would boost your match score to 94%! ',
                    ),
                    const SizedBox(height: 24),
                    // Maintenance & Styling
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text('Maintenance & Styling', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                    ),
                    const SizedBox(height: 12),
                    MaintenanceStylingCard(
                      bullets: [
                        {'color': Colors.green, 'text': 'Low maintenance - perfect for busy lifestyles'},
                        {'color': Colors.blue, 'text': 'Works well with your natural hair texture'},
                        {'color': Colors.purple, 'text': 'Versatile for both casual and formal looks'},
                      ],
                    ),
                    const SizedBox(height: 32),
                    // Action Buttons
                    EvaluationActionButtons(
                      onTryAnother: () => _goToARScreen(context),
                      onBookNow: () => _goToBooking(context),
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