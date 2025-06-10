//
//  Untitled.swift
//  credibot
//
//  Created by 何康 on 2025/6/8.
//

import BRPickerView

class PickerHelper {
    static func showSinglePicker(dataSource: [calledtoModel]) -> [BRProvinceModel] {
        var result = [BRProvinceModel]()
        for (index, model) in dataSource.enumerated() {
            let provinceModel = BRProvinceModel()
            provinceModel.code = String(model.child ?? 0)
            provinceModel.name = model.biggest
            provinceModel.index = index
            result.append(provinceModel)
        }
        return result
    }
}
