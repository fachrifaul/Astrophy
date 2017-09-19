//
//  ChannelsRouter.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/19/17.
//  Copyright (c) 2017 Ainasoft. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ChannelsRoutingLogic
{
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol ChannelsDataPassing
{
    var dataStore: ChannelsDataStore? { get }
}

class ChannelsRouter: NSObject, ChannelsRoutingLogic, ChannelsDataPassing
{
    weak var viewController: ChannelsViewController?
    var dataStore: ChannelsDataStore?
    
    // MARK: Routing
    
    //func routeToSomewhere(segue: UIStoryboardSegue?)
    //{
    //  if let segue = segue {
    //    let destinationVC = segue.destination as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //  } else {
    //    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    //    let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
    //    var destinationDS = destinationVC.router!.dataStore!
    //    passDataToSomewhere(source: dataStore!, destination: &destinationDS)
    //    navigateToSomewhere(source: viewController!, destination: destinationVC)
    //  }
    //}
    
    // MARK: Navigation
    
    //func navigateToSomewhere(source: ChannelsViewController, destination: SomewhereViewController)
    //{
    //  source.show(destination, sender: nil)
    //}
    
    // MARK: Passing data
    
    //func passDataToSomewhere(source: ChannelsDataStore, destination: inout SomewhereDataStore)
    //{
    //  destination.name = source.name
    //}
}