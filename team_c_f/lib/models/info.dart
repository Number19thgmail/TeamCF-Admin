class InfoData {
  final List<String> regulations;
  final String link;
  InfoData({
    required this.regulations,
    required this.link,
  });

  factory InfoData.fromMap({required Map<String, dynamic> data}) {
    return InfoData(
      link: data['Link'],
      regulations: [...data['Regulations']],
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'Link': link,
      'Regulations': regulations,
    };
  }
}
