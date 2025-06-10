//
//  timeConfig.swift
//  credibot
//
//  Created by Ava Martin on 2025/6/8.
//

import BRPickerView

class DatePickerHelper {

    static func showDayMonthYearPicker(on viewController: UIViewController,
                                       defaultDateString: String? = nil,
                                       minDate: Date? = nil,
                                       maxDate: Date? = nil,
                                       resultHandler: @escaping (String) -> Void) {

        let datePicker = BRDatePickerView()
        datePicker.pickerMode = .YMD
        datePicker.title = "Select time"

        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "dd-MM-yyyy"

        if let defaultStr = defaultDateString,
           let defaultDate = inputFormatter.date(from: defaultStr) {
            datePicker.selectDate = defaultDate
        } else {
            datePicker.selectDate = Date()
        }

        datePicker.minDate = minDate
        datePicker.maxDate = maxDate

        datePicker.resultBlock = { selectDate, selectValue in
            if let date = selectDate {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd-MM-yyyy"
                let dateStr = outputFormatter.string(from: date)
                resultHandler(dateStr)
            } else if let value = selectValue {
                resultHandler(value)
            }
        }

        datePicker.show()
    }
}

