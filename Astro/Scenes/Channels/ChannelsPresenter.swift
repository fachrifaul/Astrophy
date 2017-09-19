//
//  ChannelsPresenter.swift
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

protocol ChannelsPresentationLogic
{
    func presentChannels(response: Channels.List.Response)
    func presentChannelMetas(response: Channels.Metadata.Response)
    func presentChannelsError(response: Channels.Error.Response)
}

class ChannelsPresenter: ChannelsPresentationLogic
{
    weak var viewController: ChannelsDisplayLogic?
    
    // MARK: Do something
    
    func presentChannels(response: Channels.List.Response)
    {
        let viewModel = Channels.List.ViewModel(channels: response.channels)
        viewController?.displayChannels(viewModel: viewModel)
    }
    
    func presentChannelMetas(response: Channels.Metadata.Response) {
        let viewModel = Channels.Metadata.ViewModel(metas: response.metas)
        viewController?.displayChannelMetas(viewModel: viewModel)
    }
    
    func presentChannelsError(response: Channels.Error.Response) {
        let viewModel = Channels.Error.ViewModel(message: response.message)
        viewController?.displayChannelsError(viewModel: viewModel)
    }
}
