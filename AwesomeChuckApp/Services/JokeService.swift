//
//  JokeService.swift
//  AwesomeChuckApp
//
//  Created by Denis Rakitin on 2019-05-29.
//  Copyright © 2019 Denis Rakitin. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

//Основной класс, отвечающий за получение информации от API и хранения указанной информации для передачи в дальнейшем другим классам
class JokeService {
    
//    создание синглтона, поскольку требуется один экземпляр класса
    static let instance = JokeService()
    
//    Переменные которые хранят массив полученных шуток и общее количество имеющихся шуткок
    var jokes = [Joke]()
    var totalNumberOFJokes = 0
    
    
//    функция реализовання на фреймворке Alamofire, котрый отвечает за отправку запроса и обработку вернувшихся резезультатов в виде JSON строки. Назначение этой функции - получение общего количества доступных шуток
    func getTotalNumberOfJokes (completion: @escaping (_ success: Bool) -> ()){
        Alamofire.request("\(JOKES_URL)/count", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
//            если в полученном результате отстутвуют ошибки
            if response.result.error == nil {
//                попытка полчить данные из запроса
                guard let data = response.data else {return}
                
                do {
//                    попытка обработать данные с помощию  do catch блока
                 let json  = try JSON(data: data)
                    
//                    обработка полученного значения с помощью фреймворка SwiftyJson, облегчающего обработку результата в формате JSON
                    self.totalNumberOFJokes = json["value"].intValue
                    } catch {
                        debugPrint(error)
                    }
//                Если обработка прошла успешно, то обработчику выполненному в виде сбегающего замыкание передается BOOL значение true, для реализации последующий действий с полученным результатом
                completion(true)
                
            } else {
//                если ответ содержит ошибку, дальнейшая обработка результатов функции не производится
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
    
//    Функция получения определенного количество шуток, на основании значения введенного пользователем. Используются теже фреймворки и концепции что и в предыдущей функции
    func getJokes(numberOfJokes: Int, completion: @escaping (_ success: Bool) -> ()) {
        Alamofire.request("\(JOKES_URL)/random/\(numberOfJokes)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: HEADER).responseJSON { (response) in
            if response.result.error == nil {
                guard let data = response.data else {return}
                
                do {
                    let json = try JSON(data: data)
                    
                    let jokesArray = json["value"].arrayValue
//                    поскольку полученный JSON ответ содержит список шутков к виде словаря, то в дальнейшем производится иттерация по полученном словарю с полчуением информации о тексте и идентификационном номере
                    for joke in jokesArray {
                        let jokeId = joke["id"].stringValue
                        let jokeTxt = joke["joke"].stringValue
                        
                        let newJoke = Joke(jokeNum: jokeId, jokeTxt: jokeTxt)
                        self.jokes.append(newJoke)
                    }
                    completion(true)
                } catch {
                    debugPrint(error)
                }
                
            } else {
                completion(false)
                debugPrint(response.result.error as Any)
            }
        }
    }
    
}
