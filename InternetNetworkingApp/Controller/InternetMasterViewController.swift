//
//  InternetMasterViewController.swift
//  InternetNetworkingApp
//
//  Created by Porter, Tyler on 1/8/20.
//  Copyright © 2020 CTEC. All rights reserved.
//

import UIKit

class InternetMasterViewController: UITableViewController
{
    //MARK:- Date members
    
    weak var delegate : InternetDetailDelegate?
    
    private lazy var pdfTopics : [String] = [String]()
    private lazy var internetTopics : [String] = [String]()
    private lazy var addresses : [String] = [String]()
    private lazy var files : [String] = [String]()
    private let rowIdentifier : String = "internetRow"
    
    //MARK:- Helper methods
    
    private func setupDetailContents() -> Void
    {
        internetTopics = [
        "Standard Search Engine",
        "AP CSP",
        "Canyons District",
        "CTEC",
        "Social Media",
        ]
        
        files = [
        "demo",
        "demo",
        "demo"
        ]
        
        //Same names as PDF files
        pdfTopics = [
        "ImpactUrls",
        "TopicTerms",
        "MealDeliveringRobots"
        ]
        
        //Same # of entries as internetTopics
        addresses = [
        "https://google.com/",
        "https://apstudents.collegeboard.org/courses/ap-computer-science-principles",
        "https://www.canyonsdistrict.org/",
        "https://ctec.canyonsdistrict.org/",
        "https://twitter.com/"
        ]
    }
    
    //MARK:- Lifecycle
    
    override func viewDidLoad() -> Void
    {
        super.viewDidLoad()
        setupDetailContents()
        self.clearsSelectionOnViewWillAppear = false
    }
    
    //MARK:- Handle interaction with the TableView
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: indexPath) -> UITableViewCell
    {
        /*Unlike our previous tableview we are not making a custom subclass,
         just adding text to the default view based on the contents of the lists.
         */
        let cell = tableView.dequeueReusableCell(withIdentifier: rowIdentifier, for: IndexPath)
        
        cell.textLabel?.textAlignment = .center
        
        if (indexPath.section == 0)
        {
            cell.textLabel?.text = pdfTopics(indexPath.row)
        }
        else
        {
            cell.textLabel?.text = internetTopics(indexPath.row)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void
    {
        let currentTopic : String
        let currentAddress : String
        
        if (indexPath.section == 0)
        {
            currentTopic = pdfTopics[indexPath.row]
            currentAddress = files[indexPath.row]
        }
            
        else
        {
            currentTopic = internetTopics[indexPath.row]
            currentAddress = addresses[indexPath.row]
        }
        
        delegate?.dataUpdate(title: currentTopic, address: currentAddress)
        
        //MARK: Load a view without a segue
        
        if let detailViewController = delegate as? InternetDetailViewController
        {
            splitViewController?.showDetailViewController(detailViewController, sender: nil)
        }
    }
    
    //MARK:- Handle section headers
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    {
        if (section == 0)
        {
            return "PDF Reports"
        }
        return "Internet Information"
    }

    //MARK:- Table view data source methods

    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (section == 0)
        {
            return pdfTopics.count
        }
        else
        {
            return internetTopics.count
        }
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    //MARK:- Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

protocol InternetDetailDelegate : class
{
       func dataUpdate(title: String, address: String) -> Void
}
