import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soe/models/dataOfStaff.dart';
import 'package:soe/models/scheduleData.dart';
import 'package:soe/models/sensorData.dart';

class DatabaseServices {
  final String uid;
  DatabaseServices({this.uid});

  //collection reference
  final CollectionReference staffData =
      FirebaseFirestore.instance.collection('staff');
  final CollectionReference scheduleData =
      FirebaseFirestore.instance.collection('Schedule');
  final CollectionReference sensorData =
      FirebaseFirestore.instance.collection('SensorData');
  final CollectionReference reportData =
      FirebaseFirestore.instance.collection('Reports');

  Future updateSensorData(String ntu, String mq2) async {
    return await sensorData.doc('data').update({
      'ntu': ntu,
      'mq2': mq2,
    });
  }

  Future addReport(String s) async {
    return await reportData.add({uid: s});
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      mobile: snapshot.data()['mobile'],
    );
  }

  Stream<UserData> get userData {
    var v = staffData.doc(uid).snapshots().map(_userDataFromSnapshot);
    print(v);
    return v;
  }

  SensorData2 _sensorDataFromSnapshot(DocumentSnapshot snapshot) {
    return SensorData2(
      ntu: snapshot.data()['ntu'],
      mq2: snapshot.data()['mq2'],
    );
  }

  Stream<SensorData2> get dataOfSensor {
    var v = sensorData.doc('data').snapshots().map(_sensorDataFromSnapshot);
    print(v);
    return v;
  }

  ScheduleData _scheduleDataFromSnapshot(DocumentSnapshot snapshot) {
    return ScheduleData(
      onDuty: snapshot.data()['onDuty'],
    );
  }

  Stream<ScheduleData> get dataOfSchedule {
    var v = scheduleData.doc('data').snapshots().map(_scheduleDataFromSnapshot);
    print(v);
    return v;
  }
}
