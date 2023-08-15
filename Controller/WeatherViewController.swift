//
//  ViewController.swift
//  WeatherAppProj2
//
//  Created by Carrie Curtis on 3/3/23.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    
    
    @IBOutlet weak var tableView: UITableView!
    var weatherData = WeatherData()
    
    func configureTable() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    var city: String = "Atlanta"
    var citySelected: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Task {
            do {
                
                let threeDay = try await weatherData.fetchWeatherData(city: city)
                print("THIS IS THREEDAY:", threeDay)
            } catch {
                print(error)
                print("THE ERROR ON THE CATCH")
                
            }
        }        // self refers to the current ViewController
        weatherData.loadDataSource()
        configureTable()
        
        
    }
    
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    
    {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        
        print(indexPath.row)
        

        navigationController?.pushViewController(detailVC, animated: true)
        
        let weatherTask = Task {
            let citySelection = try await weatherData.fetchWeatherData(city: citiesList[indexPath.row])
           
            print(citySelection)
            detailVC.weatherContainer = citySelection
        }
        
        print(indexPath.row)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
    
    //Mark: UITableiewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesCount  }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! CustomCell
        
        cell.cellLable.text = citiesList[indexPath.row]
        
        return cell
        
    }
}




    
  
    






























//    @IBAction func searchPressed(_ sender: UIButton) {
//        searchTextField.endEditing(true)
//        print(searchTextField.text!)
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        searchTextField.endEditing(true)
//        print(searchTextField.text!)
//        return true
//    }
//
//    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
//        if textField.text != "" {
//            return true
//        } else {
//            textField.placeholder = "Try A City"
//            return false
//        }
//    }
//
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//
//
//        searchTextField.text = ""
//    }
