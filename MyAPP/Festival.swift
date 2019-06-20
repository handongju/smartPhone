//
//  Festival.swift
//  MyAPP
//
//  Created by kpugame on 20/06/2019.
//  Copyright © 2019 kpugame. All rights reserved.
//



import UIKit

class Festival: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {
    
    var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=2JbWDZIHJ7vUfhRi3O566G%2F0uJ8GrrN3IlDBv29Z6B3neQS2lOMJVt6kHEXPJ7Vm7ExmirVqnnlIULdcScuiDQ%3D%3D&numOfRows=30&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=B&listYN=Y&areaCode="
    
    var area: String = "1"
    var date1: String = "&eventStartDate=20190620"
    
    @IBOutlet var tbData: UITableView!
    
    var parser = XMLParser()
    
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var title1 = NSMutableString()
    var addr = NSMutableString()
    var date2 = NSMutableString()
    
    var date3 = NSMutableString()
    
    
    override func viewDidLoad() {
        
        
        beginParsing()
        super.viewDidLoad()
    }
    
    
    func beginParsing(){
        posts = []
        url = url + area + date1
        parser = XMLParser(contentsOf: (URL(string: url))!)!
        print(url)
        parser.delegate = self
        parser.parse()
        tbData.dataSource = self
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,attributes attributeDict: [String : String])
    {
        
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item"){
            elements = NSMutableDictionary()
            elements = [:]
            title1 = NSMutableString()
            title1 = ""
            addr = NSMutableString()
            addr = ""
            date2 = NSMutableString()
            date2 = ""
            date3 = NSMutableString()
            date3 = ""
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "title"){
            title1.append(string)
        }else if element.isEqual(to: "addr1"){
            addr.append(string)
        }
        else if element.isEqual(to: "eventstartdate"){
            date2.append(string)
        }
        else if element.isEqual(to: "eventenddate"){
            date3.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "item"){
            if( !title1.isEqual(nil)){
                elements.setObject(title1, forKey: "title" as NSCopying)
            }
            if !addr.isEqual(nil){
                elements.setObject(addr, forKey: "addr1" as NSCopying)
            }
            if !date2.isEqual(nil){
                elements.setObject(date2, forKey: "eventstartdate" as NSCopying)
            }
            if !date3.isEqual(nil){
                elements.setObject(date3, forKey: "eventenddate" as NSCopying)
            }

            posts.add(elements)
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ccCell", for: indexPath)
        cell.textLabel?.text = ((posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String)
        
        cell.detailTextLabel?.numberOfLines = 2
        
        cell.detailTextLabel?.text = "위치: " + ((posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr1") as! NSString as String) + "\n행사 일정: " + ((posts.object(at: indexPath.row) as AnyObject).value(forKey: "eventstartdate") as! NSString as String) + " ~ " + ((posts.object(at: indexPath.row) as AnyObject).value(forKey: "eventenddate") as! NSString as String)
        return cell
    }
}
