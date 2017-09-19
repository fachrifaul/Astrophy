//
//  ChannelsViewController.swift
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
import RxSwift
import RxCocoa
import SnapKit

protocol ChannelsDisplayLogic: class
{
    func displayChannels(viewModel: Channels.List.ViewModel)
    func displayChannelMetas(viewModel: Channels.Metadata.ViewModel)
    func displayChannelsError(viewModel: Channels.Error.ViewModel)
}

class ChannelsViewController: UIViewController, ChannelsDisplayLogic
{
    var interactor: ChannelsBusinessLogic?
    var router: (NSObjectProtocol & ChannelsRoutingLogic & ChannelsDataPassing)?
    
    var tableView: UITableView!
    
    var displayedChannels = Variable([Channel]()) // Not used for now
    var displayedMetas = Variable([ChannelMeta]())
    
    let disposeBag = DisposeBag()
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = ChannelsInteractor()
        let presenter = ChannelsPresenter()
        let router = ChannelsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    private func setupUI() {
        
        // We used hardcoded UI, because Xcode 8.3.3 has bug with top layout constraint on interface builder
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.snp.remakeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        tableView.tableHeaderView = UIView(frame: CGRect.zero)
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
    private func setupBindings() {
        
        // Bind out displayed channels to the tableview
        displayedMetas.asObservable()
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "Cell", cellType: UITableViewCell.self)
            ) { (index, meta, cell) in
                
                cell.textLabel?.text = meta.channelTitle
                
            }   
            .disposed(by: disposeBag)
        
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        setupUI()
        
        setupBindings()
        fetchChannels()
        
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func fetchChannels()
    {
        let request = Channels.List.Request()
        interactor?.fetchChannels(request: request)
    }
    
    func displayChannels(viewModel: Channels.List.ViewModel)
    {
        displayedChannels.value = viewModel.channels
        
        print("Channels: \(displayedChannels)")
    }
    
    func displayChannelMetas(viewModel: Channels.Metadata.ViewModel)
    {
        displayedMetas.value = viewModel.metas
        
        print("Channels Metas: \(displayedMetas.value.count)")
    }
    
    func displayChannelsError(viewModel: Channels.Error.ViewModel) {
        // TODO: display error
    }
}
