## About
Auto height and placeholder text view in Object-C for iOS.

## Usage

```objc
- (void)viewDidLoad
{
    [super viewDidLoad];

    MOITextView* tv = [[MOITextView alloc] initWithFont:[UIFont systemFontOfSize:16]
                                                padding:UIEdgeInsetsZero
                                            placeholder:@"placeholder"
                                                  width:self.view.bounds.size.width
                                              maxHeight:100];
    CGRect frame = tv.frame;
    frame.origin.y = 100;
    tv.frame = frame;
    [self.view addSubview:tv];
}
```

## Screenshot

![](https://raw.githubusercontent.com/mconintet/MOITextView/master/screenshot.gif)

## Installation

```
// in your pod file
pod 'MOITextView', :git => 'https://github.com/mconintet/MOITextView.git'
```

```
// command line
pod install
```
