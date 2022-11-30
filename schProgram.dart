library schUtilities;

import 'dart:convert';
import 'dart:io';
import 'dart:core';
part 'schUti.dart';
void welcome(){
  mainLoading(parentFileName,parents,parentPws);
  mainLoading(teacherFileName,teachers,teacherPws);
  mainLoading(studentFileName,students,studentPws);
  print('Welcome!');
  mainMenu();
}

void mainLoading(String fileName,List<String?> names,List<String?> pws){
  String data="";
  int count=0;
  File p=new File('D:\\$fileName');
  List<String> lines=p.readAsLinesSync();
  lines.forEach((line) {
    line+=" ";
    line.runes.forEach((c) {
      var ch=new String.fromCharCode(c);
      if(ch!=" " && count==0){
        data+=ch;
      }else if(ch==" " && count==0){
        names.add(data);
        data="";
        count++;
      }else if(ch!=" " && count==1){
        data+=ch;
      }else if(ch==" " && count==1){
        pws.add(data);
        data="";
        count=0;
      }
    });
  });
}


void mainMenu(){
  print('Enter 1 for parents mode.');
  print('Enter 2 for teachers mode.');
  print('Enter 3 for students mode.');
  print('Enter 4 to exit.');
  mainOption=stdin.readLineSync();
  if(mainOption=='1'){
    parentSubMenu();
  }else if(mainOption=='2'){
    teacherSubMenu();
  }else if(mainOption=='3'){
    studentSubMenu();
  }else{
    exit(0);
  }
}

void parentSubMenu(){
  String? parentOption;
  print('============>Parent Mode=============>');
  print('Enter 1 to register.');
  print('Enter 2 to login.');
  print('Enter 3 to exit to main menu.');
  parentOption=stdin.readLineSync();
  if(parentOption=='1'){
    register(parents, parentPws, parentIndex);
  }else if(parentOption=='2'){
    login(parents,parentPws,loggedInparentMenu);

  }else{
    mainMenu();
  }
  parentSubMenu();
}

void register(List<String?> nameArr,List<String?> pwArr,int index){
  String? regName;
  int? result;
  String? password;
  String? confirmPw;
  print('Enter your name:');
  regName=stdin.readLineSync();
  result=alreadyExistName(regName,nameArr);
  if(result==1){
    print('Enter your password:');
    password=stdin.readLineSync();
    result=alreadyExistPw(password, pwArr);
    if(result==1){
      print('Confirm your password:');
      confirmPw=stdin.readLineSync();
      if(password==confirmPw){
        print('Registration success.');
        nameArr.add(regName);
        pwArr.add(password);
        index++;
        if(mainOption=='1'){
          File f=new File('D:\\$parentFileName');
          f.writeAsStringSync('$regName $password\n', mode: FileMode.append);
        }else if(mainOption=='2'){
          File f=new File('D:\\$teacherFileName');
          f.writeAsStringSync('$regName $password\n', mode: FileMode.append);
        }else{
          File f=new File('D:\\$studentFileName');
          f.writeAsStringSync('$regName $password\n', mode: FileMode.append);
        }

      }else{
        print('Passwords do not match.');
      }
    }else{
      print('Password not available.');
    }
  }else{
    print('This name is not available.');
  }
}

void login(List<String?> nameArr,List<String?> pwArr,Function func){
  String? loginName;
  int index;
  String? password;
  print('Enter the name:');
  loginName=stdin.readLineSync();
  index=getIndex(loginName,nameArr);
  if(index==-1){
    print('Invalid username.');
  }else{
    print('Enter your password:');
    password=stdin.readLineSync();
    index=getIndex(password,pwArr);
    if(index==-1){
      print('Invalid password.');
    }else{
      print('Logged in as $loginName');
      func();
    }
  }
}

void loggedInparentMenu(){
  String? option;
  print("Enter 1 to see your childrens' status.");
  print('Enter 2 to get contact info of teachers.');
  print('Enter 3 to get payment info to school.');
  print('Enter 4 to get course summary.');
  print('Enter 5 to check future payments.');
  print('Enter 6 to exit.');
  option=stdin.readLineSync();
  if(option=='1'){
    print('children status.');
  }else if(option=='2'){
    print('Contact info of teachers.');
  }else if(option=='3'){
    print('Payment info of school.');
  }else if(option=='4'){
    print('Course Summary.');
  }else if(option=='5'){
    print('Future payment.');
  }else{
    parentSubMenu();
  }
  loggedInparentMenu();
}

void teacherSubMenu(){
  String? option;
  print('============>Teacher Mode=============>');
  print('Enter 1 to register.');
  print('Enter 2 to login.');
  print('Enter 3 to exit to main menu.');
  option=stdin.readLineSync();
  if(option=='1'){
    register(teachers,teacherPws,teacherIndex);
  }else if(option=='2'){
    login(teachers,teacherPws,loggedInTeacher);
  }else{
    mainMenu();
  }
  teacherSubMenu();
}

void loggedInTeacher(){
  String? option;
  print('Enter 1 to score the students.');
  print('Enter 2 to collect attendance.');
  print("Enter 3 to see students's info.");
  print("Enter 4 to see specific student's info");
  print("Enter 5 to exit.");
  option=stdin.readLineSync();
  if(option=='1'){
    print('Scoring the student.');
  }else if(option=='2'){
    print('Collecting attendance.');
  }else if(option=='3'){
    print('Student info.');
  }else if(option=='4'){
    print('Specific student info.');
  }else{
    teacherSubMenu();
  }
  loggedInTeacher();
}

void studentSubMenu(){
  String? option;
  print('============>Student Mode=============>');
  print('Enter 1 to register.');
  print('Enter 2 to login.');
  print('Enter 3 to quit.');
  option=stdin.readLineSync();
  if(option=='1'){
    register(students, studentPws,studentIndex);
  }else if(option=='2'){
    login(students,studentPws,loggedInStudent);
  }else{
    mainMenu();
  }
  studentSubMenu();
}

void loggedInStudent(){
  String? option;
  print('Enter 1 to see contact info of teachrs.');
  print('Enter 2 to see time table.');
  print('Enter 3 to exit.');
  option=stdin.readLineSync();
  if(option=='1'){
    print('Teachrs info');
  }else if(option=='2'){
    print('TIme table.');
  }else{
    studentSubMenu();
  }
  loggedInStudent();
}







