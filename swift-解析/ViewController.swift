//
//  ViewController.swift
//  swift-解析
//
//  Created by 区块国际－yin on 16/10/9.
//  Copyright © 2016年 区块国际－yin. All rights reserved.
//

import UIKit
import SwiftyJSON


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func request(_ sender: AnyObject) {
        //数据请求
        let param = ["password":"yin123456789","username":"R8yinyu"]
        let data = try! JSONSerialization.data(withJSONObject: param, options: JSONSerialization.WritingOptions.prettyPrinted)
        var string = "json="
        let Str = String(data: data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
        string = string + Str!
        print(string)
        let Url = URL.init(string: "http://facaiyoudao.com/api/user/login")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 30
        request.httpMethod = "POST"
        request.httpBody = string.data(using: String.Encoding.utf8)
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                return
            }
            else {
                let json: Any = try! JSONSerialization.jsonObject(with: data!, options: [])
                if let value = JSON(json)["status"].string {
                    print("状态是：\(value)")
                }
                print(json)
            }
        }
        dataTask.resume()
        }
}

