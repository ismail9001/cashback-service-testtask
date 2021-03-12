//
//  MainTableViewController.swift
//  Test Task
//
//  Created by macbook on 10.02.2021.
//

import UIKit
import CoreData

class MainTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var dataTable: UITableView!
    
    let dataService = DataService()
    let imageService = ImageService()
    var data: [TestData] = [] {
        didSet {
            self.dataTable.reloadData()
        }
    }
    lazy var repository = Repository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewData()
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainTableViewCell
        let cellData = data[indexPath.row]
        cell.cellTitle.text = cellData.title
        imageService.getImageFromCache(imageName: nil, imageUrl: cellData.thumbnailUrl, uiImageView: cell.cellImage)
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let controller = segue.destination as? DetailInformationViewController,
              let indexPath = dataTable.indexPathForSelectedRow
        else { return }
        let selectedData = data[indexPath.row]
        controller.titleText = selectedData.title
        controller.urlText = selectedData.url
    }
    
    // MARK: - Functions
    
    func getNewData() {
        repository.observe = { [weak self] (testData) in
            self?.data = testData
        }
        dataService.getData(oldData: data)
    }
}
