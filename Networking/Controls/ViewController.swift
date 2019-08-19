//
//  ViewController.swift
//  Networking
//
//  Created by RomaDUlbich on 8/7/19.
//  Copyright © 2019 Oleg1. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
    var galleries = [Gallery]()
    let client = NetworkClient()
    
    
    
    
    override func viewDidLoad() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        super.viewDidLoad()
        
   
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let url = URL(string: "https://api.imgur.com/3/gallery/search/?q=\(searchBar.text!)")!
        
        searchBar.resignFirstResponder()
        print("yes")
        client.fetchImages(url, completion: { (gallery) in
            self.galleries = gallery.data
            self.tableView.reloadData()
        })
        
    }
    
    
    
    
    
    
    func jsonQuery(){
        /*
        var defSession = URLSession.shared
        let urlReq = URL(string: "https://api.imgur.com/3/gallery/top/viral/1")!
        var request = URLRequest(url: urlReq)
        request.setValue("Client-ID 3974f835c77d0ef", forHTTPHeaderField: "Authorization")
        
        
        
        let task = defSession.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            guard error == nil else{
                return
            }
            guard let data = data else{
                return
            }
            
            do{         
                
                
                let parseResult = try JSONDecoder().decode(Galleries.self, from: data)
                
             
                self.galleries = parseResult.data
                print(parseResult)
                print(self.galleries.count)
                print(self.galleries.last)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
 
                
            }
            catch DecodingError.dataCorrupted(let context){
                print(context)
            }
            catch {
                print(error)
            }
        })
        
        task.resume()
        */
    }
    
    
    
    
    
    //MARK - Tableview setup
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return galleries.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Text", for: indexPath) as? CustomCell else{
            fatalError()
        }
        
    cell.title.text = galleries[indexPath.row].title
        
        if let urlstring = URL(string: galleries[indexPath.row].images?[0].link ?? ""){
            DispatchQueue.global().async {
                let data = try? Data(contentsOf: urlstring)
                if let data = data{
                    let image = UIImage(data: data)
                    DispatchQueue.main.async {
                        cell.imageDow.image = image
                    }
                }
            }
        }
        
        return cell
        
    }
    
    
    
    
    

}














