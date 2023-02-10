class WeatherResponse {
  WeatherResponse({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.current,
    this.hourly,
    this.daily,
  });

  final double? lat;
  final double? lon;
  final String? timezone;
  final int? timezoneOffset;
  final Current? current;
  final List<Current>? hourly;
  final List<Daily>? daily;

  _listDailys(daily) {
    List<Daily> _list = [];
    for (var d in daily) {
      _list.add(Daily().fromJson(d));
    }
    return _list;
  }

  _listHourly(current) {
    List<Current> _list = [];
    for (var c in current) {
      _list.add(Current().fromJson(c));
    }
    return _list;
  }

  WeatherResponse fromJson(Map<String, dynamic> json) => WeatherResponse(
        lat: json['lat']?.toDouble() ?? "",
        lon: json["lon"]?.toDouble() ?? "",
        timezone: json["timezone"] ?? "",
        timezoneOffset: json["timezone_offset"] ?? "",
        current: json["current"] == null
            ? null
            : Current().fromJson(json["current"]),
        hourly: json["hourly"] == null ? [] : _listHourly(json["hourly"]),
        daily: json["daily"] == null ? [] : _listDailys(json["daily"]),
      );
}

class Current {
  Current({
    this.dt,
    this.sunrise,
    this.sunset,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.uvi,
    this.clouds,
    this.visibility,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.rain,
    this.pop,
  });

  final int? dt;
  final int? sunrise;
  final int? sunset;
  final double? temp;
  final double? feelsLike;
  final int? pressure;
  final int? humidity;
  final double? dewPoint;
  final double? uvi;
  final int? clouds;
  final int? visibility;
  final double? windSpeed;
  final int? windDeg;
  final double? windGust;
  final List<Weather>? weather;
  final Rain? rain;
  final double? pop;

  _listWeathers(weather) {
    List<Weather> _list = [];
    for (var w in weather) {
      _list.add(Weather().fromJson(w));
    }
    return _list;
  }

  Current fromJson(Map<String, dynamic> json) => Current(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        temp: json["temp"]?.toDouble(),
        feelsLike: json["feels_like"]?.toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"]?.toDouble(),
        uvi: json["uvi"]?.toDouble(),
        clouds: json["clouds"],
        visibility: json["visibility"],
        windSpeed: json["wind_speed"]?.toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"]?.toDouble(),
        weather: json["weather"] == null ? [] : _listWeathers(json["weather"]),
        rain: json["rain"] == null ? null : Rain().fromJson(json["rain"]),
        pop: json["pop"]?.toDouble(),
      );
}

class Rain {
  Rain({
    this.the1H,
  });

  final double? the1H;

  Rain fromJson(Map<String, dynamic> json) => Rain(
        the1H: json["1h"]?.toDouble(),
      );
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int? id;
  String? main;
  String? description;
  String? icon;

  Weather fromJson(Map<String, dynamic> json) {
    return Weather(
      id: json["id"] ?? "",
      main: json["main"],
      description: json["description"],
      icon: json["icon"],
    );
  }
}

class Daily {
  Daily({
    this.dt,
    this.sunrise,
    this.sunset,
    this.moonrise,
    this.moonset,
    this.moonPhase,
    this.temp,
    this.feelsLike,
    this.pressure,
    this.humidity,
    this.dewPoint,
    this.windSpeed,
    this.windDeg,
    this.windGust,
    this.weather,
    this.clouds,
    this.pop,
    this.rain,
    this.uvi,
  });

  final int? dt;
  final int? sunrise;
  final int? sunset;
  final int? moonrise;
  final int? moonset;
  final double? moonPhase;
  final Temp? temp;
  final FeelsLike? feelsLike;
  final int? pressure;
  final int? humidity;
  final double? dewPoint;
  final double? windSpeed;
  final int? windDeg;
  final double? windGust;
  final List<Weather>? weather;
  final int? clouds;
  final double? pop;
  final double? rain;
  final double? uvi;

  _listWeather(weather) {
    List<Weather> _list = [];
    for (var w in weather) {
      _list.add(Weather().fromJson(w));
    }
    return _list;
  }

  Daily fromJson(Map<String, dynamic> json) => Daily(
        dt: json["dt"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
        moonrise: json["moonrise"],
        moonset: json["moonset"],
        moonPhase: json["moon_phase"]?.toDouble(),
        temp: json["temp"] == null ? null : Temp().fromJson(json["temp"]),
        feelsLike: json["feels_like"] == null
            ? null
            : FeelsLike().fromJson(json["feels_like"]),
        pressure: json["pressure"],
        humidity: json["humidity"],
        dewPoint: json["dew_point"]?.toDouble(),
        windSpeed: json["wind_speed"]?.toDouble(),
        windDeg: json["wind_deg"],
        windGust: json["wind_gust"]?.toDouble(),
        weather: json["weather"] == null ? [] : _listWeather(json["weather"]),
        clouds: json["clouds"],
        pop: json["pop"]?.toDouble(),
        rain: json["rain"]?.toDouble(),
        uvi: json["uvi"]?.toDouble(),
      );
}

class FeelsLike {
  FeelsLike({
    this.day,
    this.night,
    this.eve,
    this.morn,
  });

  final double? day;
  final double? night;
  final double? eve;
  final double? morn;

  FeelsLike fromJson(Map<String, dynamic> json) => FeelsLike(
        day: json["day"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
      );
}

class Temp {
  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn,
  });

  final double? day;
  final double? min;
  final double? max;
  final double? night;
  final double? eve;
  final double? morn;

  Temp fromJson(Map<String, dynamic> json) => Temp(
        day: json["day"]?.toDouble(),
        min: json["min"]?.toDouble(),
        max: json["max"]?.toDouble(),
        night: json["night"]?.toDouble(),
        eve: json["eve"]?.toDouble(),
        morn: json["morn"]?.toDouble(),
      );
}
