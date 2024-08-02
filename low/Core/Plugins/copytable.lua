local json = require 'json'
return function (table)
    return json.decode(json.encode(table))
end