# Usage

```bash
npm install -S https://github.com/AndreasPizsa/startup
```

The in your code, do

```javascript
var env = require('startup')({uses:'app'});

```

or more elegantly in CoffeeScript

```CoffeeScript
env = require 'startup' uses:'app'
```


# The Environment

Startup creates an "environment" which is a fancy word for a hash with useful instances of other tools.

```bash
npm install startup startup-restify startup-redis
```
```CoffeeScript
# app.coffee
env = require 'startup' uses:'app redis restify'
## results in
{
  _       : # lodash-instance
  rootDir : '/users/you/your-project'
  bunyan  : # bunyan
  log     : # bunyan instance
  nconf   : # nconf instance
  pkginfo : # package.json
}
```

# Config files
* `/config/{development|production}.json`
* `/config/{development|production}.{json|coffe|litcoffee}`


