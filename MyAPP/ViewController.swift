//
//  ViewController.swift
//  HospitalMap
//
//  Created by kpugame on 22/04/2019.
//  Copyright © 2019 kpugame. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBAction func doneToPickerViewController(segue:UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "View"{
            if let navController = segue.destination as? UINavigationController{
                if let hospitalTableViewController = navController.topViewController as? MainTableViewController{
                    hospitalTableViewController.url = url + sgguCd + "&sigunguCode=4&listYN=Y"
                    hospitalTableViewController.area = sgguCd
                    print(hospitalTableViewController.area)
                }
            }
        }
    }
    
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    var pickerDataSource = ["서울","인천","대전","대구","광주","부산","울산","세종특별자치시","경기도","강원도"]
    
    var url : String = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey=2JbWDZIHJ7vUfhRi3O566G%2F0uJ8GrrN3IlDBv29Z6B3neQS2lOMJVt6kHEXPJ7Vm7ExmirVqnnlIULdcScuiDQ%3D%3D&pageNo=1&numOfRows=20&MobileApp=AppTest&MobileOS=ETC&arrange=A&contentTypeId=12&areaCode="
    
    var sgguCd : String = "1" //디폴트 시구코드 = 광진구
    
    func numberOfComponents(in pickerView : UIPickerView) -> Int{
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView,numberOfRowsInComponent component:Int)-> Int{
        return pickerDataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if row == 0{
            sgguCd = "1"
        }
        else if row == 1{
            sgguCd = "2"
        }
        else if row == 2{
            sgguCd = "3"
        }else if row == 3{
            sgguCd = "4"
        }else if row == 4{
            sgguCd = "5"
        }else if row == 5{
            sgguCd = "6"
        }else if row == 6{
            sgguCd = "7"
        }else if row == 7{
            sgguCd = "8"
        }else if row == 8{
            sgguCd = "31"
        }else if row == 9{
            sgguCd = "32"
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        // Do any additional setup after loading the view.
    }
    
    
}

