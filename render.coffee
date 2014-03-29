fs = require 'fs'
Mustache = require 'mustache'
RSVP = require 'rsvp'


contentPromise = (stream) ->
    new RSVP.Promise (resolve, reject) ->
        content = ''
        stream.on 'error', (reason) -> reject reason
        stream.on 'end', (chunk) -> resolve content
        stream.on 'data', (chunk) -> content += chunk.toString()


RSVP.all(contentPromise(fs.createReadStream filename) for filename in process.argv[2..])
.then (contentsList) ->
    process.stdout.write Mustache.render contentsList[0], (JSON.parse(content) for content in contentsList[1..])...
.catch (reason) ->
    process.stderr.write reason
