# Trapping Rain Water with Swift
### Implementing an Interview Question with Swift 

[Trapping Rain Water](http://www.geeksforgeeks.org/trapping-rain-water/) question is probably one of the popular interview question . I have implemented it with **Swift 3** for **iOS**.

I have divided UIImage into `8x8` pieces with using  **UIImageGraphics** to represent image and there are totally `8 Tower` and will be **maximum height** of `8`



Here is the struct to store `Tower` heights
This function generate scenario for `UIImageView`
```swift
struct WallHeights{
var wallHeights : [Int] = [0,0,0,0,0,0,0,0];
}
```

This function **generate** scenario for **UIImageView**
```swift
func generateScenarioForTrappingRain(c : CGSize , wall : WallHeights) 
```

This function find the **maximum height** of tower on the **left side** of index and return its **height** as **Int**
```swift
func findLeftMaximum(index : Int , wall : WallHeights) -> Int 
```

This function find the **maximum height** of tower on the **right side** of index and return its **height** as **Int**

```swift
func findRightMaximum(index : Int , wall : WallHeights) -> Int 
```


This function fill the area as given **section (0 to 7)** with given color . It starts to 
fill from the heightStart to heightStart + height . 

```swift
func firstSectionWithHeight(heightStart : Int , height : Int , section : Int , color : UIColor , c : CGSize) -> UIImage?
```

This function draw **white lines** to **image** cause of **understanding** the sections
```swift
func drawGraphLines(c : CGSize)
```    

This function checks if there are **higher tower** on both sides as **right** and **left** .
```swift
func checkBothSides(index : Int , wall : WallHeights) -> Bool
```      

### Generating only Towers
![](https://github.com/eliakorkmaz/Trapping-Rain-Water-with-Swift/blob/master/generateScene1.gif)

### Generating All Scenarios
![](https://github.com/eliakorkmaz/Trapping-Rain-Water-with-Swift/blob/master/final.gif)



