//
//  WeatherViewModel.swift
//  WeatherAppProj2
//
//  Created by Carrie Curtis on 3/3/23.
//

import Foundation
import UIKit



struct Weather: Codable {
    let temperature, wind, description: String
    let forecast: [Forecast]
}
struct Forecast: Codable {
    let day, temperature, wind: String
}

struct CitiesList: Codable {
    let cities: [String]
}

var citiesCount: Int = 0
var citiesList: [String] = []

// DO NOT: know if this is best practice for grabbing data from an API for this particular project.

func fetchWeatherData() async throws-> [Forecast] {
    let url = URL(string: "https://goweather.herokuapp.com/weather/Atlanta")!
    //1)Remove Miami
    //2)Then Concatenate url to cities[indexPath.row]

    let (data, _) = try await URLSession.shared.data(from: url)
    let decoded = try JSONDecoder().decode(Weather.self, from: data)
    return decoded.forecast
    // 1) This is where the logic for appending [indexPath.row] will apply, url will need to be dynamic based on the city
    // 1a) Said data[indexPath.row], (Miami hardcoded in this case) will then need to be supplied to the Delegate
    // 2) should label.text = *the summation of url + cities[indexPath.row]?*
}

func loadDataSource() {
    guard let sourcesURL = Bundle.main.url(forResource: "Cities", withExtension: "json"),
          let citiesData = try? Data(contentsOf: sourcesURL),
          let citiesListData = try? JSONDecoder().decode(CitiesList.self, from: citiesData) else {
        fatalError("Could not find Cities.json")
        
    }
    print(citiesListData.cities.sorted() , "This is CitiesListData.count", citiesListData.cities.count)
    citiesCount = citiesListData.cities.count
    citiesList = citiesListData.cities.sorted()
    print(citiesList)
}



//MARK: - Table View DelegOate

class DetailViewController : UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var detailLable: UILabel!
    
    var detailText : String?
}


class CustomCell : UITableViewCell {
    
    @IBOutlet weak var cellLable: UILabel!
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let detailVC = storyboard?.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController else {
//            return
//        }
//
//        switch indexPath.section {
//        case SectionType.duck.rawValue:
//            detailVC.configureLanguage(language: duckLangArr[indexPath.row])
//        case SectionType.static.rawValue:
//            detailVC.configureLanguage(language: staticLangArr[indexPath.row])
//        default: break
//        }
//
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
}

//MARK: - Table View Delegate

extension WeatherViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}


//MARK: - Table View Data Source

extension WeatherViewController : UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesCount  }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell

        cell.cellLable.text = citiesList[indexPath.row]

        return cell

    }



  
}





