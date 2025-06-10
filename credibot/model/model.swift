//
//  model.swift
//  credibot
//
//  Created by emma on 2025/5/27.
//

let PRODUCT_DETAIL_PAGE = "xwatermelonS"

class BaseModel: Codable {
    var wanted: String?
    var likesnake: String?
    var floated: floatedModel?
}

class floatedModel: Codable {
    var music: String?
    var noise: String?
    var admiration: String?
    var wriggled: wriggledModel?
    var americans: americansModel?
    var huts: [hutsModel]?
    var acting: [[String]]?
    var babies: babiesModel?
    var goods: String?
    var none: String?
    var biggest: String?
    var trays: [traysModel]?
    var topick: [topickModel]?
    var wander: wanderModel?
}

class wanderModel: Codable {
    var topick: [topickModel]?
}

class topickModel: Codable {
    var biggest: String?//name
    var topick: [topickModel]?
    var imagined: String?
    var ofcinema: String?
    var pictures: [calledtoModel]?
    var relationText: String?
    var jolly: String?//phone
    var interesting: String?
    
}

class babiesModel: Codable {
    var story: Int?
    var tobuy: String?
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

class americansModel: Codable {
    var process: String?
    var wasthat: String?
}

class hutsModel: Codable {
    var wasthat: String?
    var europeans: String?
    var madetheir: String?
    var testament: String?
    var story: Int?
}

class traysModel: Codable {
    var madetheir: String?
    var testament: String?
    var wanted: String?
    var wares: String?
    var passed: Int?
    var calledto: [calledtoModel]?
    var noisy: String?//value
    var child: String?
}

class calledtoModel: Codable {
    var biggest: String?
    var child: ChildType?
    
    enum ChildType: Codable {
        case int(Int)
        case string(String)
        
        init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if let intVal = try? container.decode(Int.self) {
                self = .int(intVal)
            } else if let stringVal = try? container.decode(String.self) {
                self = .string(stringVal)
            } else {
                throw DecodingError.typeMismatch(
                    ChildType.self,
                    DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Expected Int or String for child")
                )
            }
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            switch self {
            case .int(let value):
                try container.encode(value)
            case .string(let value):
                try container.encode(value)
            }
        }
    }
}
