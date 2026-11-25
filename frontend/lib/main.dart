import 'package:bridgewearaa/controlleur/productcontrolleur.dart';
import 'package:bridgewearaa/controlleur/usercontrolleur.dart';
import 'package:bridgewearaa/models/user.dart';
import 'package:bridgewearaa/screens/Command%20Confirmation.dart';
import 'package:bridgewearaa/screens/MenuLivreur.dart';
import 'package:bridgewearaa/screens/accueil.dart';
import 'package:bridgewearaa/screens/buyproduct.dart';
import 'package:bridgewearaa/screens/introScreen.dart';
import 'package:bridgewearaa/screens/loadingscreen.dart';
import 'package:bridgewearaa/screens/signup.dart';
import 'package:bridgewearaa/services/data.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(  ChangeNotifierProvider(
    create: (context) => DataService(),
    child: MyApp(),
  ),);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return

      MultiProvider(
          providers: [
            ChangeNotifierProvider<DataService>(
              create: (_) => DataService(),
            ),
          ],
          child:
          MaterialApp.router(
            debugShowCheckedModeBanner: false,

            routerConfig: router,
          )

      );

  }
}
GoRouter router=GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/',builder:(context,state){
        return SplashScreen();
      }),
      GoRoute(path: '/login',builder:(context,state){
        return logiun();

      }),
      GoRoute(path: '/buyproduct/:idprd/:bl',builder:(context,state){
        final idprd1 = state.pathParameters['idprd'];
        final bl=state.pathParameters['bl'];
        return buyproduct(idprd: idprd1!,addcmd: bl,);

      }),
      GoRoute(path: '/accueil/:token',builder:(context,state){
        final token = state.pathParameters['token'];

        return accueil(token: token,);

      }),
      GoRoute(path: '/menulivreur/:token',builder:(context,state){
        final token = state.pathParameters['token'];

        return MenuLivreur(token: token,);

      }),
      GoRoute(path: '/commandconfirmation',builder:(context,state){
        return commandconfirmation();

      }),
      GoRoute(path: '/signup',builder:(context,state){
        return signupscroll();

      })

    ]);
class RightToLeftRoute<T> extends PageRouteBuilder<T> {
  final Widget child;

  RightToLeftRoute(this.child)
      : super(
    pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        ) {
      return child;
    },
    transitionsBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child,
        ) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPreferences? _prefs;
  User? _user;
  String? _token;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadSharedPreferences();
  }

  Future<void> _loadSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');

      if (token != null) {
        _token = token;
        await getuserbytoken(token, (user) {
          setState(() {
            _user = user;
            _isLoading = false;
          });
        }).then((value) =>
        {
          getProductliked((user) {
            setState(() {
              context
                  .read<DataService>()
                  .listproductliked = user;
            });
            setState(() {
              _isLoading = false;
            });
          }, _user!.id)

        });} else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return loadingscreen();
    } else if (_error != null) {
      return introscreen();
    } else {
      if (_token != null) {
        if (_user != null) {
          if (_user!.role == "client") {
            return accueil(token: _token!);
          }
          else{
            return     MenuLivreur(token: _token,);

          }
        } else {
          return accueil(token: _token!);
        }
      } else {
        return introscreen();
      }
    }
  }
}
