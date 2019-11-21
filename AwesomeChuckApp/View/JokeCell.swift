//
//  JokeCell.swift
//  AwesomeChuckApp
//
//  Created by Denis Rakitin on 2019-05-29.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//

import UIKit

//класс отвечающий за создание и конфигурирования конкретной ячейки в таблице
class JokeCell: UITableViewCell {
    
    @IBOutlet weak var jokeNumberLbl: UILabel!
    @IBOutlet weak var jokeTxtLbl: UILabel!
    
//    функция конфигурирования ячейки
    func configureCell(joke: Joke) {
        jokeNumberLbl.text = "Joke # \(String(describing: joke.jokeNumber!))"
        
//        в процессе присвоения значения лэйбла с помощью расширения класса String, обрабатываются специальный знаки, например кавычки, которые используются в HTML но не используются в SWIFT
        jokeTxtLbl.text! = joke.jokeTxt.convertSpecialCharacters()
    }
    

}
