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
      Id: json['id'],
      ImageNumber: json['imageNumber'],
      Points: json['points'],
      Latitude: json['latitude'],
      Longitude: json['longitude']

    );
  }

}