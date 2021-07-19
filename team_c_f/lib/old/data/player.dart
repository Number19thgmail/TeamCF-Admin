class Player {
  // Информация об участнике
  late String docId; // Идентификатор документа с информацией об участнике
  final String name; // Имя и фамилия участника
  late String uid; // Идентификатор Google-аккаунта участника
  bool capitan; // Флаг капитана
  bool confirmed; // Флаг подтверждения участия в команде
  String team; // Название команды
  int position; // Позиция в списке бомбардиров
  int points; // Количество набранных очков

  Player({
    // Конструктор
    required this.name,
    required String uid,
    required this.capitan,
    required this.team,
    required this.confirmed,
    this.points = 0,
    this.position = 1,
  }) {
    this.uid = uid;
  }

  factory Player.fromJson({required Map<String, dynamic> json, required String docId}) {
    // Именованный конструктор для десериализации
    Player p = Player(
      name: json['Name'],
      uid: json['UserId'],
      capitan: json['Capitan'] as bool,
      team: json['Team'],
      confirmed: json['Confirmed'] as bool,
      position: int.parse(json['Position']),
      points: int.parse(json['Points']),
    );
    p.docId = docId;
    return p;
  }

  Map<String, dynamic> toMap() {
    // Функция для сериализации
    return {
      'Name': name,
      'UserId': uid,
      'Capitan': capitan,
      'Team': team,
      'Confirmed': confirmed,
      'Position': position.toString(),
      'Points': points.toString(),
    };
  }
}
