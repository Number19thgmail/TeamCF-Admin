import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:team_c_f/data/info.dart';
import 'package:team_c_f/servises/login.dart';
import 'package:team_c_f/store/selectteam/selectteam.dart';

part 'login.g.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

class Login = LoginBase with _$Login;

abstract class LoginBase with Store {
  LoginBase() {
    googleLogin();
    initInfo();
  }
  @observable
  Info? info;

  @action
  void initInfo(){
    LoginService().getInfo().then((Info value) => info = value);
  }

  String userId = '';

  @observable
  String userName = '';

  @action
  void changeName(String text) {
    userName = text.trim();
  }

  final selectTeam = SelectTeam();

  @observable
  bool registrateInApp = false;

  @observable
  ObservableFuture<bool> loginStatus = ObservableFuture<bool>.value(false);

  @action
  void changeLoginStatus(dynamic status) {
    loginStatus = status;
  }

  @computed
  bool get updatedLoginStatus => loginStatus.value!;

  @action
  Future<bool> googleLogin() async {
    GoogleSignInAccount gUser = await getGoogleUser();
    GoogleSignInAuthentication googAuth = await gUser.authentication;
    User? user;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googAuth.idToken,
      accessToken: googAuth.accessToken,
    );
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    user = userCredential.user;

    if (user != null) {
      loginStatus = ObservableFuture.value(true);
      userId = user.uid;
      validateInApp();
    } else {
      loginStatus = ObservableFuture.value(false);
      userId = '';
      registrateInApp = false;
    }
    return Future.value(true);
  }

  @action
  Future<bool> googleLogout() async {
    _googleSignIn.signOut();
    _auth.signOut();
    loginStatus = ObservableFuture.value(false);
    userId = '';
    registrateInApp = false;
    return await Future.value(true);
  }

  @action
  Future validateInApp() async {
    registrateInApp = await   LoginService().existPlayer(uid: userId);
  }

  Future getGoogleUser() async {
    GoogleSignInAccount? googleUser = _googleSignIn.currentUser;
    if (googleUser == null) {
      googleUser = await _googleSignIn.signInSilently();
    }
    if (googleUser == null) {
      googleUser = await _googleSignIn.signIn();
    }
    return googleUser;
  }

  @action
  void clearData(){
    userName = '';
    selectTeam.lastTeamName = '';
    selectTeam.teamName = '';
    selectTeam.uName = '';
    selectTeam.selectedTeam = null;
  }

  void setDataToSelectTeam({
    required String buttonText,
  }) {
    selectTeam.uId = userId;
    selectTeam.uName = userName;
    selectTeam.regButtonText = buttonText;
  }
}
