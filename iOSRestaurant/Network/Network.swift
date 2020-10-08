//
//  Network.swift
//  iOSRestaurant
//
//  Created by 許自翔 on 2020/10/3.
//

import Foundation
import UIKit

class Network{
    
    static let shared = Network()
    let Geturl = URL(string: "https://api.openbrewerydb.org/breweries")
    let Likeurl = URL(string: "https://sheetdb.io/api/v1/q5xzqpddkdsmm")
    
    
    /*取得全部資料*/
    func getRestaurant (completion: @escaping ([Restaurant]) -> Void){
        
        var req = URLRequest(url: Geturl!)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let error = error{
                print("error\(error)")
            }else if let respons = response, let data = data{
                print("respons=\(response)")
                
                if let jsonIn = try? JSONDecoder().decode([Restaurant].self, from: data){
                    completion(jsonIn)
                }
            }
        }.resume()
    }
    
    /*---------------------------------------------------------------------------------------------------*/
    
    
    /*加入我的最愛*/
    func postMyLike(outRestaurant inRestaurant:Restaurant ,completion: @escaping ([String:Int]) -> Void) {
        
        struct keyValue:Encodable{
            let data : Restaurant?
        }
        
        var req = URLRequest(url: Likeurl!)
        req.httpMethod = "POST"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let encoder = JSONEncoder()
        req.httpBody = try? JSONEncoder().encode(keyValue(data: inRestaurant))
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let error = error{
                print("error:\(error.localizedDescription)")
            }else if let response = response,let data = data, let dic = try? JSONDecoder().decode([String:Int].self, from: data){
                print("response:\(response)")
                if dic["created"] != nil{
                    print("成功")
                }else{
                    print("失敗")
                }
            }
        }.resume()
    }
    /*---------------------------------------------------------------------------------------------------*/
    
    /*取得我的最愛*/
    func getMyLike(completion: @escaping ([Restaurant]) -> Void){
        var req = URLRequest(url: Likeurl!)
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Content-Type")
        URLSession.shared.dataTask(with: req) { (data, response, error) in
            if let error = error{
                print("error:\(error.localizedDescription)")
            }else if let response = response,let data = data{
                print("response:\(response)")
                let jsonIn = try! JSONDecoder().decode([Restaurant].self, from: data)
                if let jsonIn = try? JSONDecoder().decode([Restaurant].self, from: data)
                {
                    completion(jsonIn)
                }else{
                    print("fail")
                }
            }
        }.resume()
    }
    /*---------------------------------------------------------------------------------------------------*/
}




