//
//  ApiDescriptionVC.swift
//  AwesomeChuckApp
//
//  Created by Denis Rakitin on 2019-05-28.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//

import UIKit
import WebKit

//Контроллер управляющий экраном отображения браузера с загруженной ссылкой, c добавлением протоколов делегирования от браузера и таббара
class ApiDescriptionVC: UIViewController, WKNavigationDelegate, UITabBarDelegate {
    
//    Outlets
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var toolBar: UITabBar!
    
//    Var
    var spinner: UIActivityIndicatorView?
    var screenSize = UIScreen.main.bounds
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        делегирование
        webView.navigationDelegate = self
        toolBar.delegate = self
        
//        добавление адреса URL и загрузка адреса с обработкой ошибок при закгрузке. URL адрес установлен в файле Сonstatnts
        let url = URL(string: API_URL)
        if let unwrappedURL = url {
            
            let request = URLRequest(url: unwrappedURL)
            let session = URLSession.shared
            
            let task = session.dataTask(with: request) { (data, response, error) in
                
                if error == nil {
                    
                    self.webView.load(request)
                    
                } else {
                    print("ERROR: \(error)")
                }
            }
            task.resume()
        }

    }
    
//    функция делегата WebView, которая добаляет спиннер в момент обращения WebView к адресу
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        addSpinner()
    }
    
//     функция делегата WebView, которая удаляет спиннер, как только страница загружена
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        removeSpinner()
    }
    
//    функция делегата ТабБар, которая отвечает за резултат взавимодействия пользователя с кнопками при использовании браузера
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 0 {
//            функция перехода назад страницы
            webView.goBack()
        }
        else if item.tag == 1{
//            функция обновления страницы
            webView.reload()
        } else if item.tag == 2 {
//            функция перехода вперед
            webView.goForward()
        }
    }
    
//    функция добавления спинннера, который отображается при загрузке страницы
    func addSpinner () {
        spinner = UIActivityIndicatorView()
        spinner?.center = CGPoint(x: (screenSize.width/2) - ((spinner?.frame.width)!/2), y: 200)
        spinner?.style = .whiteLarge
        spinner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        spinner?.startAnimating()
       webView.addSubview(spinner!)
    }
    
//    функция удаления спиннера, если страница была загружена
    func removeSpinner() {
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }


}

