import 'package:mobx/mobx.dart';
part 'home.g.dart';

class Home = _HomeBase with _$Home;

abstract class _HomeBase with Store {
  @observable
  int selectedIndex = 1;

  @action
  void selectIndex(int index){
    selectedIndex = index;
  }
}