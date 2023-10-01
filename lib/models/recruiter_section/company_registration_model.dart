
class CompanyRegistrationModel {
    String? legalName;
    String? sortName;
    String? industry;
    String? cSize;
    CLocation? cLocation;
    String? cWebsite;

    CompanyRegistrationModel({
        this.legalName,
        this.sortName,
        this.industry,
        this.cSize,
        this.cLocation,
        this.cWebsite,
    });

    Map<String, dynamic> toJson() => {
        "legal_name": legalName,
        "sort_name": sortName,
        "industry": industry,
        "c_size": cSize,
        "c_location": cLocation!.toJson(),
        "c_website": cWebsite,
    };
}

class CLocation {
    double? lat;
    double? lon;
    String? formetAddress;
    String? locationoptional;
    String? divisiondata;
  

    CLocation({
        this.lat,
        this.lon,
        this.formetAddress,
        this.locationoptional,
        this.divisiondata,
    });

    factory CLocation.fromJson(Map<String, dynamic> json) => CLocation(
        lat: json["lat"],
        lon: json["lon"],
        formetAddress: json["formet_address"],
        locationoptional: json["locationoptional"],
        divisiondata: json["divisiondata"],
    );

    Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
        "formet_address": formetAddress,
        "locationoptional": locationoptional,
        "divisiondata": divisiondata,
    };
}
