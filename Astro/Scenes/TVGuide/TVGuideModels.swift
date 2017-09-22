//
//  TVGuideModels.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/20/17.
//  Copyright (c) 2017 Ainasoft. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum TVGuide
{
    // MARK: Use cases
    
    enum Channels
    {
        struct Request
        {
            var page = 1
            var startDate = ""
            var endDate = ""
        }
        
        struct Response
        {
            var channels = [ChannelMeta]()
            var currentPage: Int = 1
            var pageCount: Int = 0
            var events = [ChannelEvent]()
        }
        
        struct ViewModel
        {
            var channels = [ChannelMeta]()
            var currentPage: Int = 1
            var pageCount: Int = 0
            var events = [ChannelEvent]()
        }
    }
    
    enum Sort {
        struct Request {
            var ascending = true
            var startDate = ""
            var endDate = ""
        }
    }
}
