import 'package:connection/models/place.dart';
import 'package:connection/repositories/place_repository.dart';
import 'package:flutter/foundation.dart';

class DiaChiModel with ChangeNotifier {
  List<City> listCity = [];
  List<District> listDistrict = [];
  List<Ward> listWard = [];
  int curCityId = 0;
  int curDistrictId = 0;
  int curWardId = 0;
  String address = "";
  Future<void> initialize(int Cid, int Did, int Wid) async {
    curCityId = Cid;
    curDistrictId = Did;
    curWardId = Wid;
    final repo = PlaceRepository();
    listCity = await repo.getListCity();
    if (curCityId != 0) {
      listDistrict = await repo.getListDistrict(curCityId);
    }
    if(curDistrictId != 0) {
    listWard = await repo.getListWard(curDistrictId);
    }
  }

  Future<void> setCity(int Cid) async {
    if (Cid != curCityId) {
      curCityId = Cid;
      curDistrictId = 0;
      curWardId = 0;
      final repo = PlaceRepository();
      listDistrict = await repo.getListDistrict(curCityId);
      listWard.clear();
    }
  }

  Future<void> setDistrict(int Did) async {
    if (Did != curDistrictId) {
      curDistrictId = Did;
      curWardId = 0;
      final repo = PlaceRepository();
      listWard = await repo.getListWard(curDistrictId);
    }
  }

  Future<void> setWard(int Wid) async {
    if (Wid != curWardId) {
      curWardId = Wid;
    }
  }
}
