//
//  main.swift
//  calc
//
//  Created by Jesse Clark on 12/3/18.
//  Copyright © 2018 UTS. All rights reserved.
//

import Foundation

var args = ProcessInfo.processInfo.arguments
args.removeFirst() // remove the name of the program
var i = Int()
var index = Int()
var loop = Int()
let lowPrecedence = ["+", "-"]
let highPrecedence = ["x", "%", "/"]
var highPreComplete = Bool()
var currSize = args.count

func doesHaveHighPredecenceRemaining() -> Bool
{
    for _ in args
    {
        if (highPrecedence.contains(args[loop]))
        {
            loop = 0
            return true
        }
        loop+=1
    }
    loop = 0
    return false
}
func recursiveCalc(index: Int)
{
        if (index % 2 != 0) {//Check if the current character at index is odd, if it is, we have an operator
            if (doesHaveHighPredecenceRemaining() && lowPrecedence.contains(args[index])) {//If my current operator is low precedence, but I still have some more high predecence left
                let jumpto = index + 2
                recursiveCalc(index: jumpto) //Skip the current operator
            }
            else {
            switch Character(args[index]) {
                        case "+":
                            let LHS = Int(args[index-1])!
                            let RHS = Int(args[index+1])!
                            let result = LHS + RHS
                            args.removeSubrange(index-1...index+1) //Remove the Left hand side, Operator and Right hand side)
                            args.insert(String(result), at: index-1) //Add in my result to the LHS
                            return // Recursively enter method again, but set pointer to index 0        
                        case "-":
                            
                            let LHS = Int(args[index-1])!
                            let RHS = Int(args[index+1])!
                            let result = LHS - RHS
                            args.removeSubrange(index-1...index+1) //Remove the Left hand side, Operator and Right hand side)
                            args.insert(String(result), at: index-1) //Add in my result to the LHS
                            return
                        case "x":
                            let LHS = Int(args[index-1])!
                            let RHS = Int(args[index+1])!
                            let result = LHS * RHS
                            args.removeSubrange(index-1...index+1) //Remove the Left hand side, Operator and Right hand side)
                            args.insert(String(result), at: index-1) //Add in my result to the LHS
                            return
                        case "/":
                            let LHS = Int(args[index-1])!
                            let RHS = Int(args[index+1])!
                            let result = LHS / RHS
                            args.removeSubrange(index-1...index+1) //Remove the Left hand side, Operator and Right hand side)
                            args.insert(String(result), at: index-1) //Add in my result to the LHS
                            return
                        case "%":
                            let LHS = Int(args[index-1])!
                            let RHS = Int(args[index+1])!
                            let result = LHS % RHS
                            args.removeSubrange(index-1...index+1) //Remove the Left hand side, Operator and Right hand side)
                            args.insert(String(result), at: index-1) //Add in my result to the LHS
                            return
                        default:
                            print("Incorrect input")
                            exit(1)
                    }
            }
        }
    let isIndexValid = args.indices.contains(index+1) //Check if our next element exists
    if (isIndexValid==true) { //If it is true, enter the loop again with an incremented index.
        recursiveCalc(index: index+1)
    }

}
while args.count > 1 {
    recursiveCalc(index: 0)
}
let finalAnswer = Int(args[0])!
print(finalAnswer)
