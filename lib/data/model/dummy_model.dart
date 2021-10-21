class Search {
  final int id;
  final String restaurant;
  final String meal;
  final String urlImage;

  const Search({
    required this.id,
    required this.meal,
    required this.restaurant,
    required this.urlImage,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        id: json['id'],
        meal: json['meal'],
        restaurant: json['restaurant'],
        urlImage: json['urlImage'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'restaurant': restaurant,
        'meal': meal,
        'urlImage': urlImage,
      };
}
