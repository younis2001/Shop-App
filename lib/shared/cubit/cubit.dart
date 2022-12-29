

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../network/local/cache_helper.dart';

class AppCubit extends Cubit<AppStates>{
  AppCubit() : super(AppInitialState());






  static AppCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  List<Map>newtasks=[];
  List<Map>donetasks=[];
  List<Map>alerttasks=[];
  Database? database;
  List<String> text = ['Tasksapp', 'doneapp', 'alaertapp'];
  List<Widget> screens = [
    // NewTasksScrren(),
    // DoneTasksScrren(),
    // AlertTasksScrren(),
  ];
void ChangeIndex(index)
{
  currentIndex=index;
  emit(AppChangeBottomNavBarState());
}

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) async {
        // id int
        // titele string
        //time string
        print('database created');
        await database.execute(
            'CREATE TABLE TASKS (id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT,status TEXT)');
        print('table created');
      },
      onOpen: (database) {
        getDataFromDatabase(database); // حطينا براميتر داتا بيز عشان on create هي ال بتتعمل الاول فبالتالي هو محتاح براميتر
        print('database opened');
      },
    ).then((value)
    {
      database=value;
      emit(AppCreateDatabaseState());
    });
  }

  Future insertToDatabase({
    @required String? title,
    @required String? date,
    @required String? time,
  })  {
    return  database!.transaction((txn) {
      txn
          .rawInsert(
        'INSERT INTO TASKS(title,date,time,status) VALUES ("$title","$date","$time","new")',
      )
          .then((value) {
        print('$value inserted successfully');
        emit(AppInsertDatabaseState());

        getDataFromDatabase(database);

      });

      return Future.value();
    });
  }

  void getDataFromDatabase(database)  {
    newtasks=[];
    donetasks=[];
    alerttasks=[];
  emit(AppGetDatabaseState());
    return database!.rawQuery('SELECT * FROM tasks').then((value) {

     value.forEach((element)
      {
       if(element['status']=='new') newtasks.add(element);
       else if(element['status']=='done')donetasks.add(element);
       else alerttasks.add(element);
      });
      emit(AppGetDatabaseState());
    });
  }
  void  UpdateDatabase({
  required String status,
  required int id
}) {

 database!.rawUpdate(
      'UPDATE TASKS SET status = ? WHERE id = ?',
      ['$status', id]
 ).then((value)
 {
   getDataFromDatabase(database);
   emit(AppUpadteDatabaseState());
 });
}
  IconData chicon = Icons.edit;
  bool isBottomSheetDown = false;
  void changeBottomSheetState({
  required bool isshow,
    required IconData icon

})
  {
    isBottomSheetDown=isshow;
    chicon=icon;
    emit(AppChangeBottomSheetState());
  }
bool isDark=false;
  void AppModeChange({ bool? shared}){
if(shared!=null){
  isDark=shared;
  emit(ChangeAppMode());
}
else{
  isDark= !isDark;
  CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
    emit(ChangeAppMode());
  });
}




  }


}

