//
//  model.swift
//  credibot
//
//  Created by 何康 on 2025/5/27.
//

class BaseModel: Codable {
    var wanted: String?
    var likesnake: String?
    var floated: floatedModel?
}

class floatedModel: Codable {
    var music: String?
    var noise: String?
    var wriggled: wriggledModel?
}

class wriggledModel: Codable {
    var child: String?
    var skinny: [skinnyModel]?
}

class skinnyModel: Codable {
    var legs: String?
    var between: String?
    var clapping: String?
    var dropping: String?
    var grabbed: Int?
    var juggled: String?
    var orbreaking: String?
    var sliding: String?
    var throwing: String?
    var turnedquickly: String?
    var loanRateUnit: String?
}
