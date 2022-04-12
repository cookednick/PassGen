//
//  main.swift
//  PassGen
//
//  Created by Nick on 4/6/22.
//

import Foundation

let arguments = CommandLine.arguments

guard arguments.count <= 2 else {
	print("Incorrect number of arguments. Optionally pass a number of characters.\n   Example: PassGen 16")
	exit(1)
}

let length: UInt

func process(_ input: String?) -> UInt {
	if let input = input?.trimmingCharacters(in: .whitespacesAndNewlines),
	   let number = UInt(input),
	   number > 0 {
		return number
	} else {
		print("Incorrect argument passed. Must be an (unsigned) integer greater than 0.\n   Example: PassGen 16")
		exit(1)
	}
}

if arguments.count == 2 {
	length = process(arguments[1])
} else {
	print("How many characters? ", terminator: "")
	length = process(readLine())
}

enum Static {
	static private let scalars = [
		UnicodeScalar("a").value...UnicodeScalar("z").value,
		UnicodeScalar("A").value...UnicodeScalar("Z").value,
		UnicodeScalar("0").value...UnicodeScalar("9").value
	].joined()
	
	static let characters = scalars.map { Character(UnicodeScalar($0)!) } + ["!", "@", "#", "$", "%", "^", "&", "*", "(", ")", "-", "_", "+", "=", ";", ":", "'", "\"", ",", "<", ".", ">", "/", "?", "\\"]
}

let result = String((1...length).map { _ in Static.characters.randomElement()! })

print(result)
