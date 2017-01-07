//
//  WeatherViewController.swift
//  SomaIOS
//
//  Created by ali ziwa on 10/12/16.
//  Copyright © 2016 ali ziwa. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var currentTemperature: UILabel!
    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var weatherDescription: UILabel!
    let loader = ActivityViewController(message: "fetching weather...")

    var Temperature = [Double]()
    var weatherDesc = [String]()
    var weatherDate = [Double()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherData()

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDesc.count
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as! WeatherTableViewCell
        cell.weatherDescription.text = "\(weatherDesc[indexPath.row]) \(Int(Temperature[indexPath.row]))°C"
        cell.weatherDate.text = self.getDateString(timestamp: weatherDate[indexPath.row]+1)
        
        print("\(weatherDesc[indexPath.row]) \(self.getDateString(timestamp: weatherDate[indexPath.row]))")
        
        return cell
    }
    
    func fetchWeatherData(){
        
        //present(loader, animated: true, completion: nil)
        
        Alamofire.request(Constants.urls().foreCastURL).responseJSON {
            response in
            
            //self.dismiss(animated: true, completion: nil)
            
            switch response.result {
            case .success:
                if let value = response.result.value {
                    let json = JSON(value)
                    print(json)
                    
                    if let listArray = json["list"].array {
                        for i in 0..<listArray.count {
                            //get date
                            if let date = listArray[i]["dt"].double {
                                self.weatherDate.append(date)
                                print("\(date) ...///")
                            }
                            
                            //get temperature
                            if let temp = listArray[i]["temp"]["min"].double {
                                self.Temperature.append(temp)
                            }else{
                                print("failed weather")
                            }
                            
                            //get description
                            if let weatherDesc1 = listArray[i]["weather"][0]["description"].string {
                                self.weatherDesc.append(weatherDesc1)
                            }
                            
                        }
                        self.tableView.reloadData()
                        self.currentDate.text = self.getDateString(timestamp: self.weatherDate[1])
                        self.currentTemperature.text = "\(Int(self.Temperature[0])) °C"
                        self.weatherDescription.text = self.weatherDesc[0]
                    }
                    
                }
                
            case .failure(let error):
                print(error)
            }

        }
    }
    @IBAction func backButton(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getDateString(timestamp: Double) -> String {
        let date = NSDate(timeIntervalSince1970: timestamp)
        
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = "MMM dd YYYY"
        
        let dateString = dayTimePeriodFormatter.string(from: date as Date)
        
        print( " _ts value is \(timestamp)")
        print( " _ts value is \(dateString)")
        return dateString
    }

}
