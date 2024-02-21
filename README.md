![Release](https://github.com/metricsrbx/property-system/workflows/Release/badge.svg)[![CI](https://github.com/metricsrbx/property-system/actions/workflows/ci.yaml/badge.svg)](https://github.com/metricsrbx/property-system/actions/workflows/ci.yaml)

This property system is a basic constructed system for ease and creating, for RP/RO-nations especially.

> THIS IS NOT THE FINALIZED VERSION

## Getting Started

### Installation

Installing this system is as simple as dropping the module into your game. You can also be used with a [Rojo](https://rojo.space/) workflow.

#### Roblox Studio

1. Download the latest release of this system from [Github Releases](https://github.com/metricsrbx/property-system/releases)
2. Amend or add Services, Components or Controllers to customise this system wherever you want.

#### Rojo

To build the place from scratch, use:

```bash
rojo build -o "property-system.rbxlx"
```

Next, open `property-system.rbxlx` in Roblox Studio and start the Rojo server:

```bash
rojo serve
```

For more help, check out [the Rojo documentation](https://rojo.space/docs).

### Basic Usage

Components: Bind components to Roblox instances using the Component class and CollectionService tags and create functionality on-top of the existant system.

Services: Services are singleton provider objects that serve a specific purpose on the server. An example is OwnershipService which manages the ownership of properties, you can link this to a MoneyService to charge for properties.

Controllers: Controllers are singleton provider objects that serve a specific purpose on the client. An example is using a controller to have a UI to let others access your property.

## Contributing

Contributions are welcome! To contribute, please fork the repository and submit a pull request with your changes. Before submitting a pull request, please ensure that your code is following [Roblox Lua Style Guide](https://roblox.github.io/lua-style-guide/).
