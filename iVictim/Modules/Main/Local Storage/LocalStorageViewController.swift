//
//  LocalStorageViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 01/06/16.
//
//

import UIKit
import Locksmith
import CoreData

final class LocalStorageViewController: UIViewController {

    let keyForStorage: String = "SensitiveData"
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func _saveWithLocalStorageType(localStorageType: LocalStorageType) {
        
        guard let textToSave: String = textField.text else {return}
        
        switch localStorageType {
        case .NSUserDefaults:
            UserDefaults.standard.set(textToSave, forKey: keyForStorage)
            UserDefaults.standard.synchronize()
        case .Plist:
            let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, .userDomainMask, true)
            let documentDirectory = paths[0]
            let filePath = documentDirectory.appending("/userInfo.plist")
            var plist: [String: AnyObject] = [:]
            plist[keyForStorage] = textToSave as AnyObject
            NSDictionary(dictionary: plist).write(toFile: filePath, atomically: true)
        case .CoreData:
            let appDelegate =
                UIApplication.shared.delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            // try fetch and print
            let employeesFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "CoreDataSensitiveModel")
            
            do {
                let fetchedEmployees = try managedContext.fetch(employeesFetch) as! [CoreDataSensitiveModel]
                fetchedEmployees.forEach {
                    print("\(String(describing: $0.key)): \(String(describing: $0.data))")
                }
            } catch {
                fatalError("Failed to fetch employees: \(error)")
            }
            
            // save
            let coreDataSenestiveMode = NSEntityDescription.insertNewObject(forEntityName: "CoreDataSensitiveModel", into: managedContext) as! CoreDataSensitiveModel
            coreDataSenestiveMode.key = keyForStorage
            coreDataSenestiveMode.data = textToSave

            do {
                try managedContext.save()
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        case .Keychain:
            let dictionary = Locksmith.loadDataForUserAccount(userAccount: "myUserAccount")
            print(dictionary ?? "")
            try! Locksmith.updateData(data: [keyForStorage: textToSave], forUserAccount: "myUserAccount")
        case .Realm:
            var realmModel: RealmSensitiveDataModel
            if let realmSensitiveDataModel = RealmSensitiveDataModel.objectForKey(key: keyForStorage) {
                realmModel = realmSensitiveDataModel
                print("old data: \(realmModel.data)")
            } else  {
                realmModel = RealmSensitiveDataModel()
                realmModel.updateKey(key: keyForStorage)
            }
            realmModel.updateData(data: textToSave)
            print("new data: \(realmModel.data)")
        }
        
        
        UIAlertView(title: "Saved", message: "Data saved in \(localStorageType.rawValue)", delegate: nil, cancelButtonTitle: "Ok").show()
    }
}

extension LocalStorageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalStorageType.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Basic", for: indexPath as IndexPath)
        cell.textLabel?.text = LocalStorageType.items[indexPath.row].rawValue
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        _saveWithLocalStorageType(localStorageType: LocalStorageType.items[indexPath.row])
    }
}

enum LocalStorageType: String {
    
    case NSUserDefaults
    case Plist
    case CoreData
    case Keychain
    case Realm
    
    static var items: [LocalStorageType] {
        return [LocalStorageType.NSUserDefaults, LocalStorageType.Plist, LocalStorageType.CoreData, LocalStorageType.Keychain, LocalStorageType.Realm]
    }
}
