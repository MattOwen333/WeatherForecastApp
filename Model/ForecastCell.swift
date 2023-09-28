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

    
    func configureForecastUI(forecast: Forecast){
        ForecastingCellLabelTemp.text = forecast.temperature
        ForecastCellLabelWind.text = forecast.wind
        
        
    }
    
}


//
//func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
//
//
//    cell.cellLable.text = citiesList[indexPath.row]
//
//
//    return cell
//
//}
//
//}
