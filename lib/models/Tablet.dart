import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Tablet {
  String type;
  String name;
  String manufacturer;
  String saltComposition;
  String storage;
  String introduction;
  Map<String, dynamic> sideEffects;
  Map<String, dynamic> benefits;
  Map<String, dynamic> howToUse;
  Map<String, dynamic> howItWorks;
  Map<String, dynamic> safetyAdvices;
  Map<String, dynamic> forgetToTake;
  Map<String, dynamic> allInfo;

  Tablet(
      {this.type,
      this.name,
      this.manufacturer,
      this.saltComposition,
      this.storage,
      this.introduction,
      this.sideEffects,
      this.benefits,
      this.howToUse,
      this.howItWorks,
      this.safetyAdvices,
      this.forgetToTake,
      this.allInfo,});

  factory Tablet.fromJsonOfTypeDrug(Map<String, dynamic> json) {
    return Tablet(
        type: json['type'],
        name: json['name'],
        manufacturer: json['manufacturer'],
        saltComposition: json['saltComposition'],
        storage: json['storage'],
        introduction: json['introduction'],
        sideEffects: json['sideEffects'],
        benefits: json['benefits'],
        howToUse: json['howToTake'],
        howItWorks: json['howItWorks'],
        safetyAdvices: json['safetyAdvices'],
        forgetToTake: json['forgetToTake']);
  }
  factory Tablet.fromJsonOfTypeOtc(Map<String, dynamic> json) {
    return Tablet(
      type: json['type'],
      name: json['name'],
      manufacturer: json['manufacturer'],
      allInfo: json['all_info'],
    );
  }
  factory Tablet.fromSnapshotOfTypeDrug(DocumentSnapshot docSnap) {
    return Tablet(
      type: docSnap.get('type'),
      name: docSnap.get('name'),
      manufacturer: docSnap.get('manufacturer'),
      saltComposition: docSnap.get('saltComposition'),
      storage: docSnap.get('storage'),
      introduction: docSnap.get('introduction'),
      sideEffects: docSnap.get('sideEffects'),
      benefits: docSnap.get('benefits'),
      howToUse: docSnap.get('howToTake'),
      howItWorks: docSnap.get('howItWorks'),
      safetyAdvices: docSnap.get('safetyAdvices'),
      forgetToTake: docSnap.get('forgetToTake'),
    );
  }
  factory Tablet.fromSnapshotOfTypeOtc(DocumentSnapshot docSnap) {
    return Tablet(
      type: docSnap.get('type'),
      name: docSnap.get('name'),
      manufacturer: docSnap.get('manufacturer'),
      allInfo: docSnap.get('all_info'),
    );
  }
  factory Tablet.empty() {
    return Tablet(type: '404');
  }
  Future<Tablet> details;
  Future<Tablet> getDetails(String medName) async {
    await Firebase.initializeApp();

    await FirebaseFirestore.instance
        .collection('medicine')
        .doc(medName.toLowerCase().replaceAll(" ", ""))
        .get()
        .then((DocumentSnapshot docSnapshot) {
      if (docSnapshot.exists) {
        print('Data from Database');
        details = prepareData(docSnapshot);
      } else {
        print('Data not present in Database..');
        details = webScrape(medName);
      }
    });
    return details;
  }

  Future<Tablet> prepareData(DocumentSnapshot data) async {
    if (data.get('type') == 'drugs') {
      return Tablet.fromSnapshotOfTypeDrug(data);
    }
    if (data.get('type') == 'otc') {
      return Tablet.fromSnapshotOfTypeOtc(data);
    }
    return Tablet.empty();
  }

  Future<Tablet> webScrape(String medName) async {
    print('WebScrap started');
    var url = Uri.http('localhost:5000', '/$medName');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      print('Data Found.. Pushing to Database');
      var json = jsonDecode(response.body);
      String type = json['type'];
      if (type == 'drugs') {
        String name = json['name'];
        String id = createId(name);
        print('id:' + id);
        await FirebaseFirestore.instance
            .collection('medicine')
            .doc(id)
            .set(json);
        print('Pushed to Database');
        return Tablet.fromJsonOfTypeDrug(json);
      }
      if (type == 'otc') {
        String name = json['name'];
        String id = createId(name);
        print('id:' + id);
        await FirebaseFirestore.instance
            .collection('medicine')
            .doc(id)
            .set(json);
        print('Pushed to Database');
        return Tablet.fromJsonOfTypeOtc(json);
      }
      print('Data Not Found..');
      return Tablet.empty();
    } else {
      throw Exception('Failed To Load');
    }
  }

  String createId(String medName) {
    int lastIndex = medName.lastIndexOf(" ");
    return medName.substring(0, lastIndex).replaceAll(" ", "").toLowerCase();
  }
}
