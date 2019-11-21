//
//  ChoosenJokeVC.swift
//  AwesomeChuckApp
//
//  Created by Denis Rakitin on 2019-05-30.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//

import UIKit

//Экран загрузки конкретной шутки при нажатии на строчку в таблице шуток
class ChoosenJokeVC: UIViewController {
    
//    Outlets
    
    @IBOutlet weak var jokeNumLbl: UILabel!
    @IBOutlet weak var jokeTextLbl: UITextView!
    
//    var
    var joke: Joke!

    
//    загрузка и присвоение значения текстовым полям при загрузке экрана
    override func viewDidLoad() {
        super.viewDidLoad()
        jokeNumLbl.text = "Joke # \(joke.jokeNumber!)"
        jokeTextLbl.text = joke.jokeTxt.convertSpecialCharacters()
    }
    
//    функция котороя убирает текщий экран из стака при нажатии кнопки
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
