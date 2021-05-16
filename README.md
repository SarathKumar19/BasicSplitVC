# Basic Split View Controller

A sample project which implements UISplitViewController. A split view controller has 2 child controllers namely **Master** and **Detail** view controllers.

A Master view controller will usually be a UITableViewController which on selecting a row displays more details about selected item in Detail view controller

By default, split view controller will show only Detail view controller on iPhones and iPads. This implementation of split view controllers shows only Detail view controller on iPhone and iPad Portrait orientations and both Master and Detail view controllers on iPhone and iPad landscape orientation.

This implentation also handles iPad multitasking mode where the following scenarios may occur.

Orientation | Window 1 | Window 2
----------- | -------- | --------
Portrait | 40% (Only Detail VC) | 60% (Only Detail VC)
Landscape | 30% (Only Detail VC) | 70% (Master and Detail VC)
Landscape | 50% (Only Detail VC) | 50% (Only Detail VC)

This implementation show both Master and Detail view controllers based on window width in iPad multitasking mode
