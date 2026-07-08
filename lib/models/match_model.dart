class MatchModel {
  final String id;
  final String homeTeam;
  final String awayTeam;
  final String homeFlag;
  final String awayFlag;
  final int homeScore;
  final int awayScore;
  final String matchTime;
  final String league;
  final bool isLive;

  MatchModel({
    required this.id,
    required this.homeTeam,
    required this.awayTeam,
    required this.homeFlag,
    required this.awayFlag,
    required this.homeScore,
    required this.awayScore,
    required this.matchTime,
    required this.league,
    required this.isLive,
  });
}
