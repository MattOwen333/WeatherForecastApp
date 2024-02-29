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
        
        ForecastingCellLabelDate.text = forecast.day
        
    }
    
}


