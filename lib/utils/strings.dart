

const String ksMsg = "I want to login as";
const String ksLogin = "Login";
const String ksPassword = "Password";
const String ksHi = "Hi";
const String ksMsg1 = "Login to continue";
const String ksUserName = 'Username';
const String ksSelectSchool = 'Select School';
const String ksOk = 'OK';
const String ksError = 'Error';
const String ksEmptyValidator = 'Username/Password can not be empty.';
const String ksInvalidValidator = 'Invalid Username or Password';

//appName
const String zlerpAppName = 'ZDL EDUHUB';
const String schoolerpAppName = 'ZeptoSchool ERP';
const String aksharaAppName = 'Akshara School Connect';
const String dseAppName = 'MyDSE';

//appbase url
//const String zlerpAppBaseUrl = 'http://192.168.1.25:8080/';
const String zlerpAppBaseUrl = 'https://flutter.zeptolearn.com/';

//const String schoolerpAppBaseUrl = 'https://flutter.zeptolearn.com/';
const String schoolerpAppBaseUrl = 'http://192.168.1.22:8080/';

const String aksharaAppBaseUrl = 'https://flutter.zeptolearn.com/';

const String dseAppBaseUrl = 'https://flutter.zeptolearn.com/';

const List<List<String>> schools = [
  [schoolerpAppName, schoolerpAppBaseUrl,'com.zdl.schoolerp'],
  [aksharaAppName, aksharaAppBaseUrl,'com.zdl.akshara'],
  [dseAppName, 'com.zdl.dse'],
];

const List<List<String>> unifiedSchools = [
  ['School 1','com.zdl.schoolerp'],
  ['School 2','com.zdl.snvv'],
  ['School 3','com.zdl.snps'],
];
