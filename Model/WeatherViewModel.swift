//
//  WeatherViewModel.swift
//  WeatherAppProj2
//
//  Created by Carrie Curtis on 3/3/23.
//

import Foundation
import UIKit


//
//struct Weather: Decodable {
//
//    var temperature: String
//    var wind: String
//    var description: String
//    var forecast: [Forecast]
//}
//struct Forecast: Decodable {
//
//    var day: String
//    var wind: String
//    var temperature: String
//}

struct CitiesList: Decodable {
    let cities: [String]
}

var citiesCount: Int = 0
var citiesList: [String] = []

struct Forecast: Decodable {
    let day: String
    let wind: String
    let temperature: String
    
}

struct Weather: Decodable {
    enum CodingKeys: String, CodingKey {
        case temperature
        case wind
        case description
        case forecast
    }
    let temperature: String
    let wind: String
    let description: String
    let forecast: [Forecast]
 
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
    
        self.temperature = try container.decode(String.self, forKey: .temperature)

      
        self.wind = try container.decode(String.self, forKey: .wind)
        

        
        self.description = try container.decode(String.self, forKey: .description)
        

        
        self.forecast = try container.decode([Forecast].self, forKey: .forecast)
    }
}


var weatherData = WeatherDataViewModel()


class WeatherDataViewModel {
    
    func loadWeatherTest() async throws -> Weather { Weather(temperature: "Mock temperature", wind: "mock wind speed", description : "mock descripiton", forecast: [ Forecast(day: "Monday", wind: "80", temperature: "test"), Forecast(day: "Monday", wind: "80", temperature: "test"), Forecast(day: "Monday", wind: "80", temperature: "test") ]) }
    

    
    
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

class DetailViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherContainer!.forecast.count
   
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let Forecastcell =
        tableView.dequeueReusableCell(withIdentifier: "ForecastCell") as! ForecastCell
        
        Forecastcell.configureForecastUI(forecast: weatherContainer!.forecast[indexPath.row])
        
      

        return Forecastcell
    }
    
     
    @IBOutlet weak var detailTableView: UITableView!
    

    
    var weatherContainer: Weather?
    
    
    @IBOutlet weak var detailLable: UILabel!
    @IBOutlet weak var detailLabelWind: UILabel!
    @IBOutlet weak var detailLabelDescription: UILabel!

    func configureDetailTable() {
        detailTableView.delegate = self
        detailTableView.dataSource = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(weatherContainer)
        
        configureDetailTable()
        
        
        detailLable.text = "\(weatherContainer!.temperature)"
        detailLabelWind.text = "\(weatherContainer!.wind)"
        detailLabelDescription.text = "\(weatherContainer!.description)"

    }
}
    
    


    




    
    
    
    
    

