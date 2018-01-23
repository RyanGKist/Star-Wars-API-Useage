//
//  MainTableVC.swift
//  Star Wars Encyclopedia
//
//  Created by Ryan Kistner on 1/22/18.
//  Copyright © 2018 Ryan Kistner. All rights reserved.
//

import UIKit

class MainTableVC: UITableViewController {
    
    var people = [String]()
    var holder : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        StarWarsModel.getAllPeople(completionHandler: {
            data, response, error in
            do{
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! NSMutableArray
                        for item in resultsArray{
                            let context = item as! NSDictionary
                            self.people.append(context.value(forKey: "name") as! String)
                        }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            } catch {
                print(error)
            }
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = people[indexPath.row]
        cell.tag = 1
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        holder = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail"{
            let destination = segue.destination as! ViewController
            destination.recievingName = people[holder!]
            print(people[holder!])
        }
    }
}
