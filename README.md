# slide_animated_password_lock

A simple password input field with slide lock animation.

<img src="slide_animated_password_lock.gif" width="200px">

## Parameters
`hashedPassword` - Correct hashed password value to trigger the sliding animation 

`hashMethod` - Hashed method using for the password. Options available:  HashMethod.PlainText/ HashMethod.SHA1/ HashMethod.SHA224/ HashMethod.SHA256/ HashMethod.SHA384/ HashMethod.SHA512/ HashMethod.MD5/ HashMethod.HMACMD5/ HashMethod.HMACSHA1/ HashMethod.HMACSHA256

`hashKey` - (Optional) Hash key in use if using HashMethod.HMACMD5/ HashMethod.HMACSHA1/ HashMethod.HMACSHA256

`controller` - Text Editing Controller for textfield

`onUnlock` - Function handler when unlocked

`color` - Color of the input field

`width` - (Optional) the total width of the widget. Default to 250, require > 0

`height` - (Optional) the height of the widget. Default to 40, require > 0

`placeholder` - (Optional) placeholder in the textfield. Default to an empty string. 


## Getting Started
Add the plugin:
```yaml
    dependencies:
        slide_animated_password_lock: ^1.0.0
```


## Basic Usage

```dart
 SlideAnimatedPasswordLock(
  hashedPassword: _hashedPassword,
  hashMethod: HashMethod.MD5,
  controller: _textFieldController,
  color: Theme.of(context).primaryColor,
  placeholder: "HELLO WORLD",
  onUnlock: (_unlocked){
    if (_unlocked){
      setState(()=>_msg = "Unlocked!");
    }else{
      setState(()=>_msg = "Please unlock!");
    }
  },
),
```
