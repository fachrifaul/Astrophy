//
//  ChannelsWorker.swift
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
import Alamofire
import SwiftyJSON

class ChannelsWorker
{
    enum ChannelsResponse {
        case success(channels: [Channel])
        case error(message: String)
    }
    
    enum ChannelMetaResponse {
        case success(channels: [ChannelMeta])
        case error(message: String)
    }
    
    func fetchChannels(onCompletionHandler: ((ChannelsResponse)->Void)?)
    {
        NetworkManager.shared.get(url: ApiConstants.channelList,
                                  params: nil,
                                  headers: nil) { (response) in
                                    
                                    switch response {
                                    case .Success(let result):
                                        var channels = [Channel]()
                                        channels = self.transformJsonToChannels(result)
                                        onCompletionHandler?(ChannelsResponse.success(channels: channels))
                                        
                                    case .Error( _, let message):
                                        onCompletionHandler?(ChannelsResponse.error(message: message))
                                    }
        }
    }
    
    func fetchChannelMetas(ids: String, onCompletionHandler: ((ChannelMetaResponse)->Void)?)
    {
        let url = "\(ApiConstants.channelMetas)?channelId=\(ids)"
        NetworkManager.shared.get(url: url,
                                  params: nil,
                                  headers: nil) { (response) in

                                    switch response {
                                    case .Success(let result):
                                        var channels = [ChannelMeta]()
                                        channels = self.transformJsonToChannelMeta(result)
                                        onCompletionHandler?(ChannelMetaResponse.success(channels: channels))
                                        
                                    case .Error( _, let message):
                                        onCompletionHandler?(ChannelMetaResponse.error(message: message))
                                    }
        }
    }
}

// Transform Data extension

extension ChannelsWorker {
    
    fileprivate func transformJsonToChannels(_ json: JSON) -> [Channel] {
        
        var channels = [Channel]()
        
        if let channelJsonArray = json["channels"].array {
            
            for channelJson in channelJsonArray {
                
                let channel = Channel()
                if let channelId = channelJson["channelId"].int {
                    channel.id = channelId
                }
                
                if let channelTitle = channelJson["channelTitle"].string {
                    channel.title = channelTitle
                }
                
                if let channelStubNumber = channelJson["channelStbNumber"].int {
                    channel.stubNumber = channelStubNumber
                }
                
                channels += [channel]
            }
        }
        
        return channels
    }
    
    fileprivate func transformJsonToChannelMeta(_ json: JSON) -> [ChannelMeta] {
        
        var channels = [ChannelMeta]()
        
        if let channelJsonArray = json["channel"].array {
            
            for channelJson in channelJsonArray {
                
                let meta = ChannelMeta()
                if let channelId = channelJson["channelId"].int {
                    meta.channelId = String(channelId)
                }
                
                if let siChannelId = channelJson["siChannelId"].string {
                    meta.siChannelId = siChannelId
                }
                
                if let channelTitle = channelJson["channelTitle"].string {
                    meta.channelTitle = channelTitle
                }
                
                if let channelDescription = channelJson["channelDescription"].string {
                    meta.channelDescription = channelDescription
                }
                
                if let channelLanguage = channelJson["channelLanguage"].string {
                    meta.channelLanguage = channelLanguage
                }
                
                if let channelCategory = channelJson["channelCategory"].string {
                    meta.channelCategory = channelCategory
                }
                
                if let channelStubNumber = channelJson["channelStbNumber"].string {
                    meta.channelStubNumber = channelStubNumber
                }
                
                if let extRefArray = channelJson["channelExtRef"].array {
                    
                    for extRefJson in extRefArray {
                        
                        let extRef = ChannelExtRef()
                        
                        if let system = extRefJson["system"].string {
                            extRef.system = system
                        }
                        
                        if let subSystem = extRefJson["subSystem"].string {
                            extRef.subSystem = subSystem
                        }
                        
                        if let value = extRefJson["value"].string {
                            extRef.value = value
                        }
                        
                        meta.extRef += [extRef]
                        
                    }
                }
                
                channels += [meta]
            }
        }
        
        return channels
    }
}
