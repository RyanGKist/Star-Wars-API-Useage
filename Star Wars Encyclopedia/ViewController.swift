//
//  ViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Ryan Kistner on 1/22/18.
//  Copyright © 2018 Ryan Kistner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelOutlet: UILabel!
    
    var recievingFilm: String?
    var recievingName : String?
    var name : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if recievingName != nil {
            StarWarsModel.getAllPeople(completionHandler: {
                data, response, error in
                do{
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let results = jsonResult["results"] {
                            let resultsArray = results as! NSMutableArray
                            for item in resultsArray{
                                let context = item as! NSDictionary
                                if context["name"] as! String == self.recievingName! {
                                    DispatchQueue.main.async {
                                        self.labelOutlet.text = "Name : \(context["name"]!), Gender : \(context["gender"]!), Birth Year : \(context["birth_year"]!), Mass : \(context["mass"]!)"
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            })
        }
        if recievingFilm != nil {
            StarWarsModel.getAllFilms(completionHandler: {
                data, response, error in
                do{
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        if let results = jsonResult["results"] {
                            let resultsArray = results as! NSMutableArray
                            for item in resultsArray{
                                let context = item as! NSDictionary
                                if context["title"] as! String == self.recievingFilm! {
                                    DispatchQueue.main.async {
                                        self.labelOutlet.text = "Title : \(context["title"]!), Release Date : \(context["release_date"]!), Director : \(context["director"]!)"
                                    }
                                }
                            }
                        }
                    }
                } catch {
                    print(error)
                }
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func goBackButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

