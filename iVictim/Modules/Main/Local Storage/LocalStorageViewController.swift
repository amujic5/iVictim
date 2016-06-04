//
//  LocalStorageViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 01/06/16.
//
//

import UIKit
import CoreData

final class LocalStorageViewController: UIViewController {

    let keyForStorage: String = "SensitiveData"
    
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func _saveWithLocalStorageType(localStorageType: LocalStorageType) {
        
        guard let textToSave: String = textField.text else {return}
        
        switch localStorageType {
        case .NSUserDefaults:
            NSUserDefaults.standardUserDefaults().setObject(textToSave, forKey: keyForStorage)
            NSUserDefaults.standardUserDefaults().synchronize()
        case .Plist:
            let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, .UserDomainMask, true)
            let documentDirectory = paths[0]
            let filePath = documentDirectory.stringByAppendingString("/userInfo.plist")
            var plist: [String: AnyObject] = [:]
            plist[keyForStorage] = textToSave
            NSDictionary(dictionary: plist).writeToFile(filePath, atomically: true)
        case .CoreData:
            let appDelegate =
                UIApplication.sharedApplication().delegate as! AppDelegate
            
            let managedContext = appDelegate.managedObjectContext
            
            // try fetch and print
            let employeesFetch = NSFetchRequest(entityName: "CoreDataSensitiveModel")
            
            do {
                let fetchedEmployees = try managedContext.executeFetchRequest(employeesFetch) as! [CoreDataSensitiveModel]
                fetchedEmployees.forEach {
                    print("\($0.key): \($0.data)")
                }
            } catch {
                fatalError("Failed to fetch employees: \(error)")
            }
            
            // save
            let coreDataSenestiveMode = NSEntityDescription.insertNewObjectForEntityForName("CoreDataSensitiveModel", inManagedObjectContext: managedContext) as! CoreDataSensitiveModel
            coreDataSenestiveMode.key = keyForStorage
            coreDataSenestiveMode.data = textToSave

            do {
                try managedContext.save()
                
            } catch let error as NSError  {
                print("Could not save \(error), \(error.userInfo)")
            }
            
        case .Keychain:
            if let oldValue = KeychainWrapper.standardKeychainAccess().stringForKey(keyForStorage) {
               print("old value in keychain: \(oldValue)")
            }
            
            let saveSuccessful: Bool = KeychainWrapper.standardKeychainAccess().setString(textToSave, forKey: keyForStorage)
            print("save \(textToSave) in keychain = \(saveSuccessful)")
        }
        
        
        UIAlertView(title: "Saved", message: "Data saved in \(localStorageType.rawValue)", delegate: nil, cancelButtonTitle: "Ok").show()
    }
}

extension LocalStorageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalStorageType.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Basic", forIndexPath: indexPath)
        cell.textLabel?.text = LocalStorageType.items[indexPath.row].rawValue
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        _saveWithLocalStorageType(LocalStorageType.items[indexPath.row])
    }
}

extension LocalStorageViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

enum LocalStorageType: String {
    
    case NSUserDefaults
    case Plist
    case CoreData
    case Keychain
    
    static var items: [LocalStorageType] {
        return [LocalStorageType.NSUserDefaults, LocalStorageType.Plist, LocalStorageType.CoreData, LocalStorageType.Keychain]
    }
}