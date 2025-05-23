import 'dart:convert';

Api apiFromJson(String str) => Api.fromJson(json.decode(str));

String apiToJson(Api data) => json.encode(data.toJson());

class Api {
    bool error;
    int amount;
    List<Joke> jokes;

    Api({
        required this.error,
        required this.amount,
        required this.jokes,
    });

    factory Api.fromJson(Map<String, dynamic> json) => Api(
        error: json["error"],
        amount: json["amount"],
        jokes: List<Joke>.from(json["jokes"].map((x) => Joke.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "amount": amount,
        "jokes": List<dynamic>.from(jokes.map((x) => x.toJson())),
    };
}

class Joke {
    String category;
    Type type;
    String? joke;
    Flags flags;
    bool safe;
    int id;
    Lang lang;
    String? setup;
    String? delivery;

    Joke({
        required this.category,
        required this.type,
        this.joke,
        required this.flags,
        required this.safe,
        required this.id,
        required this.lang,
        this.setup,
        this.delivery,
    });

    factory Joke.fromJson(Map<String, dynamic> json) => Joke(
        category: json["category"],
        type: typeValues.map[json["type"]]!,
        joke: json["joke"],
        flags: Flags.fromJson(json["flags"]),
        safe: json["safe"],
        id: json["id"],
        lang: langValues.map[json["lang"]]!,
        setup: json["setup"],
        delivery: json["delivery"],
    );

    Map<String, dynamic> toJson() => {
        "category": category,
        "type": typeValues.reverse[type],
        "joke": joke,
        "flags": flags.toJson(),
        "safe": safe,
        "id": id,
        "lang": langValues.reverse[lang],
        "setup": setup,
        "delivery": delivery,
    };
}

class Flags {
    bool nsfw;
    bool religious;
    bool political;
    bool racist;
    bool sexist;
    bool explicit;

    Flags({
        required this.nsfw,
        required this.religious,
        required this.political,
        required this.racist,
        required this.sexist,
        required this.explicit,
    });

    factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        nsfw: json["nsfw"],
        religious: json["religious"],
        political: json["political"],
        racist: json["racist"],
        sexist: json["sexist"],
        explicit: json["explicit"],
    );

    Map<String, dynamic> toJson() => {
        "nsfw": nsfw,
        "religious": religious,
        "political": political,
        "racist": racist,
        "sexist": sexist,
        "explicit": explicit,
    };
}

enum Lang {
    EN
}

final langValues = EnumValues({
    "en": Lang.EN
});

enum Type {
    SINGLE,
    TWOPART
}

final typeValues = EnumValues({
    "single": Type.SINGLE,
    "twopart": Type.TWOPART
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
