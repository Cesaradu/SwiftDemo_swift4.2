//
//  MealTableViewController.swift
//  SwiftTestDemo
//
//  Created by user on 2019/3/25.
//  Copyright © 2019 adu. All rights reserved.
//

import UIKit

class MealTableViewController: UITableViewController {
    
    var meals = [Meal]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //edit button
        navigationItem.leftBarButtonItem = editButtonItem
        
        if let savedMeals = loadMeals() {
            meals += savedMeals
        } else {
            loadSampleMeals()
        }
    }
    
    func loadSampleMeals() {
        let photo1 = UIImage(named: "meal1.jpg")
        let meal1 = Meal(name: "Capress Salad", photo: photo1, rating: 4)
        
        let photo2 = UIImage(named: "meal2.jpg")!
        let meal2 = Meal(name: "Chicken and Potatoes", photo: photo2, rating: 5)!
        
        let photo3 = UIImage(named: "meal3.jpg")!
        let meal3 = Meal(name: "Pasta with Meatballs", photo: photo3, rating: 3)!

        meals = [meal1, meal2, meal3] as! [Meal]
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meals.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "MealTableViewCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! MealTableViewCell

        // Configure the cell...
        let meal = meals[indexPath.row]
        cell.nameLabel.text = meal.name
        cell.photoImageView.image = meal.photo
        cell.ratingControl.rating = meal.rating

        return cell
    }
    
    //保存meal返回列表页面，处理数据
    @IBAction func unwindToMealList(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? MealViewController, let meal = sourceViewController.meal {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                //edit meal
                meals[selectedIndexPath.row] = meal
                tableView.reloadRows(at: [selectedIndexPath as IndexPath], with: .automatic)
            } else {
                //add new meal
                let newIndexPath = NSIndexPath(row: meals.count, section: 0)
                meals.append(meal)
                tableView.insertRows(at: [newIndexPath as IndexPath], with: .automatic)
            }
            
            //保存本地
            saveMeals()
            
        }
    }
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let mealDetailViewController = segue.destination as! MealViewController
            if let selectedMealCell = sender as? MealTableViewCell {
                let indexPath = tableView.indexPath(for: selectedMealCell)!
                let selectedMeal = meals[indexPath.row]
                mealDetailViewController.meal = selectedMeal
            }
        } else if segue.identifier == "AddMeal" {
            print("Adding new meal.")
        } else {
            
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            meals.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        //保存本地
        saveMeals()
    }
    
    
    //NSCoding
    func saveMeals() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: meals, requiringSecureCoding: false)
            do {
                try data.write(to: Meal.ArchiveURL)
            } catch {
                assert(true, "无法把account写入path")
            }
        } catch {
            assert(true, "无法生成归档数据")
        }
    }
    
    func loadMeals() -> [Meal]? {
        do {
            let data = try Data.init(contentsOf: Meal.ArchiveURL)
            do {
                return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Meal]
            } catch {
                assert(true, "用户数据解档失败")
                return nil
            }
        } catch {
            assert(true, "用户数据解档路径错误")
            return nil
        }
    }
 

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    

}
