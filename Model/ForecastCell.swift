//
//  ForecastCell.swift
//  WeatherAppProj2
//
//  Created by Carrie Curtis on 8/31/23.
//

import UIKit


class ForecastCell : UITableViewCell {
    
    @IBOutlet weak var ForecastCellLabelWind: UILabel!
    
    @IBOutlet weak var ForecastingCellLabelTemp: UILabel!
    
    @IBOutlet weak var ForecastingCellLabelDate:            UILabel!
    
    
    
    
    func configureForecastUI(forecast: Forecast){
        ForecastingCellLabelTemp.text = forecast.temperature
        ForecastCellLabelWind.text = forecast.wind
        
        let currentDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let todayDateString = dateFormatter.string(from: currentDate)
        ForecastingCellLabelDate.text = todayDateString
        
    }
    
}

















//============================================

//class ForecastCell : UITableViewCell {
//
//    @IBOutlet weak var ForecastCellLabelWind: UILabel!
//    @IBOutlet weak var ForecastingCellLabelTemp: UILabel!
//    @IBOutlet weak var ForecastingCellLabelDate: UILabel!
//
//    func configureForecastUI(forecast: Forecast, index: Int) {
//        ForecastingCellLabelTemp.text = forecast.temperature
//        ForecastCellLabelWind.text = forecast.wind
//
//        let currentDate = Date()
//        var calendar = Calendar.current
//        var dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM/dd/yyyy"
//
//        // Get the current date
//        var forecastDate = currentDate
//
//        // Calculate the date for the first forecast
//        if index == 0 {
//            let todayDateString = dateFormatter.string(from: currentDate)
//            ForecastingCellLabelDate.text = todayDateString
//        } else {
//            // Calculate subsequent dates for forecasts
//            forecastDate = calendar.date(byAdding: .day, value: index, to: currentDate)!
//            let forecastDateString = dateFormatter.string(from: forecastDate)
//            ForecastingCellLabelDate.text = forecastDateString
//        }
//    }
//}
