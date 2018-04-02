import Foundation

var args = ProcessInfo.processInfo.arguments //Store the arguments in variable 'args' - This is every word we type in after the ./ command
args.removeFirst() // remove the name of the program, which is the first element of our args array
var index = Int() //Initializes Index as an int to 0 (This will be used as our pointer to navigate the array)
var loop = Int() //A seperate counter for our boolean check method
let lowPrecedence = ["+", "-"]
let highPrecedence = ["x", "%", "/"]

func doesHaveHighPredecenceRemaining() -> Bool //Check if I still have some High precedence operators left
{
    for _ in args //Loop for the number of items in args
    {
        if (highPrecedence.contains(args[loop])) //If my current element contains x, % or /, reset the loop to 0 for future use and return true
        {
            loop = 0
            return true
        }
        loop+=1 //Increment loop if I don't see a high precedence operator
    }
    loop = 0
    return false //When loop finishes, return false by default
}


func recursiveCalc(index: Int)
{
        if (index % 2 != 0) {//Check if the current index is odd, if it is, we have an operator
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
                            return // Recursively enter method again
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
                            print("Incorrect input") //If there is an incorrect input where an operator should be (ie a number or symbol)
                            exit(1)
                    }
            }
        }
    let isIndexValid = args.indices.contains(index+1) //Check if our next element exists
    if (isIndexValid==true) { //If it is true, enter the loop again with an incremented index.
        recursiveCalc(index: index+1)
    }

}
while args.count > 1 { //If my array still has more than 1 element in it (ie its not the final answer yet, go again)
    recursiveCalc(index: 0)
}
let finalAnswer = Int(args[0])! //Print the Int element out rather than the array
print(finalAnswer)
