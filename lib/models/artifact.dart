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

  Artifact.empty()
      : Id = 0,
        ImageNumber = 0,
        Points = 0,
        Latitude = 0,
        Longitude = 0;

  factory Artifact.fromJson(Map<String, dynamic> json) {
    return Artifact(
        Id: json['id'],
        ImageNumber: json['imageNumber'],
        Points: json['points'],
        Latitude: json['latitude'],
        Longitude: json['longitude']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': Id,
      'imageNumber': ImageNumber,
      'points': Points,
      'latitude': Latitude,
      'longitude': Longitude,
    };
  }
}
