class Info {
  final List<String> regulations;
  final String link;
  Info({
    required this.regulations,
    required this.link,
  });

  factory Info.fromMap({required Map<String, dynamic> data}) {
    return Info(
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
