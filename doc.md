### resourse library
- **SF Symbols6**: 6000+ symbols
-  


### Usage
- **VStack**: arranges subview vertically.
- **LazyVStack**: renders the views when the app need to display onscreen(vertically).
- **HStack**: arrange subviews horizontally.
- **LazyHStack**: renders the views when the app need to display onscreen(horizontally).
- **.accentColor**: (强调色)reflects the accent color of the system or app.
- **.padding( : : )**:
    1. .bottom: distance from view bottom.
    2. .trailing: distance from the right side of the view.
- **TabView**: a container view that provides tabs that can use to switch between different subviews
- **tabItem( : )**: tells the TabView the image and text to display in each tab 
- **Settings**: provied Setting menu item in Mac apps
- **image**: iconography that SF symbols provieds
- **Lable**: to use both text and a symbol to represent a single element in app
    1. .lableStyle(.titleAndIcon): tells the view to display both title and icon
- **controlSize( : )**: to make a control smaller or larger, such as Picker and Button...
- **progressViewStyle( : )**: to choose a linear or circular appearence for a progress bar.
- **.background()**:
    1. .purple.opacity(): set transparency for the background
    2. in: Capusle(): set the background style to capsule
- **ScaledMetric**: @ScaledMetric(relativeTo: .title) var paddingwidth = 14.5
    1. the value is proportionally larger or smaller
    2. such as .padding(paddingWidth)