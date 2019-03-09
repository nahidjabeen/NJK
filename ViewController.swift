//
//  ViewController.swift
//  NJK
//
//  Created by Nazar Chowdhury on 1/26/19.
//  Copyright © 2019 Nahid Jabeen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // 1. Make the big green arrow from Controller to Model.
    // Point to the NJK class
    // var game:NJK         // This is not initialized
    // var game:NJK = NJK() // This is initalized. Classes get a Free init with no args
                            // as long as all their own vars were initialized
    // lazy var game = NJK(NumberOfPairsOfCards: (CardButtons.count + 1)/2)  // We don't need a type, type inference can figure out type
    
    // Computed Property: read only with a 'get'.
    // There's no 'set', so no need to mention 'get'
    private lazy var game = NJK(NumberOfPairsOfCards:NumberOfPairsOfCards)
    var NumberOfPairsOfCards:Int{
        //get{
            return (CardButtons.count + 1)/2
        //}
        //set{
            
        //}
    }
    
    private(set) var flipCount = 0 { // Property
        didSet {        // Property Observer
            // changed this with NSAttributedString
            // flipCountLabel.text = "Flip Count: \(flipCount)"
            
            updateflipCountLabel()
        }
    }
    
    private func updateflipCountLabel(){
        // Lesson 4 NSAttributed String (different from Swift String)
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.4750613544, blue: 0.6574976266, alpha: 1)
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
   
    @IBOutlet private weak var flipCountLabel: UILabel!{
        didSet {
            updateflipCountLabel()
        }
    }
    
    @IBOutlet private var CardButtons: [UIButton]!
    
    //var emojiChoices: Array<String> = ["😇","⚽️","🍎","🐳","🍎","🐳","😇","⚽️"]
    
    @IBAction private func touchCard(_ sender: UIButton){
        flipCount += 1
        //flipCard(withEmoji: "😇", on: sender)
        if let cardNumber = CardButtons.firstIndex(of: sender){
            //flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.ChooseCard(at: cardNumber)
            updateViewFromModel()
            print("View cardNumber = \(cardNumber)")
        }else{
            print("Chosen card was not in cardButtons. Optional ! unwrap")
        }
    }
    
    @IBAction func touchSecondCard(_ sender: UIButton) {
        flipCount += 1
        //flipCard(withEmoji: "⚽️", on: sender)
    }
    
    private func updateViewFromModel(){
        for index in CardButtons.indices{
            let button = CardButtons[index]
            let card   = game.cards[index]
            if card.isFaceUp{
                //button.setTitle(emoji, for: UIControl.State.normal)
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else{
                button.setTitle("NJK!", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 0.6174546167, green: 0.9419139249, blue: 1, alpha: 0)  :  #colorLiteral(red: 0.6174546167, green: 0.9419139249, blue: 1, alpha: 1)
            }
        }
        
    }
    
    // private var emojiChoices = ["😇","⚽️","🍎","🐳"]
    // Lesson 4 53:43 minutes make this a string for Protocol
    private var emojiChoices = "😇⚽️🍎🐳"
    
    // Dictionary returns an optional
    // var emoji = Dictionary<Int, String>()
    // var emoji = [Int:String]()
    // Lesson 4: Use Card as the Key for the Dictionary.
    // Go make the Card Hashable, which will also want Equatable
    private var emoji = [Card:String]()
    
    private func emoji(for card: Card) -> String{
        //let chosenEmoji = emoji[card.identifier]
        
        //if emoji[card.identifier] == nil{
            //if emojiChoices.count >0 {
            // you can replace those with
            //if emoji[card.identifier] == nil, emojiChoices.count > 0 {
        
                if emoji[card] == nil, emojiChoices.count > 0 {  // Used card as Dictionary Int Key
                    
                // let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                // emoji[card.identifier] = emojiChoices.remove(at:randomIndex)
                
                //emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
                    
                // identifier was made private, so now
                // emoji[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        
                // emojiChoices was made a String, Lesson 4 53:43 minutes for Protocol for Collection
                // Using offsetBy
                    let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
                    emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
        }
        
        //if emoji[card.identifier] != nil{
        //  return emoji[card.identifier]!
        //}else{
        //    return "?"
        //}
        
        // same as logic above
            //return emoji[card.identifier] ?? "?"
              return emoji[card] ?? "?" // Used card as Dictionary Int Key
        }
    }

// Add something sensible for Int. If done '5.arc4random'
// it will generate random number between 0-4. Lecture 3
extension Int{
    var arc4random:Int{
        if self > 0{
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

    
    //func flipCard(withEmoji emoji: String, on button: UIButton){
    //   print("flipCard(withEmoji: \(emoji))")
    //  if button.currentTitle == emoji {
    //    button.setTitle("NJK!", for: UIControl.State.normal)
    //      button.backgroundColor = #colorLiteral(red: 0.6174546167, green: 0.9419139249, blue: 1, alpha: 1)
    //  }
    // else {
    //    button.setTitle(emoji, for: UIControl.State.normal)
    //   button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    //}
    // }

//}

