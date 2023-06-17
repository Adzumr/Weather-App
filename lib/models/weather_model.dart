class WeatherModel {
  final Coord? coord;
  final List<Weather>? weather;
  final String? base;
  final Main? main;
  final int? visibility;
  final Wind? wind;
  final Clouds? clouds;
  final int? dt;
  final Sys? sys;
  final int? timezone;
  final int? id;
  final String? name;
  final int? cod;

  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  WeatherModel.fromJson(Map<String, dynamic> json)
      : coord = (json['coord'] as Map<String, dynamic>?) != null
            ? Coord.fromJson(json['coord'] as Map<String, dynamic>)
            : null,
        weather = (json['weather'] as List?)
            ?.map((dynamic e) => Weather.fromJson(e as Map<String, dynamic>))
            .toList(),
        base = json['base'] as String?,
        main = (json['main'] as Map<String, dynamic>?) != null
            ? Main.fromJson(json['main'] as Map<String, dynamic>)
            : null,
        visibility = json['visibility'] as int?,
        wind = (json['wind'] as Map<String, dynamic>?) != null
            ? Wind.fromJson(json['wind'] as Map<String, dynamic>)
            : null,
        clouds = (json['clouds'] as Map<String, dynamic>?) != null
            ? Clouds.fromJson(json['clouds'] as Map<String, dynamic>)
            : null,
        dt = json['dt'] as int?,
        sys = (json['sys'] as Map<String, dynamic>?) != null
            ? Sys.fromJson(json['sys'] as Map<String, dynamic>)
            : null,
        timezone = json['timezone'] as int?,
        id = json['id'] as int?,
        name = json['name'] as String?,
        cod = json['cod'] as int?;

  Map<String, dynamic> toJson() => {
        'coord': coord?.toJson(),
        'weather': weather?.map((e) => e.toJson()).toList(),
        'base': base,
        'main': main?.toJson(),
        'visibility': visibility,
        'wind': wind?.toJson(),
        'clouds': clouds?.toJson(),
        'dt': dt,
        'sys': sys?.toJson(),
        'timezone': timezone,
        'id': id,
        'name': name,
        'cod': cod
      };
}

class Coord {
  final double? lon;
  final double? lat;

  Coord({
    this.lon,
    this.lat,
  });

  Coord.fromJson(Map<String, dynamic> json)
      : lon = json['lon'] as double?,
        lat = json['lat'] as double?;

  Map<String, dynamic> toJson() => {'lon': lon, 'lat': lat};
}

class Weather {
  final int? id;
  final String? main;
  final String? description;
  final String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        main = json['main'] as String?,
        description = json['description'] as String?,
        icon = json['icon'] as String?;

  Map<String, dynamic> toJson() =>
      {'id': id, 'main': main, 'description': description, 'icon': icon};
}

class Main {
  final double? temp;
  final double? feelsLike;
  final double? tempMin;
  final double? tempMax;
  final int? pressure;
  final int? humidity;
  final int? seaLevel;
  final int? grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  Main.fromJson(Map<String, dynamic> json)
      : temp = json['temp'] as double?,
        feelsLike = json['feels_like'] as double?,
        tempMin = json['temp_min'] as double?,
        tempMax = json['temp_max'] as double?,
        pressure = json['pressure'] as int?,
        humidity = json['humidity'] as int?,
        seaLevel = json['sea_level'] as int?,
        grndLevel = json['grnd_level'] as int?;

  Map<String, dynamic> toJson() => {
        'temp': temp,
        'feels_like': feelsLike,
        'temp_min': tempMin,
        'temp_max': tempMax,
        'pressure': pressure,
        'humidity': humidity,
        'sea_level': seaLevel,
        'grnd_level': grndLevel
      };
}

class Wind {
  final double? speed;
  final int? deg;
  final double? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });

  Wind.fromJson(Map<String, dynamic> json)
      : speed = json['speed'] as double?,
        deg = json['deg'] as int?,
        gust = json['gust'] as double?;

  Map<String, dynamic> toJson() => {'speed': speed, 'deg': deg, 'gust': gust};
}

class Clouds {
  final int? all;

  Clouds({
    this.all,
  });

  Clouds.fromJson(Map<String, dynamic> json) : all = json['all'] as int?;

  Map<String, dynamic> toJson() => {'all': all};
}

class Sys {
  final int? type;
  final int? id;
  final String? country;
  final int? sunrise;
  final int? sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  Sys.fromJson(Map<String, dynamic> json)
      : type = json['type'] as int?,
        id = json['id'] as int?,
        country = json['country'] as String?,
        sunrise = json['sunrise'] as int?,
        sunset = json['sunset'] as int?;

  Map<String, dynamic> toJson() => {
        'type': type,
        'id': id,
        'country': country,
        'sunrise': sunrise,
        'sunset': sunset
      };
}
