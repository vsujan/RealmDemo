//
//  DeveloperTVC.swift
//  RealmIntro
//
//  Created by Sujan Vaidya on 4/11/17.
//  Copyright © 2017 Sujan Vaidya. All rights reserved.
//

import UIKit
import RealmSwift

struct DeveloperInfo {
  static let name = ["Kusal", "Laxman", "Sanjay", "Saugat", "Subash", "Sujan"]
  static let position = ["SSE", "SE", "SE", "SSE", "SSE", "SE"]
  static let workDuration = [2, 1, 1, 2, 2, 1]
}

class DeveloperTVC: UITableViewController {
  
  var results: Results<Developer>!
  var rowCount = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.tableView.isHidden = true
    self.tableView.contentInset.top = 20
    self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    addToDatabase()
    getFromDatabase()
    if results.count > 0 {
      rowCount = results.count
      self.tableView.isHidden = false
      self.tableView.reloadData()
    }
  }
  
  private func addToDatabase() {
    guard  let realm = getRealmInstance() else {
      return
    }
    realm.beginWrite()
    for i in 0..<DeveloperInfo.name.count {
      let developerObject = Developer()
      developerObject.id = i + 1
      developerObject.name = DeveloperInfo.name[i]
      developerObject.position = DeveloperInfo.position[i]
      developerObject.workingSince = DeveloperInfo.workDuration[i]
      realm.add(developerObject, update: true)
    }
    try! realm.commitWrite()
  }
  
  private func getFromDatabase(){
    guard  let realm = getRealmInstance() else {
      return
    }
    results = realm.objects(Developer.self)
    // some filters example you can use
//        results = realm.objects(Developer.self).filter("workingSince >= %@", 2)
//        results = realm.objects(Developer.self).filter("workingSince >= %@ AND name == %@", 1, "Sujan")
//        results = realm.objects(Developer.self).filter("workingSince >= %@ OR name == %@", 2, "Sujan")
  }
  
  private func getRealmInstance() -> Realm? {
    do {
      let realm = try Realm()
      return realm
    } catch let error as NSError {
      // If the encryption key is wrong, `error` will say that it's an invalid database
      fatalError("Error opening realm: \(error)")
    }
  }
  
  // MARK: - Table view data source
  
  //  override func numberOfSections(in tableView: UITableView) -> Int {
  //    // #warning Incomplete implementation, return the number of sections
  //    return 0
  //  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return rowCount
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "developerCell", for: indexPath) as? DeveloperCell else { return UITableViewCell() }
    cell.nameLbl.text = results[indexPath.row].name
    cell.positionLbl.text = results[indexPath.row].position
    cell.durationLbl.text = String(describing: results[indexPath.row].workingSince)
    return cell
  }
  
}
