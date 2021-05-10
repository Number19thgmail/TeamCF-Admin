String showPoints(int points) {
  // Функция изменения склонения слова "N очков"
  return points.toString() +
      ' ' +
      ((points % 10 == 1 && points ~/ 10 != 1)
          ? 'очко'
          : ((points - 1) % 10 - 4 < 0 && points ~/ 10 != 1)
              ? 'очка'
              : 'очков');
}

String showGoals(int goals) {
  // Функция изменения склонения слова "N забытых"
  return goals.toString() +
      ' ' +
      ((goals % 10 == 1 && goals ~/ 10 != 1) ? 'забитый' : 'забитых');
}
