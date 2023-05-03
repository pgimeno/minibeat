//Classe model per fer insert de Hunted
import 'package:minibeat/models/player.dart';

import 'artifact.dart';

class Hunted {
  final int? Id;
  final int UserId;
  final int ArtifactId;
  final int ArtifactImageNumber;
  final int PointsGained;


  Hunted(
      {this.Id,
      required this.UserId,
      required this.ArtifactId,
      required this.ArtifactImageNumber,
      required this.PointsGained});

  Hunted.empty()
      : Id = 0,
        UserId = 0,
        ArtifactId = 0,
        ArtifactImageNumber = 0,
        PointsGained = 0;

  Map<String, dynamic> toJson() {
    return {
      //Id ??? donara problemes no passarli el json?
      'UserId': UserId,
      'ArtifactId': ArtifactId,
      'ArtifactImageNumber': ArtifactImageNumber,
      'PointsGained': PointsGained
    };
  }

  @override
  String toString() {
    return 'Hunted{Id: $Id, UserId: $UserId, ArtifactId: $ArtifactId, ArtifactImageNumber: $ArtifactImageNumber, PointsGained: $PointsGained}';
  }
}
