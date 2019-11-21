//
//  EnterNumOfJokesVC.swift
//  AwesomeChuckApp
//
//  Created by Denis Rakitin on 2019-05-29.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//

import UIKit

//Для класса используется отдельный XIB файл, в котором создается интерфейс, которым управляет это контроллер
class EnterNumOfJokesVC: UIViewController {

    //Outlets
    @IBOutlet weak var numberEnterField: UITextField!
    @IBOutlet weak var loadBtn: UIButton!
    
    
//    var
    var enteredNumberOfJokes: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        функция добавления округлых углов к кнопке LOAD
        setupView()
        
        //  обнуление массива содержащего ранее загруженные шутки
        JokeService.instance.jokes.removeAll()

    }
    
    func setupView () {
        loadBtn.layer.cornerRadius = 10
    }

//    фунция, которая релизуется при нажатии на крестик, которая закрывает экран без реализации кода
    @IBAction func closeBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
//    функция обработки введеного пользователем значения количества шуток
    @IBAction func loadJokesBtnPressed(_ sender: Any) {
        
//        проверка наличия введенного значения
        if numberEnterField.text != "" {
//            проверка является ли введеное значение целым числом, реализуется с помощью расширения функционала класса String в файле IntExtention
            if numberEnterField.text!.isStringAnInt() {
//                присвоение локальному значению введеденого пользователем числа
                enteredNumberOfJokes = Int(numberEnterField.text!)
//                проверка не превышает ли введенное значение общего числа шуток, которое было получено при загруке главного экрана
                if enteredNumberOfJokes! <= JokeService.instance.totalNumberOFJokes {
//                    получение шуток на основании введенного пользователем числа
                    JokeService.instance.getJokes(numberOfJokes: enteredNumberOfJokes!) { (success) in
//                        проверка успешности получения шуток. Если массив получил корректное значение, то наблюдателю посылается уведомление о необходимости перезагрузить таблицу с шутками
                        if success {
                            
                            NotificationCenter.default.post(name: JOKES_LOADED_NOTIF, object: nil)
//                            закрытие экрана ввода количества шуток
                            self.dismiss(animated: true, completion: nil)
                        }
                        
                    }
                } else {
//                    выводит сообшение, если общее количество шуток меньше введенного значения
                    let tooMuchAlert = UIAlertController(title: "Ошибка", message: "Вы просите загрузить слишком много шуток", preferredStyle: .alert)
                    
                    tooMuchAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                    
                    self.present(tooMuchAlert, animated: true, completion: nil)
                }
            } else {
//                выводит сообщение, если значение введено не в виде целого числа
                let notIntAlert = UIAlertController(title: "Ошибка", message: "Пожалуйста, введите значение в виде числа", preferredStyle: .alert)
                
                notIntAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                
                self.present(notIntAlert, animated: true, completion: nil)
            }
        } else {
//            выводит сообщение, если никакое значение не было введено
            let emptyStringAlert = UIAlertController(title: "Ошибка", message: "Пожалуйста, введите значение", preferredStyle: .alert)
            
            emptyStringAlert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
            
            self.present(emptyStringAlert, animated: true, completion: nil)
        }
        
    

        

    }
    

}
