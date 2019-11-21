//
//  Constants.swift
//  AwesomeChuckApp
//
//  Created by Denis Rakitin on 2019-05-30.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//


//файл отвечающий за хранение постоянных значений строки, во избежание описок
import Foundation

//URL`s
let API_URL = "http://www.icndb.com/api/"
let JOKES_URL = "https://api.icndb.com/jokes"
let HEADER = [
    "Content-Type" : "application/json; charset=utf-8"
]


//Notification
let JOKES_LOADED_NOTIF = Notification.Name("Jokes are loaded")
