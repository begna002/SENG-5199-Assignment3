//
//  Strings.swift
//  SENG-5199-Assignment3
//
//  Created by Moti Begna on 3/16/24.
//

import Foundation


var words = "about after again chair clean clear could doubt earth every found fruit grant happy heard house human learn light lunch money music never north often other plant power ready right south table teach today water whole woman world young again alive alone always angry beach black blood books build cause come could court cover crazy dance death doubt dress drink early enjoy equal event fight floor force front funny games grant green happy heard hello honor house humor idea issue known laugh learn leave light lunch maybe match metal money month movie music never north often owner paint paper party peace point power quiet ready right river round shout skull sleep smile smoke soft solve sound space speak spend sport spring start story study sugar sweet table teach thank think throw touch train travel treat truth under value visit voice water whole woman world young aside aware break bring build cause clean climb close color come could count cover crazy dance death doubt dress drink early enjoy equal event fight floor force found front funny games giant grant green happy heard hello honor house humor issue known laugh learn leave light lunch maybe match metal money month movie music never north often owner paint paper party peace point power quiet ready right river round shout skull sleep smile smoke soft solve sound space speak spend sport spring start story study sugar sweet table teach thank think throw touch train travel treat truth under value visit voice water whole"

func getRandomWord() -> String {
    let wordsList = words.components(separatedBy: " ")
    
    return wordsList.randomElement() ?? "apple"
}

