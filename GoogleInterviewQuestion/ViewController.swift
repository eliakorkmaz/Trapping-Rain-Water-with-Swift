//
//  ViewController.swift
//  GoogleInterviewQuestion
//
//  Created by xcodewarrior on 21.06.2017.
//  Copyright © 2017 EmrahKorkmaz. All rights reserved.
//

import UIKit

struct WallHeights{
    var wallHeights : [Int] = [0,0,0,0,0,0,0,0];
}


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBOutlet weak var questionImageView: UIImageView!
    
    
    @IBAction func generateFunction(_ sender: Any) {
        
        var testWall : WallHeights = WallHeights();
        
        for iterator in 0..<8{
            testWall.wallHeights[iterator] = Int(arc4random_uniform(256)) % 8; //tempHeight;
        }
        
        let sSize : CGSize = CGSize(width: questionImageView.frame.width, height: questionImageView.frame.height);
        UIGraphicsBeginImageContextWithOptions(sSize, true, 1);
        
        drawGraphLines(c: sSize);
        
        self.generateScenarioForTrappingRain(c: sSize , wall : testWall);
    }
    
    // generating all scenario to show
    func generateScenarioForTrappingRain(c : CGSize , wall : WallHeights) {
        
        // fill the towers color as brown
        for iteration in 0..<8{
            questionImageView.image = firstSectionWithHeight(heightStart: 0, height: wall.wallHeights[iteration] , section: iteration, color: .brown, c: c);
        }
        
        var waterFillArray : [Int] = [0,0,0,0,0,0,0,0];
        
        var maxLeft : Int = 0 , maxRight : Int = 0;
        var fillingWater : Int = 0;
        
        
        for i in 0..<8{
            if i == 0{
                waterFillArray[i] = 0;
            }else if (i == 7){
                waterFillArray[i] = 0;
            }else{
                if( checkBothSides(index: i, wall: wall) == true){
                    // Both sides are currenty correct , so find maximums on the both sides and take the minimum of them
                    maxLeft = findLeftMaximum(index: i, wall: wall);
                    maxRight = findRightMaximum(index: i, wall: wall);
                    fillingWater = min(maxLeft,maxRight);
                    waterFillArray[i] = fillingWater - wall.wallHeights[i];
                }else{
                    // Both sides are not correct , so there will be no water to be filled
                    waterFillArray[i] = 0;
                }
            }
        }
        
        // fill the water
        for i in 0..<8{
            questionImageView.image = firstSectionWithHeight(heightStart: wall.wallHeights[i] , height: waterFillArray[i], section: i, color: .blue, c: c);
        }

    }
    
    
    //
    // checking if there are both higher tower , one of the on the left side and one of the on the right side 
    // if exist , return true
    // else return false
    func checkBothSides(index : Int , wall : WallHeights) -> Bool {
        var status1 : Bool = false , status2 : Bool = false;
        
        for i in 0..<index{
            if wall.wallHeights[i] > wall.wallHeights[index] {
                status1 = true;
            }
        }
        
        for i in index..<8{
            if wall.wallHeights[i] > wall.wallHeights[index]{
                status2 = true;
            }
        }
        
        if status1 == true && status2 == true{
            return true;
        }
        return false;
    }
    
    
    /*
     find the maximum height of tower on the left
    */
    func findLeftMaximum(index : Int , wall : WallHeights) -> Int {
        var maximum : Int = 0;
        
        for i in 0..<index{
            if wall.wallHeights[i] > maximum {
                maximum = wall.wallHeights[i];
            }
        }
        
        return maximum;
    }
    
    
    /*
        find the maximum height of tower on the right
    */
    func findRightMaximum(index : Int , wall : WallHeights) -> Int{
        var maximum : Int = 0;
        for i in index..<8{
            if wall.wallHeights[i] > maximum {
                maximum = wall.wallHeights[i];
            }
        }
        return maximum;
    }
    
    
    


    /*
      firstSectionWithHeight function is fill the tower unit with water or color you want 
      heightStart -> where it begin from
      height -> represent the how many unit it will be filled
      from heightStart to heightStart + height with color of section , will be filled and return the image
    */
    func firstSectionWithHeight(heightStart : Int , height : Int , section : Int , color : UIColor , c : CGSize) -> UIImage?{
        let context = UIGraphicsGetCurrentContext()!
        
        var temp1 : Int = 0;
        var temp2 : Int = 0;
        
        for _ in 0..<(height*Int(c.height)/8) {
            for _ in 0..<(Int(c.width)/8){
                context.setFillColor(color.cgColor);
                context.fill(CGRect(x: section * Int(c.width)/8 + temp2, y: (Int(c.height)-(Int(c.height)/8)*heightStart)-temp1, width: 1, height: 1));
                temp2 += 1;
            }
            temp2 = 0;
            temp1 += 1;
        }
        
        
        let createdScenario = UIGraphicsGetImageFromCurrentImageContext();
        return createdScenario;
    }
    
    
    /*
        drawGraphLines is representing the lines for image to show sections horizontally
    */
    func drawGraphLines(c : CGSize){
        let context = UIGraphicsGetCurrentContext()!
        
        let sectionX : Int = Int(c.width)
        let sectionY : Int = Int(c.height)
        
        for j in 0..<8{
            for i in 0..<sectionX {
                context.setFillColor(UIColor.white.cgColor);
                context.fill(CGRect(x:i, y:j * ( sectionY / 8 ), width: 1, height: 1));
            }
        }
    }

        
}









