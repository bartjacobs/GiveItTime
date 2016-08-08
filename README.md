### Passing It Around

#### Author: Bart Jacobs

# Passing It Around

The Core Data stack we have built in the previous lessons is slowly taking shape. With every iteration, we add a dash of complexity in return for a few key advantages.

The Core Data stack is set up and managed by the `CoreDataManager` class. It provides access to the main managed object context, neatly hiding the private managed object context, the managed object model, and the persistent store coordinator from the rest of the application.

## One Instance To Rule Them All

The majority of applications need only one Core Data stack, which implies that a single instance of the `CoreDataManager` class suffices. At the mention of the word **single**, a surprising number of developers have the urge to turn the `CoreDataManager` instance into a singleton. While I don't have any objections against the singleton pattern, I have a strong opinion about the motivation for using this controversial pattern.

> "In software engineering, the singleton pattern is a design pattern that restricts the instantiation of a class to one object. This is useful when exactly one object is needed to coordinate actions across the system." — [Wikipedia](https://en.wikipedia.org/wiki/Singleton_pattern)

Does the above definition of the singleton pattern surprise you? Many developers create singletons for a different reason, that is, providing easy access to the singleton object. This, however, is a byproduct of the singleton pattern. It is not the goal of the singleton pattern.

By **easy** access I mean of course **global** access. That is the motivation many developers have when using the singleton pattern. But what is wrong with a globally accessible object?

While I don't want to dive into the details of why globals are a bad idea, I do want to emphasize the drawbacks of the singleton pattern when used incorrectly, that is, for global access to a single object.

Making an object globally accessible instead of passing it around is considered an anti-pattern. Whenever you are about to create a singleton, consider why it is necessary to make it a globally accessible object. Is it convenience? Is there an alternative approach that also solves the problem?

Another reason for not turning the `CoreDataManager` instance into a singleton is **dependency management**. Globally accessible objects that are used in various places of a project obfuscate the dependencies of the project. A much better approach is to use dependency injection. I have written several articles about dependency injection because I really enjoy the simplicity and transparency of dependency injection. It is much easier than most developers think. I like to quote James Shore whenever I discuss dependency injection.

> "Dependency injection is a 25-dollar term for a 5-cent concept." — [James Shore](http://www.jamesshore.com/Blog/Dependency-Injection-Demystified.html)

**Read this article on [Cocoacasts](https://cocoacasts.com/passing-it-around/)**.
