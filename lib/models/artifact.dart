class Artifact {
  final int Id;
  final int ImageNumber;
  final int Points;
  final double Latitude;
  final double Longitude;

  Artifact({
    required this.Id,
    required this.ImageNumber,
    required this.Points,
    required this.Latitude,
    required this.Longitude,

  });

  factory Artifact.fromJson(Map<String, dynamic> json) {
    return Artifact(
      Id: json['Id'],
      ImageNumber: json['ImageNumber'],
      Points: json['Points'],
      Latitude: json['Latitude'],
      Longitude: json['Longitude']

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': Id,
      'ImageNumber' : ImageNumber,
      'Points' : Points,
      'Latitude' : Latitude,
      'Longitude' : Longitude
    };
  }
}