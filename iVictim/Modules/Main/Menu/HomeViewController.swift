//
//  MenuViewController.swift
//  iVictim
//
//  Created by Azzaro Mujic on 31/05/16.
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//
//  This file was generated by the 🐍 VIPER generator
//

import UIKit

protocol HomeViewControllerOutput {
    func presentBadLogIn()
    func presentLocalStorage()
    func presentBruteForce()
    func presentSSLPinning()
    func presentTransportLayerSecurity()
    func presentCodeInjection()
    func presentPiracyDetection()
    func presentPasteboard()
    func presentScreenshot()
}

final class HomeViewController: UIViewController {
    
    var output: HomeViewControllerOutput!
    
    // MARK: - View lifecycle -
    override func viewDidLoad() {
        super.viewDidLoad() 
    }
}


extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuItem.items.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("BasicCell")!
        cell.textLabel?.text = MenuItem.items[indexPath.row].rawValue
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        switch MenuItem.items[indexPath.row] {
        case .BadLogin:
            output.presentBadLogIn()
        case .LocalStorage:
            output.presentLocalStorage()
        case .BruteForce:
            output.presentBruteForce()
        case .SSLPinning:
            output.presentSSLPinning()
        case .TransportLayerSecurity:
            output.presentTransportLayerSecurity()
        case .CodeInjection:
            output.presentCodeInjection()
        case .PiracyDetection:
            output.presentPiracyDetection()
        case .Pasteboard:
            output.presentPasteboard()
        case .Screenshot:
            output.presentScreenshot()
        }
        
    }
}

enum MenuItem: String {
    case BadLogin
    case LocalStorage = "Local Storage"
    case BruteForce = "Brute Force"
    case TransportLayerSecurity = "Transport Layer Security"
    case SSLPinning = "SSL Pinning"
    case CodeInjection = "Code injection"
    case PiracyDetection = "Piracy detection"
    case Pasteboard = "Pasteboard problem"
    case Screenshot = "Screenshot problem"
    
    static var items: [MenuItem] {
        return [
            MenuItem.BadLogin,
            MenuItem.LocalStorage,
            MenuItem.BruteForce,
            MenuItem.TransportLayerSecurity,
            MenuItem.SSLPinning,
            MenuItem.CodeInjection,
            MenuItem.PiracyDetection,
            MenuItem.Pasteboard,
            MenuItem.Screenshot
        ]
    }
}