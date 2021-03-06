//
//  YelpClient.swift
//  Yelp
//
//  Created by Zheng Wu on 4/17/15.
//  Copyright (c) 2015 Zheng Wu. All rights reserved.
//

import UIKit

class YelpClient: BDBOAuth1RequestOperationManager {
    var accessToken: String!
    var accessSecret: String!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(consumerKey key: String!, consumerSecret secret: String!, accessToken: String!, accessSecret: String!) {
        self.accessToken = accessToken
        self.accessSecret = accessSecret
        var baseUrl = NSURL(string: "http://api.yelp.com/v2/")
        super.init(baseURL: baseUrl, consumerKey: key, consumerSecret: secret);
        
        var token = BDBOAuth1Credential(token: accessToken, secret: accessSecret, expiration: nil)
        self.requestSerializer.saveAccessToken(token)
    }
    
   func searchWithTerm(term: String, params: NSDictionary, success: (AFHTTPRequestOperation!, AnyObject!) -> Void, failure: (AFHTTPRequestOperation!, NSError!) -> Void) -> AFHTTPRequestOperation! {
        // For additional parameters, see http://www.yelp.com/developers/documentation/v2/search_api
        var defaults = ["term": term, "ll": "37.42643, -122.16712"]
        var allParameters:NSMutableDictionary = (defaults as NSDictionary).mutableCopy() as NSMutableDictionary
        if (params.count > 0) {
            allParameters.addEntriesFromDictionary(params)
        }
        //println("all parameters: \(allParameters)")
        return self.GET("search", parameters: allParameters, success: success, failure: failure)
    }
    
}
