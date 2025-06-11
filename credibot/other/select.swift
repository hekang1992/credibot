//
//  Untitled.swift
//  credibot
//
//  Created by Kevin Morgan on 2025/6/8.
//

import BRPickerView

class PickerHelper {
    static func showSinglePicker(dataSource: [calledtoModel]) -> [BRProvinceModel] {
        var result = [BRProvinceModel]()
        for (index, model) in dataSource.enumerated() {
            let provinceModel = BRProvinceModel()
            if let child = model.child {
                switch child {
                case .int(let value):
                    provinceModel.code = String(value)
                case .string(let value):
                    provinceModel.code = value
                }
            }
            provinceModel.name = model.biggest
            provinceModel.index = index
            result.append(provinceModel)
        }
        return result
    }
    
    static func showThreePicker(dataSource: [topickModel]) -> [BRProvinceModel] {
        var result = [BRProvinceModel]()
        for (index, province) in dataSource.enumerated() {
            let provinceModel = BRProvinceModel()
            provinceModel.name = province.biggest
            provinceModel.index = index
            
            var cityList = [BRCityModel]()
            if let cities = province.topick {
                for (cityIndex, city) in cities.enumerated() {
                    let cityModel = BRCityModel()
                    cityModel.name = city.biggest
                    cityModel.index = cityIndex
                    
                    var areaList = [BRAreaModel]()
                    if let areas = city.topick {
                        for (areaIndex, area) in areas.enumerated() {
                            let areaModel = BRAreaModel()
                            areaModel.name = area.biggest
                            areaModel.index = areaIndex
                            areaList.append(areaModel)
                        }
                    }
                    cityModel.arealist = areaList
                    cityList.append(cityModel)
                }
            }
            provinceModel.citylist = cityList
            result.append(provinceModel)
        }
        return result
    }
}
