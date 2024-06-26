# Feather Database Driver SQLite

SQLite driver for the abstract feather-database component for Feather CMS.

## Getting started

⚠️ This repository is a work in progress, things can break until it reaches v1.0.0. 

Use at your own risk.

### Adding the dependency

To add a dependency on the package, declare it in your `Package.swift`:

```swift
.package(url: "https://github.com/feather-framework/feather-database-driver-sqlite", .upToNextMinor(from: "0.4.0")),
```

and to your application target, add `FeatherSQLDatabase` to your dependencies:

```swift
.product(name: "FeatherDatabaseDriverSQLite", package: "feather-database-driver-sqlite")
```

Example `Package.swift` file with `FeatherDatabaseDriverSQLite` as a dependency:

```swift
// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "my-application",
    dependencies: [
        .package(url: "https://github.com/feather-framework/feather-database-driver-sqlite", .upToNextMinor(from: "0.4.0")),
    ],
    targets: [
        .target(name: "MyApplication", dependencies: [
            .product(name: "FeatherDatabaseDriverSQLite", package: "feather-database-driver-sqlite")
        ]),
        .testTarget(name: "MyApplicationTests", dependencies: [
            .target(name: "MyApplication"),
        ]),
    ]
)
```

