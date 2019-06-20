//
//  DetailView.swift
//  MyAPP
//
//  Created by kpugame on 03/06/2019.
//  Copyright © 2019 kpugame. All rights reserved.
//

import UIKit

class DetailView: UIViewController, UITableViewDelegate, UITableViewDataSource, XMLParserDelegate,  UIScrollViewDelegate{
    
    @IBOutlet var tbData: UITableView!
    @IBOutlet var scrollView : UIScrollView!
    var backurl: String?
    
    var url : String?
    var area : String = "1"
    var imageurl : String?
    var imageurl2 : String?
        
        var parser = XMLParser()
        
        var postsName : [String] = ["전화번호","휴일","입장시간","유모차대여정보","신용카드 사용여부","애완동물 동반여부"]
        var posts : [String] = ["","","","","",""]
        
        var element = NSString()
        
        var infocenter = NSMutableString()
        var restdate = NSMutableString()
        var usetime = NSMutableString()
    
    var chkbabycarriage = NSMutableString()
    
    var chkcreditcard = NSMutableString()
    
    var chkpet = NSMutableString()
        
        
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let urlimage = URL(string: imageurl!)
            do{
                let data = try Data(contentsOf: urlimage!)
                var image = UIImage(data: data) as! UIImage
                pageImages.append(image)
            }catch let err{
                print("error")
            }
            
            let urlimage2 = URL(string: imageurl2!)
            do{
                let data2 = try Data(contentsOf: urlimage2!)
                var image2 = UIImage(data: data2) as! UIImage
                pageImages.append(image2)
            }catch let err{
                print("error")
            }
            
            let pageCount = pageImages.count
            
            pageControl.currentPage = 0
            pageControl.numberOfPages = pageCount
            
            for _ in 0..<pageCount {
                pageViews.append(nil)
            }
            
            let pagesScrollViewSize = scrollView.frame.size
            scrollView.contentSize = CGSize(width: pagesScrollViewSize.width*CGFloat(pageImages.count), height: pagesScrollViewSize.height)
            
            loadVisiblePages()
            
            
            beginParsing()
        }
        
        
        func beginParsing(){
            posts = []
            parser = XMLParser(contentsOf: (URL(string: url!))!)!
            parser.delegate = self
            parser.parse()
            tbData.dataSource = self
        }
        
        func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?,attributes attributeDict: [String : String])
        {
            element = elementName as NSString
            if(elementName as NSString).isEqual(to: "item"){
                posts = ["","","","","",""]
                infocenter = NSMutableString()
                infocenter = ""
                usetime = NSMutableString()
                usetime = ""
                restdate = NSMutableString()
                restdate = ""
                chkbabycarriage = NSMutableString()
                chkbabycarriage = ""
                chkcreditcard = NSMutableString()
                chkcreditcard = ""
                chkpet = NSMutableString()
                chkpet = ""
                
            }
        }
        
        func parser(_ parser: XMLParser, foundCharacters string: String) {
            if element.isEqual(to: "infocenter"){
                infocenter.append(string)
            }else if element.isEqual(to: "usetime"){
                usetime.append(string)
            }else if element.isEqual(to: "restdate"){
                restdate.append(string)
            }else if element.isEqual(to: "chkbabycarriage"){
                chkbabycarriage.append(string)
            }else if element.isEqual(to: "chkcreditcard"){
                chkcreditcard.append(string)
            }
            else if element.isEqual(to: "chkpet"){
                chkpet.append(string)
            }
        }
        
        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
            if(elementName as NSString).isEqual(to: "item"){
                if( !infocenter.isEqual(nil)){
                    posts[0] = infocenter as String
                }
                if( !usetime.isEqual(nil)){
                    posts[1] = usetime as String
                }
                if( !restdate.isEqual(nil)){
                    posts[2] = restdate as String
                }
                if( !chkbabycarriage.isEqual(nil)){
                    posts[3] = chkbabycarriage as String
                }
                if( !chkcreditcard.isEqual(nil)){
                    posts[4] = chkcreditcard as String
                }
                if( !chkpet.isEqual(nil)){
                    posts[5] = chkpet as String
                }
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
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailCell", for: indexPath)
            cell.textLabel?.text = postsName[indexPath.row]
            cell.detailTextLabel?.text = posts[indexPath.row]
            return cell
        }
    
    @IBOutlet var pageControl: UIPageControl!
    
    var pageImages: [UIImage] = []
    
    var pageViews: [UIImageView?] = []
    
    func loadVisiblePages() {
        let pageWidth = scrollView.frame.width
        let page = Int(floor((scrollView.contentOffset.x * 2.0 + pageWidth) / (pageWidth * 2.0)))
        
        pageControl.currentPage = page
        let firstPage = page - 1
        let lastPage = page + 1
        
        for index in 0 ..< firstPage+1{
            purgePage(index)
        }
        
        for index in firstPage ... lastPage{
            loadPage(index)
        }
        
        for index in lastPage+1 ..< pageImages.count+1{
            purgePage(index)
        }
    }
    
    
    func scrollViewDidScroll(_ scorollView: UIScrollView){
        
        loadVisiblePages()
    }
    
    
    func loadPage(_ page: Int){
        if page < 0 || page >= pageImages.count{
            return
        }
        if pageViews[page] != nil{
        }else{
            var frame = scrollView.bounds
            frame.origin.x = frame.size.width * CGFloat(page)
            frame.origin.y = 0.0
            
            let newPageView = UIImageView(image: pageImages[page])
            newPageView.contentMode = .scaleAspectFit
            newPageView.frame = frame
            scrollView.addSubview(newPageView)
        }
    }
    func purgePage(_ page: Int){
        if page < 0 || page >= pageImages.count{
            return
        }
        if let pageView = pageViews[page]{
            pageView.removeFromSuperview()
            pageViews[page] = nil
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "back"{
            if let navController = segue.destination as? UINavigationController{
                if let hospitalTableViewController = navController.topViewController as? MainTableViewController{
                    hospitalTableViewController.url = backurl
                }
            }
        }
        
        if segue.identifier == "Send"{
            if let navController = segue.destination as? UIViewController{
                if let cont = navController as? MidViewController{
                    cont.area = area
                    print(area)
                }
            }
        }
    }
    
    
}
