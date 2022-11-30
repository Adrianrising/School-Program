part of schUtilities;

String? mainOption;
int parentIndex=0;
int teacherIndex=0;
int studentIndex=0;
String parentFileName='parentInfo.txt';
String teacherFileName='teacherInfo.txt';
String studentFileName='studentInfo.txt';


List<String?> parents=[];
List<String?> parentPws=[];
List<String?> teachers=[];
List<String?> teacherPws=[];
List<String?> students=[];
List<String?> studentPws=[];

int getIndex(String? toSearch,List<String?> searchList){
  var len=searchList.length;
  for(int i=0;i<len;i++){
    if(toSearch==searchList[i]){
      return i;
    }
  }
  return -1;
}

int alreadyExistName(String? name,List<String?> names){
  var len=names.length;
  for(int i=0;i<len;i++){
    if(name==names[i]){
      return -1;
    }
  }
  return 1;
}

int alreadyExistPw(String? password,List<String?> passwords){
  var len=passwords.length;
  for(int i=0;i<len;i++){
    if(password==passwords[i]){
      return -1;
    }
  }
  return 1;
}

void showData(List<String?> arr){
  int? len=arr.length;
  for(int i=0;i<len;i++){
    print(arr[i]);
  }
}