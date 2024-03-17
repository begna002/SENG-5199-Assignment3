//
//  Strings.swift
//  SENG-5199-Assignment3
//
//  Created by Moti Begna on 3/16/24.
//

import Foundation

var foodWords = "Apple Bread Steak Pasta Salad Pizza Bacon Onion Lemon Candy Fruit Grill Toast Sushi Sushi Prawn Donut Mango Rice Peach"
var dangerWords = "Risky Peril Toxic Blood Venom Flame Tiger Crash Storm Fears Alert Wound Blare Quake Siren Spoil Alarm Grief Scare"
var financeWods = "Asset Stock Bonds Trade Loans Debts Funds Value Taxes Yield Rates Price Grant Risky Offer Costs Money Bonus Loans Bills"
var geographyWords = "Coast Plain Delta River Ocean Hills Mount Plate Ridge Lakes Field Basin Dunes Swale Beach Tidal Fjord Flats Creek Cliffs"
var writtingWords = "Write Novel Draft Words Inked Poems Typed Index Books Paper Lines Rhyme Verse Quill Notes Texts Essay Script Story Prose"

var wordMap = [
    "Food": foodWords.components(separatedBy: " "),
    "Danger": dangerWords.components(separatedBy: " "),
    "Finance": financeWods.components(separatedBy: " "),
    "Geography": geographyWords.components(separatedBy: " "),
    "Writting": writtingWords.components(separatedBy: " ")
]

func getRandomWord() -> (key: String, value: String) {
    let words = wordMap.randomElement()
    let key = words?.key ?? "food"
    let value = words?.value.randomElement() ?? "apple"
       
    return (key, value)
}

