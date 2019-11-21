//
//  ChuckJokesVC.swift
//  AwesomeChuckApp
//
//  Created by Denis Rakitin on 2019-05-28.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//

import UIKit

class ChuckJokesVC: UIViewController {
    
//    Outlets
    @IBOutlet weak var numberOfLoadJokesLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loadButton: UIButton!
    
//    var
//    переменная которая хранит введенное пользователем количество шуток для отображения
    var numberOfJOkes: Int?
    
//    переменные для реализации спиннера, которые показывается на время подгрузки значений общего количества шуток
    var spinner: UIActivityIndicatorView?
    var screenSize = UIScreen.main.bounds
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        реализация делегирования таблицы, установка параметров отображения таблицы
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
//        кнопка вызывющая окно ввода количества шуток для ввода блокируется, пока не будет загружена информация об общем количестве шуток, для избежания ввода большего количества шуток, чем предоставляет API
        loadButton.isEnabled = false
        
//      добавление на экран программно созданного спиннера до того момента, пока не будет успешно реализована фунция получения информации об общем количестве шуток
        addSpinner()

//        вызов функции получения общего количества шуток, при успешном получения, разблокируется кнопка вызова экрана ввода количества загружаемых шуток и с основного экрана убирается спиннер
        JokeService.instance.getTotalNumberOfJokes { (success) in
            if success {
                self.loadButton.isEnabled = true
                self.removeSpinner()

            }
        }
        
//        Наблюдатель, котороый ждет сообщения с экрана вводе количества шуток и нажатии кнопки загрузки. При получении сообщения вызывает функцию func jokesAreLoaded(), которая перезагружает таблицу и изменяет лэйбл в зависимости от введенного количества шуток
        NotificationCenter.default.addObserver(self, selector: #selector(ChuckJokesVC.jokesAreLoaded), name: JOKES_LOADED_NOTIF, object: nil)
        
    }
    
    @objc func jokesAreLoaded() {
        numberOfJOkes = JokeService.instance.jokes.count
        if numberOfJOkes! > 1 {
            numberOfLoadJokesLbl.text = "\(numberOfJOkes!) jokes were loaded"
        } else if numberOfJOkes! == 1 {
            numberOfLoadJokesLbl.text = "1 joke was loaded"
        } else {
            numberOfLoadJokesLbl.text = "Press button to load joke"
        }
        tableView.reloadData()
    }
    
    
//    кнопка, котороая при нажатии создает экземпляр EnterNumOfJokesVC() и  отображающет его поверх экрана с таблицей.
    @IBAction func loadBtnPressed(_ sender: Any) {
        let numberSelector = EnterNumOfJokesVC()
        numberSelector.modalPresentationStyle = .custom
        present(numberSelector, animated: true, completion: nil)
    }
    
    //    функция добавления спиннера
    func addSpinner () {
        spinner = UIActivityIndicatorView()
        spinner?.center = CGPoint(x: (screenSize.width/2) - ((spinner?.frame.width)!/2), y: 200)
        spinner?.style = .whiteLarge
        spinner?.color = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        spinner?.startAnimating()
        tableView.addSubview(spinner!)
    }
    
    //    функция удаления спиннера
    func removeSpinner() {
        
        if spinner != nil {
            spinner?.removeFromSuperview()
        }
    }
}


//Реализация функционала таблиц в виде расширения класса ChuckJokesVC
extension ChuckJokesVC: UITableViewDelegate, UITableViewDataSource {
    
//    устанавливает количество строк в таблице
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return JokeService.instance.jokes.count
    }
    
//    фунция делегата, создающая ячейку таблицы на основаниия идентификатора ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "jokeCell", for: indexPath) as? JokeCell else { return UITableViewCell() }
//        функция конфигурирования конкретной ячейки на основании массива храняшегося в JokeService
        cell.configureCell(joke: JokeService.instance.jokes[indexPath.row])
        let orderNumber: Int = indexPath.row
        
        if orderNumber % 2 == 0 {
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0.2572506421)
        } else {
            cell.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
        return cell
    }
    
//  функция делегата, которая запускает переход к экрану с отображение конкретной шутки на основании идентификатора перехода
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toChoosenJoke", sender: JokeService.instance.jokes[indexPath.row])
    }
    
//    функция подготовки ChoosenJokeVC до его отображения с целью подгрузки информации о конкретной шутке
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toChoosenJoke" {
            if let destinationVC = segue.destination as? ChoosenJokeVC {
                if let joke = sender as? Joke {
                    destinationVC.joke = joke
                }
            }
        }
    }
}

