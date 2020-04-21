import 'package:http/http.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' show join;
import 'package:tunza_app/core/models/user.dart';

class MyDatabase{
  MyDatabase(){

  }
  Future getConnection()async{
    var databasesPath = "data/data/com.example.tunza_app/databases/";
    String path = join(databasesPath, 'tunza_v2.db'); //FIRST PROBLEM



// open the database
    Database database = await openDatabase(path, version: 1,
      onCreate: (Database db, int version) {
        // When creating the db, create the table
        db.execute("Create table if not exists user(user_local_id INTEGER PRIMARY KEY,user_name TEXT,user_token TEXT,user_role INTEGER)");

      },
    );
    return database;
  }
  Future<User> storeLoggedUser(User user)async{
    Database database=await getConnection();
    await database.insert("user", user.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
    return user;
  }
  Future<User> getLoggedInUser()async{
    Database database = await getConnection();
    final List<Map<String,dynamic>> maps = await database.rawQuery("Select * from user");
    List<User> users = List.generate(maps.length, (i){
      return User.fromMap(maps[i]);
    });
    print(users);
    if(users.length>0){
      return users[0];
    }else{
      return null;
    }

  }
  Future<bool> deleteLoggedUser()async{
    Database database=await getConnection();
    await database.delete("user",where: "1");
    return true;
  }
}