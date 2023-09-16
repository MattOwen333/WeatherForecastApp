//
//  ForecastCell.swift
//  WeatherAppProj2
//
//  Created by Carrie Curtis on 8/31/23.
//

import UIKit

class ForecastCell : UITableViewCell {
    

    @IBOutlet weak var ForecastingCellLabel: UILabel!
    
    func configureForecastUI(forecast: Forecast){
        ForecastingCellLabel.text = "\(forecast.temperature)"
        
        
    }
}



