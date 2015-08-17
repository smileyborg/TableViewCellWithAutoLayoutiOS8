TableViewCellWithAutoLayoutiOS8
===========================

*Note: This sample project requires __Xcode 7__ and __iOS 8__. For a sample project demonstrating the iOS 7 compatible implementation, [click here](https://github.com/smileyborg/TableViewCellWithAutoLayout).*

Sample project demonstrating self-sizing table view cells in iOS 8, using Auto Layout in UITableViewCell to achieve dynamic layouts with variable row heights. This project is a universal app that will run on iPhone and iPad. This implementation is only compatible with iOS 8 and later.

There are two branches in this repository:

1. **master** (this branch) - A Swift 2.0 implementation
2. **[objective-c](https://github.com/smileyborg/TableViewCellWithAutoLayoutiOS8/tree/objective-c)** - An Objective-C implementation

To build & run the app, you should open the `TableViewCellWithAutoLayout.xcworkspace` in Xcode.

This sample project displays a table view with cells that each contain a single-line title label and a multi-line body label (each cell's body label displays a random number of lorem ipsum words).

This project utilizes the open source [PureLayout](https://github.com/smileyborg/PureLayout) library to easily set up constraints in code.

See the original post on Stack Overflow for more info:

http://stackoverflow.com/questions/18746929/using-auto-layout-in-uitableview-for-dynamic-cell-layouts-variable-row-heights

If you have questions or run into issues, please [open a new Issue on this GitHub project](https://github.com/smileyborg/TableViewCellWithAutoLayoutiOS8/issues/new).
