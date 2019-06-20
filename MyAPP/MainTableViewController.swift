//
//  HospitalTableViewController.swift
//  HospitalMap
//
//  Created by kpugame on 22/04/2019.
//  Copyright © 2019 kpugame. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController, XMLParserDelegate {
    
    @IBOutlet var tbData: UITableView!
    
    var hospitalname=""
    var hospitalname_utf8 = ""
    
    var url : String?
    var url2 : String?
    
    var area : String = ""
    
    var parser = XMLParser()
    
    var posts = NSMutableArray()
    
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var title1 = NSMutableString()
    var addr = NSMutableString()
    
    var contentsID = NSMutableString()
    
    var imageurl1 = NSMutableString()
    var imageurl2 = NSMutableString()
    
    var urlimage1 : String?
    var urlimage2 : String?
    
    override func viewDidLoad() {
        beginParsing()
        super.viewDidLoad()
    }
    
    
    func beginParsing(){
        posts = []
        let openurl = url
        parser = XMLParser(contentsOf: (URL(string: openurl!))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
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
            contentsID = NSMutableString()
            contentsID = ""
            imageurl1 = NSMutableString()
            imageurl1 = ""
            imageurl2 = NSMutableString()
            imageurl2 = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "title"){
            title1.append(string)
        }else if element.isEqual(to: "addr"){
            addr.append(string)
        }
        else if element.isEqual(to: "firstimage"){
            imageurl1.append(string)
        }
        else if element.isEqual(to: "firstimage2"){
            imageurl2.append(string)
        }
        else if element.isEqual(to: "contentid"){
            contentsID.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "item"){
            if( !title1.isEqual(nil)){
                elements.setObject(title1, forKey: "title" as NSCopying)
            }
            if !addr.isEqual(nil){
                elements.setObject(addr, forKey: "addr" as NSCopying)
            }
            if !imageurl1.isEqual(nil){
                elements.setObject(imageurl1, forKey: "firstimage" as NSCopying)
            }
            if !imageurl2.isEqual(nil){
                elements.setObject(imageurl2, forKey: "firstimage2" as NSCopying)
            }
            if !contentsID.isEqual(nil){
                elements.setObject(contentsID, forKey: "contentid" as NSCopying)
            }
            posts.add(elements)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return posts.count
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "title") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr") as! NSString as String
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell{
            let indexPath = tableView.indexPath(for: cell)
            if segue.identifier == "ToDetail"{
                if let navController = segue.destination as? UINavigationController{
                    if let hospitalTableViewController = navController.topViewController as? DetailView{
                        hospitalTableViewController.imageurl = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "firstimage") as! NSString as String
                        hospitalTableViewController.imageurl2 = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "firstimage2") as! NSString as String
                        hospitalTableViewController.backurl = url
                        hospitalTableViewController.url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailIntro?serviceKey=2JbWDZIHJ7vUfhRi3O566G%2F0uJ8GrrN3IlDBv29Z6B3neQS2lOMJVt6kHEXPJ7Vm7ExmirVqnnlIULdcScuiDQ%3D%3D&numOfRows=10&pageNo=1&MobileOS=ETC&MobileApp=AppTest&contentId=" + ((posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "contentid") as! NSString as String) as String + "&contentTypeId=12"
                        
                        hospitalTableViewController.area = area
                        print(area)
                        
                    }
                }
            }
        }
    }
}
