//
//  Model.swift
//  TableViewCellWithAutoLayout
//
//  Copyright (c) 2014 Tyler Fox
//

import UIKit

class Model
{
    var dataArray: [(title: String, body: String)] = []
    
    init(populated: Bool)
    {
        if (populated) {
            for familyName: AnyObject in UIFont.familyNames() {
                if let familyNameString = familyName as? String {
                    dataArray.append((title: familyNameString, body: randomLoremIpsum()))
                }
            }
        }
    }
    
    func addSingleItem()
    {
        let fontFamilies = UIFont.familyNames()
        
        let r = random() % fontFamilies.count
        let familyName: AnyObject = fontFamilies[r]
    
        if let familyNameString = familyName as? String {
            dataArray.append((title: familyNameString, body: randomLoremIpsum()))
        }
    }
    
    func randomLoremIpsum() -> String
    {
        let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent non quam ac massa viverra semper. Maecenas mattis justo ac augue volutpat congue. Maecenas laoreet, nulla eu faucibus gravida, felis orci dictum risus, sed sodales sem eros eget risus. Morbi imperdiet sed diam et sodales. Vestibulum ut est id mauris ultrices gravida. Nulla malesuada metus ut erat malesuada, vitae ornare neque semper. Aenean a commodo justo, vel placerat odio. Curabitur vitae consequat tortor. Aenean eu magna ante. Integer tristique elit ac augue laoreet, eget pulvinar lacus dictum. Cras eleifend lacus eget pharetra elementum. Etiam fermentum eu felis eu tristique. Integer eu purus vitae turpis blandit consectetur. Nulla facilisi. Praesent bibendum massa eu metus pulvinar, quis tristique nunc commodo. Ut varius aliquam elit, a tincidunt elit aliquam non. Nunc ac leo purus. Proin condimentum placerat ligula, at tristique neque scelerisque ut. Suspendisse ut congue enim. Integer id sem nisl. Nam dignissim, lectus et dictum sollicitudin, libero augue ullamcorper justo, nec consectetur dolor arcu sed justo. Proin rutrum pharetra lectus, vel gravida ante venenatis sed. Mauris lacinia urna vehicula felis aliquet venenatis. Suspendisse non pretium sapien. Proin id dolor ultricies, dictum augue non, euismod ante. Vivamus et luctus augue, a luctus mi. Maecenas sit amet felis in magna vestibulum viverra vel ut est. Suspendisse potenti. Morbi nec odio pretium lacus laoreet volutpat sit amet at ipsum. Etiam pretium purus vitae tortor auctor, quis cursus metus vehicula. Integer ultricies facilisis arcu, non congue orci pharetra quis. Vivamus pulvinar ligula neque, et vehicula ipsum euismod quis."
        
        let loremIpsumArray = loremIpsum.componentsSeparatedByString(" ")
        
        let minimumNumberOfWords = 3
        let r = max(minimumNumberOfWords, random() % loremIpsumArray.count) // get a random number r, where:  minimumNumberOfWords <= r <= loremIpsumArray.count
        let loremIpsumRandom = loremIpsumArray[0..<r] // grab a slice of the lorem ipsum array that contains r number of words
        
        let loremIpsumText = loremIpsumRandom.reduce("") { "\($0) \($1)" } // join the array of words to make a string
        return "\(loremIpsumText)!!!" // append "!!!" so that we always know what the ending characters are
    }
}
