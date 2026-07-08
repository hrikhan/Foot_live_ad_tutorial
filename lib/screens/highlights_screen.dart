import 'package:flutter/material.dart';

import '../models/highlight_model.dart';

class HighlightsScreen extends StatelessWidget {
  const HighlightsScreen({super.key});

  List<HighlightModel> get _highlights => [
        HighlightModel(
          id: '1',
          title: 'Barcelona vs Real Madrid - El Clásico Highlights',
          thumbnail: '',
          duration: '10:25',
          league: 'La Liga',
          date: 'Today',
        ),
        HighlightModel(
          id: '2',
          title: 'Man City vs Liverpool - All Goals & Extended',
          thumbnail: '',
          duration: '12:40',
          league: 'Premier League',
          date: 'Today',
        ),
        HighlightModel(
          id: '3',
          title: 'Bayern Munich vs Dortmund - Der Klassiker',
          thumbnail: '',
          duration: '8:15',
          league: 'Bundesliga',
          date: 'Yesterday',
        ),
        HighlightModel(
          id: '4',
          title: 'PSG vs Marseille - Le Classique Goals',
          thumbnail: '',
          duration: '9:50',
          league: 'Ligue 1',
          date: 'Yesterday',
        ),
        HighlightModel(
          id: '5',
          title: 'Juventus vs AC Milan - Serie A Best Moments',
          thumbnail: '',
          duration: '11:30',
          league: 'Serie A',
          date: '2 days ago',
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            children: [
              Icon(Icons.play_circle_fill, color: Colors.greenAccent, size: 28),
              SizedBox(width: 10),
              Text(
                'Highlights',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Highlight cards
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _highlights.length,
            itemBuilder: (context, index) {
              final highlight = _highlights[index];
              return _buildHighlightCard(highlight);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildHighlightCard(HighlightModel highlight) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail placeholder
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: Color(0xFF2A2A3E),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.sports_soccer,
                    size: 64,
                    color: Colors.white24,
                  ),
                ),
                // Play button overlay
                Center(
                  child: Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withValues(alpha: 0.9),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.black,
                      size: 36,
                    ),
                  ),
                ),
                // Duration badge
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      highlight.duration,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                // League badge
                Positioned(
                  top: 8,
                  left: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.greenAccent.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.greenAccent.withValues(alpha: 0.5)),
                    ),
                    child: Text(
                      highlight.league,
                      style: const TextStyle(
                        color: Colors.greenAccent,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  highlight.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  highlight.date,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
