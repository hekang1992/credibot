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
}
