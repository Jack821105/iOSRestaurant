//
//  Restaurant.swift
//  iOSRestaurant
//
//  Created by 許自翔 on 2020/10/3.
//

import Foundation

struct Restaurant:Codable {
    
    let name:String
    let brewery_type:String
    let street:String
    let city:String
    let state:String
    let country:String
    let longitude:String
    let latitude:String
    let website_url:String
    let updated_at:String
    let phone:String
    
}


/*
 "id": 2,
 "name": "Avondale Brewing Co",
 "brewery_type": "micro",
 "street": "201 41st St S",
 "city": "Birmingham",
 "state": "Alabama",
 "postal_code": "35222-1932",
 "country": "United States",
 "longitude": "-86.774322",
 "latitude": "33.524521",
 "phone": "2057775456",
 "website_url": "http://www.avondalebrewing.com",
 "updated_at": "2018-08-23T23:19:57.825Z"
 */
