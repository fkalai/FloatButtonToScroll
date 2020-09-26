# FloatButtonToScroll for iOS

[![Download](https://img.shields.io/cocoapods/v/FloatButtonToScroll?style=plastic)](https://cocoapods.org/pods/FloatButtonToScroll)

**An elegant and beautiful FloatButtonToScroll which is easily sets in any view with UITableView for iOS apps based on Material Design Guidelines.**

| ![Screenshots](https://github.com/fkalai/FloatButtonToScroll/blob/master/art/custom_FloatButtonToScroll.png) | ![Screenshots](https://github.com/fkalai/FloatButtonToScroll/blob/master/art/default_FloatButtonToScroll.png) |
![Screenshots](https://github.com/fkalai/FloatButtonToScroll/blob/master/art/size_FloatButtonToScroll.png) |
| ---------------------------------------- | ---------------------------------------- | ---------------------------------------- |


## Requirement
* iOS 10.0+
* Swift 5.0+

## Installation

### CocoaPods
You can install it by using CocoaPods. Please add the following line to your Podfile.
```
pod 'FloatButtonToScroll'
```

## Usage

### Basic
```swift
  let floatButtonToScroll = FloatButtonToScroll() // Default size 32 * 32
  
  // By Default the button has:
  // backgroungColor == .clear
  // alpha == 0
  // image == nil
  // text == nil
  // Always required to set an Image or text instead of your UI/UX
  floatButtonToScroll.setImage(UIImage(named: "YOUR_IMAGE_HERE"), for: .normal)
  
  floatButtonToScroll.verticalAlignment = .top(CGFloat) // Default is .top(20)
  floatButtonToScroll.horizontalAlignment = .center // Default is .center
  
  // Default is 120, set it if you want to check the contentOffset with one line
  floatButtonToScroll.contentOffsetY = 220
  
  floatButtonToScroll.setTargetView(view: view)
```
**Note**: `floatButtonToScroll.setTargetView(view: view)` should be called after setting verticalAlignment and horizontalAlignment otherwise the FloatButtonToScroll will be set with the default constraints. You can set the FloatButtonToScroll example inside UIViewController's  on `viewWillAppear()`, `viewDidAppear()` or `viewDidLoad()` function. Also **remember** that the button at the first time its alpha is 0, so you have to expect that you will not show it anywhere in the screen. 

### Supported initializations
There are three type of init() supported.

```swift
  // Default with size 32*32
  FloatButtonToScroll()
  // Set size for both height and width
  FloatButtonToScroll(size: 48)
  // Custom size
  FloatButtonToScroll(frame: frame) // set CGRect(x: 0, y: 0, width: 58, height: 36)
```

### Handle Scroll FloatButtonToScroll
```swift
  // Your UITableView has a delegation for scrolling methods
  // For example you can set the scrolling checker while user scroll from top to bottom
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
      floatButtonToScroll.scrollViewDidScroll(scrollView, scrollingTo: .top)
  }
  
  // Or from bottom to top like almost every messager do
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
      floatButtonToScroll.scrollViewDidScroll(scrollView, scrollingTo: .bottom)
  }
```
**Note**: For both methods needs to be set the right `contentOffsetY` CGFloat value otherwise will not work correctly. For more information, please take a look at [example app](/FloatButtonToScrollExample).

### Handle Action FloatButtonToScroll
```swift
  // First option
  // To handle an action to tap behavior, delegate should be declared.
  floatButtonToScroll.delegate = self
  
  // Delegation func
  extension YourViewController: FloatButtonToScrollDelegate {
      
      func didTapButtonToScroll() {
          // your code here
      }
  }
  
  // Second option
  // You can omit the delegate method and set your own target into your ViewController, for example:
  floatButtonToScroll.addTarget(self, action: #selector(backToTop), for: .touchUpInside)

  @objc func backToTop() {
      // your code here
  }
```

### Customize UI properties
You can define your own styles based on your app.
```swift
  // Background
  floatButtonToScroll.alpha = 1.0 // take care with the alpha because it's used for animation hide & show while scrolling
  floatButtonToScroll.backgroundColor = UIColor.blue
  // Target
  floatButtonToScroll.targetHolderRadius = .cycle
  // Text
  floatButtonToScroll.setTitle("Your Title", for: .normal)
  // All alignment possibilities
  // Top - Center
  floatButtonToScroll.verticalAlignment = .top(CGFloat)
  floatButtonToScroll.horizontalAlignment = .center
  //Top - Left
  floatButtonToScroll.verticalAlignment = .top(CGFloat)
  floatButtonToScroll.horizontalAlignment = .left(CGFloat)
  // Top - Right
  floatButtonToScroll.verticalAlignment = .top(CGFloat)
  floatButtonToScroll.horizontalAlignment = .right(CGFloat)
  
  // Bottom - Center
  floatButtonToScroll.verticalAlignment = .bottom(CGFloat)
  floatButtonToScroll.horizontalAlignment = .center
  // Bottom - Left
  floatButtonToScroll.verticalAlignment = .bottom(CGFloat)
  floatButtonToScroll.horizontalAlignment = .left(CGFloat)
  // Bottom - Right
  floatButtonToScroll.verticalAlignment = .bottom(CGFloat)
  floatButtonToScroll.horizontalAlignment = .right(CGFloat)
```

For more information, please take a look at [example app](/FloatButtonToScrollExample).

If you have any issues, feedback or suggestion, please visit [issue section](https://github.com/fkalai/FloatButtonToScroll/issues).
Please feel free to create a pull request.

## License

`FloatButtonToScroll` is available under the MIT license. See the LICENSE file for more info.
