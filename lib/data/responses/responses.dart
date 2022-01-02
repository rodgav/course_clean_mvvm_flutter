// To parse this JSON data, do
//
//     final authenticationResponse = authenticationResponseFromJson(jsonString);
import 'package:juliaca_store0/domain/model/model.dart';
import 'dart:convert';

Authentication authenticationFromString(String str) =>
    authenticationFromJson(json.decode(str));

String authenticationToString(Authentication data) =>
    json.encode(authenticationToJson(data));

Authentication authenticationFromJson(Map<String, dynamic> json) =>
    Authentication(
      status: json["status"] ?? 1,
      message: json["message"] ?? '',
      customer: customerFromJson(json["customer"]),
      contacts: contactsFromJson(json["contacts"]),
    );

Map<String, dynamic> authenticationToJson(Authentication authentication) => {
      "status": authentication.status,
      "message": authentication.message,
      "customer": customerToJson(authentication.customer),
      "contacts": contactsToJson(authentication.contacts),
    };

Contacts contactsFromJson(Map<String, dynamic>? json) => Contacts(
      phone: json?["phone"] ?? '',
      link: json?["link"] ?? '',
      email: json?["email"] ?? '',
    );

Map<String, dynamic> contactsToJson(Contacts contacts) => {
      "phone": contacts.phone,
      "link": contacts.link,
      "email": contacts.email,
    };

Customer customerFromJson(Map<String, dynamic>? json) => Customer(
      id: json?["id"] ?? '',
      name: json?["name"] ?? '',
      numOfNotifications: json?["numOfNotifications"] ?? 0,
    );

Map<String, dynamic> customerToJson(Customer customer) => {
      "id": customer.id,
      "name": customer.name,
      "numOfNotifications": customer.numOfNotifications,
    };

ForgotPassword forgotPasswordFromString(String str) =>
    forgotPasswordfromJson(json.decode(str));

String forgotPasswordToString(ForgotPassword data) =>
    json.encode(forgotPasswordToJson(data));

ForgotPassword forgotPasswordfromJson(Map<String, dynamic> json) =>
    ForgotPassword(
      status: json["status"] ?? 1,
      message: json["message"] ?? '',
      support: json["support"] ?? '',
    );

Map<String, dynamic> forgotPasswordToJson(ForgotPassword forgotPassword) => {
      "status": forgotPassword.status,
      "message": forgotPassword.message,
      "support": forgotPassword.support,
    };

Home homeFromString(String str) => homeFromJson(json.decode(str));

String homeToString(Home data) => json.encode(homeToJson(data));

Home homeFromJson(Map<String, dynamic> json) => Home(
      status: json["status"] ?? 1,
      message: json["message"] ?? '',
      data: dataFromJson(json["data"]),
    );

Map<String, dynamic> homeToJson(Home home) => {
      "status": home.status,
      "message": home.message,
      "data": dataToJson(home.data),
    };

Data dataFromJson(Map<String, dynamic> json) => Data(
      services: json["services"] != null
          ? List<BannerData>.from(
              json["services"].map((x) => bannerFromJson(x)))
          : [],
      stores: json["stores"] != null
          ? List<BannerData>.from(json["stores"].map((x) => bannerFromJson(x)))
          : [],
      banners: json["banners"] != null
          ? List<BannerData>.from(json["banners"].map((x) => bannerFromJson(x)))
          : [],
    );

Map<String, dynamic> dataToJson(Data data) => {
      "services": List<dynamic>.from(data.services.map((x) => bannerToJson(x))),
      "stores": List<dynamic>.from(data.stores.map((x) => bannerToJson(x))),
      "banners": List<dynamic>.from(data.banners.map((x) => bannerToJson(x))),
    };

BannerData bannerFromJson(Map<String, dynamic> json) => BannerData(
      id: json["id"] ?? 1,
      title: json["title"] ?? '',
      image: json["image"] ?? '',
    );

Map<String, dynamic> bannerToJson(BannerData banner) => {
      "id": banner.id,
      "title": banner.title,
      "image": banner.image,
    };

StoreDetails storeDetailsFromString(String str) =>
    storeDetailsFromJson(json.decode(str));

String storeDetailsToString(StoreDetails data) =>
    json.encode(storeDetailsToJson(data));

StoreDetails storeDetailsFromJson(Map<String, dynamic> json) => StoreDetails(
      status: json["status"] ?? 1,
      message: json["message"] ?? '',
      image: json["image"] ?? '',
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      details: json["details"] ?? '',
      services: json["services"] ?? '',
      about: json["about"] ?? '',
    );

Map<String, dynamic> storeDetailsToJson(StoreDetails storeDetails) => {
      "status": storeDetails.status,
      "message": storeDetails.message,
      "image": storeDetails.image,
      "id": storeDetails.id,
      "title": storeDetails.title,
      "details": storeDetails.details,
      "services": storeDetails.services,
      "about": storeDetails.about,
    };
