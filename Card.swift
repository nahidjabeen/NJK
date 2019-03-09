//
//  Card.swift
//  NJK
//
//  Created by Nazar Chowdhury on 2/9/19.
//  Copyright © 2019 Nahid Jabeen. All rights reserved.
//

import Foundation

//struct Card
struct Card:Hashable
{
    // "Type 'Card' does not conform to protocol 'Hashable' " This
    // error did not appear like Lecture 4 34.35minute.
    internal var hashable: Int {return identifier}
    
    static func == (lhs:Card, rhs:Card)->Bool{
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    // var identifier: Int // internal name "identifier"
    private var identifier: Int // Lecture 4
    
    // 6. Create identifier factory in static. everytime you call it starts
    // at 0
    private static var identifierFactory = 0
    
    // 5. Use static. Get unique ID and return -> it
    // you ask the card Type ID
    private static func getUniqueIdentifier() -> Int {
        
        // Card.identifierFactory += 1   // 7. We are in a static method
        // return Card.identifierFactory // so get rid of "Card"
        identifierFactory += 1
        print(" Card identifierFactory \(Card.identifierFactory)")
        return identifierFactory
    }
    
    // 3. external name "identifier"; "i" is internal name
    //init(identifier i: Int){
        
        // internal name "identifier"
        //identifier = i  // is set to internal name "i"
    //}
    
    
    // 3. alternate way
    // "init" is one method that can have both internal and external same name
    //init(identifier: Int){ 9.
        init(){
        // this left side is the internal name "identifier"
        self.identifier = Card.getUniqueIdentifier() //identifier
        print(" Card init() \(self.identifier)")
    }
}
