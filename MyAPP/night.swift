//
//  night.swift
//  MyAPP
//
//  Created by kpugame on 20/06/2019.
//  Copyright © 2019 kpugame. All rights reserved.
//

import UIKit

class night: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate {
    
    var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchStay?serviceKey=2JbWDZIHJ7vUfhRi3O566G%2F0uJ8GrrN3IlDBv29Z6B3neQS2lOMJVt6kHEXPJ7Vm7ExmirVqnnlIULdcScuiDQ%3D%3D&numOfRows=20&pageNo=1&MobileOS=ETC&MobileApp=AppTest&arrange=B&listYN=Y&areaCode="
    
     var area: String = "1"
    
    @IBOutlet var tbData: UITableView!
    
    var parser = XMLParser()
    
    var postsName = ["숙박시설 이름","주소"]
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var title1 = NSMutableString()
    var addr = NSMutableString()
    
    
    override func viewDidLoad() {
        
        
        beginParsing()
        super.viewDidLoad()
    }
    
    
    func beginParsing(){
        posts = []
        url = url + area
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
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "title"){
            title1.append(string)
        }else if element.isEqual(to: "addr1"){
            addr.append(string)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ddCell", for: indexPath)
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr1") as! NSString as String
        return cell
    }
    
}
