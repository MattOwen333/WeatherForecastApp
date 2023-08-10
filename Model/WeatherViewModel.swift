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

//== Make fetchWeather a class
//== give fetchweather an input of a city
//== indexPath.row value will be given as the city
//== then passing weather to detail view controller


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
    
}

//MARK: - Table View Delegate

class DetailViewController : UIViewController, UITextFieldDelegate {
    
    
    
    @IBOutlet weak var detailLable: UILabel!
    
    var detailText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    detailLable.text = detailText
    }
}


class CustomCell : UITableViewCell {
    
    @IBOutlet weak var cellLable: UILabel!
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
}

//MARK: - Table View Delegate




//MARK: - Table View Data Source

//extension WeatherViewController : UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return citiesCount  }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
//
//        cell.cellLable.text = citiesList[indexPath.row]
//
//        return cell
//
//    }
//
//
//
//  
//}





