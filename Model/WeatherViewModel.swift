//
//  WeatherViewModel.swift
//  WeatherAppProj2
//
//  Created by Carrie Curtis on 3/3/23.
//

import Foundation
import UIKit



struct Weather: Decodable {
    let temperature, wind, description: String
    let forecast: [Forecast]
}
struct Forecast: Decodable {
    let day, temperature, wind: String
}

struct CitiesList: Decodable {
    let cities: [String]
}

var citiesCount: Int = 0
var citiesList: [String] = []
var weatherData = WeatherData()




class WeatherData {
    
    func fetchWeatherData(city: String) async throws-> Weather? {
        
        guard let url = URL(string: "https://goweather.herokuapp.com/weather/\(city)")
        else {
            return nil
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoded = try JSONDecoder().decode(Weather.self, from: data)
        return decoded
                      
    }
    
    func loadDataSource() {
        guard let sourcesURL = Bundle.main.url(forResource: "Cities", withExtension: "json"),
              let citiesData = try? Data(contentsOf: sourcesURL),
              let citiesListData = try? JSONDecoder().decode(CitiesList.self, from: citiesData) else {
            fatalError("Could not find Cities.json")
            
        }
        print(citiesListData.cities.sorted() , "THIS IS: citiesListData.cities.count", citiesListData.cities.count)
        citiesCount = citiesListData.cities.count
        citiesList = citiesListData.cities.sorted()
        print("THIS IS cititesList BUT SORTED:", citiesList)
    }
    
//    func loadWeatherTest() {
//        guard let sourcesURL = Bundle.main.url(forResource: "WeatherTest", withExtension: "json"),
//              let weatherData = try? Data(contentsOf: sourcesURL),
//              let weatherListData = try? JSONDecoder().decode(Weather.self, from: weatherData) else {
//            fatalError("Could not find WeatherTest.json")
//            
//        }
//
//        print("THIS IS WeatherListData BUT SORTED:", weatherListData)
//    }
    
}

//MARK: - Table View Delegate

class DetailViewController : UIViewController, UITextFieldDelegate {
    
    var weatherContainer: Weather?
    
    
    @IBOutlet weak var detailLable: UILabel!
    @IBOutlet weak var detailLabelWind: UILabel!
    @IBOutlet weak var detailLabelDescription: UILabel!
    
    @IBOutlet weak var detailLabelForecast: UILabel!
    
    @IBOutlet weak var detailLabelForecastDayTwo: UILabel!
    
    @IBOutlet weak var detailLabelForecastDayThree: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        print(weatherContainer)
        
        detailLable.text = "\(weatherContainer!.temperature)"
        detailLabelWind.text = "\(weatherContainer!.wind)"
        detailLabelDescription.text = "\(weatherContainer!.description)"
        detailLabelForecast.text = "\(weatherContainer!.forecast[0])"
        detailLabelForecastDayTwo.text = "\(weatherContainer!.forecast[1])"
        detailLabelForecastDayThree.text = "\(weatherContainer!.forecast[2])"
        
        
        
    }
}
    
    
    class CustomCell : UITableViewCell {
        
        @IBOutlet weak var cellLable: UILabel!

        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 100
        }
        
    }


    
    
    
    
    

