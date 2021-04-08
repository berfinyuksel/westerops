class SearchedLocations {
  final String? description;
  final String? placeId;

  SearchedLocations({this.description, this.placeId});

  factory SearchedLocations.fromJson(Map<String, dynamic> json) {
    return SearchedLocations(description: json['description'], placeId: json['place_id']);
  }
}
