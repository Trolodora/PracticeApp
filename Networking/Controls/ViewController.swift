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
        //
        searchBar.resignFirstResponder()
        print("yes")
        client.fetchImages(url, completion: { (gallery) in
            self.galleries = gallery.data
            self.tableView.reloadData()
        })
        
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
        cell.imageDow.image = nil
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














