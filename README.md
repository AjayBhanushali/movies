# Movies
> A demo project to share my learnings 

[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)

Movies is a simple to show movies, search movies using "starts with binary search algorithm", see movie details such as movie synopsis, cast, reviews, similar movies.

## Features

- [x] VIPER
- [x] Dark Mode Support
- [x] Code based UI development (No xib, no No storyoard)
- [x] Caching of images
- [x] Caching of searched results
- [x] Unit testing
- [x] Useful Extensions
- [x] Git braching module wise
- [x] Binary Search Algorithm

## Implementation Description

Things taken care at the development.

1. Modular: I have tried to split the design in views and hence implemented each of the view object in a UIView class. So that it can be used anywhere from a tableviewcell to collectionview cell to any viewcontroller's view. 
2. Gitable: Tried to maintain sanity of modularity using git branches with the concept of having to generic, feature[s], UI[s] based branching.
3. Discardable: Using VIPER, any part of the code can be discarded.

## Requirements

- iOS 8.0, 9.0+
- Xcode 11.0, 12.0+
- Swift 5.0+

## Meta

Ajay Bhanushali – [LinkedIn](https://www.linkedin.com/in/ajaybhanushali/) || [Medium] || [GitHub](https://github.com/AjayBhanushali) || ajayrbhanushali@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[GitHub](https://github.com/AjayBhanushali)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[Medium]:https://medium.com/@ajayrbhanushali
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com

