//Classe model per fer insert de Hunted
import 'package:minibeat/models/player.dart';

import 'artifact.dart';

class Hunted {
  final int? Id;
  final int UserId;
  final int ArtifactId;
  final int ArtifactImageNumber;
  final int PointsGained;
  final Player User;
  final Artifact ArtifactHunted;

  Hunted(
      {this.Id,
      required this.UserId,
      required this.ArtifactId,
      required this.ArtifactImageNumber,
      required this.PointsGained,
      required this.User,
      required this.ArtifactHunted});

  Hunted.empty()
      : Id = 0,
        UserId = 0,
        ArtifactId = 0,
        ArtifactImageNumber = 0,
        PointsGained = 0,
        ArtifactHunted = Artifact.empty(),
        User = Player.empty();

  Map<String, dynamic> toJson() {
    return {
      //Id ??? donara problemes no passarli el json?
      'UserId': UserId,
      'ArtifactId': ArtifactId,
      'ArtifactImageNumber': ArtifactImageNumber,
      'PointsGained': PointsGained,
      'User': User.toJson(),
      'ArtifactI': ArtifactHunted.toJson()
    };
  }

  @override
  String toString() {
    return 'Hunted{Id: $Id, UserId: $UserId, ArtifactId: $ArtifactId, ArtifactImageNumber: $ArtifactImageNumber, PointsGained: $PointsGained}';
  }
}
