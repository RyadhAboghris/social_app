//https://newsapi.org/v2/everything?q=tesla&apiKey=9e9e66aee55243cc85449e38d3598765



import '../network/local/cache_helper.dart';

void singOut(context){

   CacheHelper.removeData(key: 'token').then((value) {
    if (value) {
      // navigateAndFinish(context, ShopLoginScreen());
    }
  });
}

 String token ='';
String uId = '';
