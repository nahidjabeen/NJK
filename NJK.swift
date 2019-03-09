//
//  NJK.swift
//  NJK
//
//  Created by Nazar Chowdhury on 2/9/19.
//  Copyright © 2019 Nahid Jabeen. All rights reserved.
//

import Foundation

// NJK could have been a struct, we don't pass NJK around... lecture 4
//class NJK // class is reference, lives in the heap, you pass pointers to it
struct NJK  // structs are value type, it's in the heap,
            // it gets copied, Swift only copies a bit when
            // you mutate it, does not copy the whole struct.
            // Copy on write VALUE TYPE
{
    // () how to init an array
    //var cards: Array<Card>
    //var cards = [Card]()
    private (set) var cards = [Card]() // this is writable 'set' for us, read-only externally.
                                       //'let' would be const not writable for us as well
    
    // optional (with '?') property
    //var indexOfOneAndOnlyFaceUpCard: Int?
    
    // 10 use of Computed property. Lecture 3
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get{
            // Lesson 4: 1:20:07 use filter (closure) to simplify. Filter executes
            // on something. If it is true, then puts it in the array, else doesn't.
            // So it filters the collection.
            // Boolean function executed by closure $0
            
            //let faceUpCardIndecies = cards.indices.filter{ cards[$0].isFaceUp}
            //return faceUpCardIndecies.count == 1 ? faceUpCardIndecies.first : nil
            
            // Do the extension of Collection Protocol oneAndOnly
            return cards.indices.filter{ cards[$0].isFaceUp}.oneAndOnly
            
            //sample code for extension demo Lesson 4 1:25:47
            //let ch = "h".oneAndOnly     // will return 'h'
            //let ch = "hello".oneAndOnly // will return 'nil' cause there are 5 characters
            
            //var foundIndex: Int?
            //for index in cards.indices{
            //    if cards[index].isFaceUp{
            //        if foundIndex == nil {
            //        foundIndex = index
            //        } else {
            //            return nil
            //        }
            //    }
            //}
            // return foundIndex
        }
        set(newValue){ // newValue is a local var, don't even need to put 'newValue' word
            for index in cards.indices{
                cards[index].isFaceUp = (index == newValue) // newValues value is whatever returned... go ahead and use that one
        }
      }
    }
   
    // When Class changed to struct, 'mutating' is needed.
    // Or get 'Cannot assign to property: 'self' is immutable' error
    mutating func ChooseCard(at index: Int){
    //func ChooseCard(at index: Int){
            
        //if cards[index].isFaceUp{
        //    cards[index].isFaceUp = false
        //}else{
        //    cards[index].isFaceUp = true
        //}
         print(" NJK ChooseCard")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                
                //if cards[matchIndex].identifier == cards[index].identifier {
                // Lecture 4, Dictionary Hashable, identifier was made private
                // so it becomes inaccessible, but I can compare cards directly now
                
                    if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                // indexOfOneAndOnlyFaceUpCard = nil Taken care of by Computed property
            }else{
                // Done in Computed property: Lecture 3
                // either no cards or 2 cards are face up
                
                //for flipDownIndex in cards.indices{
                //    cards[flipDownIndex].isFaceUp = false
                //}
                //cards[index].isFaceUp  = true
                
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    // 2. We need more cards
    init(NumberOfPairsOfCards: Int){
        //for identifier in 1...NumberOfPairsOfCards{ // or do 0..<NumberOfPairsOfCards
        for _ in 1...NumberOfPairsOfCards { // 8. no need of the identifier, use "_".
            
            //let card = Card(identifier: identifier)
            let card = Card()
            print(" NJK NumberOfPairsOfCards \(NumberOfPairsOfCards)")
            
            //print(" NJK card ID \(card.identifier)")
            //print(" NJK card UP \(card.isFaceUp)")
            //print(" NJK card MATCHED \(card.isMatched)")
            
            // let matchingCard = Card(identifier: identifier) (a)
            // let matchingCard = card // struct copies to struct (b)
                
            //cards.append(card)
            //cards.append(matchingCard)
            
            // same as above (c). Note that these are 2 different cards
            //cards.append(card)
            //cards.append(card)
            
            // same as above (d). Putting card to card gets copied
            cards += [card, card]
            
            // don't like that NJK takes the identifier, the card can take care of that
            // use static in struct card instead
        }
        
        cards.shuffle() // Bill told me
        
        // TODO: Shuffle the cards
        // Used arc4random_uniform to add random card identifier for shuffle.
        // it randomizes so much that last two cards may not match!
        
        let card = Card()
        // identifier was made private so this shuffle doesn't work anymore
        //for index in cards.indices{
                       //cards[index].identifier = index.arc4random
        //    let myrandom = Int(arc4random_uniform(UInt32(NumberOfPairsOfCards)))
        //    cards[index].identifier = myrandom
        //}
        
        //print(" NJK card ID \(card.identifier)")
        print(" NJK card UP \(card.isFaceUp)")
        print(" NJK card MATCHED \(card.isMatched)")
    }
}

// Type is Element; count and first are Collection's methods.
extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
