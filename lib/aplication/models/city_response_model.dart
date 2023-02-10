class CityResponse {
  int? id;
  String? slug;
  String? citySlug;
  String? display;
  String? asciiDisplay;
  String? cityName;
  String? cityAsciiName;
  String? state;
  String? country;
  String? lat;
  String? long;
  String? resultType;
  String? popularity;
  double? sortCriteria;

  CityResponse(
      {this.id,
      this.slug,
      this.citySlug,
      this.display,
      this.asciiDisplay,
      this.cityName,
      this.cityAsciiName,
      this.state,
      this.country,
      this.lat,
      this.long,
      this.resultType,
      this.popularity,
      this.sortCriteria});

  CityResponse fromJson(Map<dynamic, dynamic> json) => CityResponse(
      id: json['id'],
      slug: json['slug'],
      citySlug: json['city_slug'],
      display: json['display'],
      asciiDisplay: json['ascii_display'],
      cityName: json['city_name'],
      cityAsciiName: json['city_ascii_name'],
      state: json['state'],
      country: json['country'],
      lat: json['lat'],
      long: json['long'],
      resultType: json['result_type'],
      popularity: json['popularity'],
      sortCriteria: json['sort_criteria']);
}
