## Localization 

### Files
The localization files are of type `json` and should be in `assets/languages` directory.
The name of the file should be the localization [languageCode] (e.g. `en.json`)

### Initialization
You do not need to initialize anything, all the initialization is done by Flutter.

### How to add new localization text
To add a new localization text, you need to add a normal json `key` and `value` to each localization file. 
Where the `key` is the key of the localization and the `value` is the translated text.

```json
//en.json
{
    "welcomeMessage": "Welcome to Garage!"
}
```

```json
//ar.json
{
    "welcomeMessage": "حياك في قراج!"
}
```

Then you can use it in Flutter by simple using `translate` method.

```dart
Text('welcomeMessage'.translate())
```

#### Add dynamic variables to localization
It's possible to have dynamic variables in your translated text.

You can add a variable by using the `^[]` annotation.

```json
//en.json
{
    "welcomeMessage": "Welcome Mr.^[] to Garage!"
}
```

Then in Flutter you can use:
```dart
'welcomeMessage'.translate(arguments: ["Hady"]) //Welcome Mr.Hady to Garage!
```

---

It's possible to have more than one dynamic variable in your text, for example:


```json
//en.json
{
    "welcomeMessage": "Welcome Mr.^[] to ^[]!"
}
```

Then in Flutter you can use:
```dart
const appName = 'Garage'

'welcomeMessage'.translate(arguments: ["Hady", appName]) //Welcome Mr.Hady to Garage!
```

##### Localized variables
Moreover, the argument could be translated as well!

For example:

```json
//en.json
{
    "garage": "GARAGE 🚨",
    "welcomeMessage": "Welcome Mr.^[] to ^[]!"
}
```

Then in Flutter you can use:
```dart
const appName = 'garage'

'welcomeMessage'.translate(arguments: ["Hady", appName]) //Welcome Mr.Hady to GARAGE 🚨!
```

---

#### Parent keys
To make the `json` files organized, you can create a parent key. For example:

```json
//en.json
{
    "messages": {
        "welcome": "Welcome to Garage!",
        "bye": "bye!"
    }
}
```
Then in Flutter you can use:
```dart
'welcome'.translate(parent: 'messages') //Welcome to Garage!
```

You can also use the following syntax:
```dart
'messages.welcome'.translate() //Welcome to Garage!
```


### Key conventions
Key should be:
 - In camel case (e.g. `welcomeMessage` ✅)
 - With no spaces (e.g. `welcome message` ❌)
 - As described as possible, it's possible to be 30 characters long (e.g. `notFound` ❌ | `carNotFoundMessage` ✅)
 - Use [parent keys] when possible
 - Avoid duplications by using [dynamic variables]

[languageCode]: https://api.flutter.dev/flutter/dart-ui/Locale/languageCode.html
[parent keys]: #parent-keys
[dynamic variables]: #add-dynamic-variables-to-localization
