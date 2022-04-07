//
//  main.swift
//  PassGen
//
//  Created by Nick on 4/6/22.
//

import Foundation

let arguments = CommandLine.arguments

guard arguments.count <= 2 else {
	print("Incorrect number of arguments. Optionally pass a number of characters or supply no argument to receive an 8-character password.\n\nExample: PassGen 16\n")
	exit(1)
}

let length: UInt

if arguments.count == 2 {
	let argument = arguments[1]
	print(argument)
	guard let number = UInt(argument) else {
		print("Incorrect argument passed. Must be an (unsigned) integer greater than 0.\n\nExample: PassGen 16\n")
		exit(1)
	}
	
	length = number
} else {
	length = 8
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
