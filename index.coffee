window.lorem = require 'lorem-ipsum'

module.exports =
    activate: (state) ->
        atom.workspaceView.on('lorem-ipsum:sentence', ->
            editor = atom.workspaceView.getActivePaneItem()
            editor.insertText generate()
        )

        atom.workspaceView.on('lorem-ipsum:paragraph', ->
            editor = atom.workspaceView.getActivePaneItem()
            editor.insertText generate {
                'units': 'paragraphs'
            }
        )

        atom.workspaceView.on('lorem-ipsum:paragraphs', ->
            editor = atom.workspaceView.getActivePaneItem()
            editor.insertText generate {
                units : 'paragraphs'
                count : Math.floor Math.random() * 4 + 1
            }
        )

    serialize: ->

    deactivate: ->

defaults =
    count:1
    units:'sentence'
    sentenceLowerBound:5
    sentenceUpperBound:15
    paragraphLowerBound:4
    paragraphUpperBound:10
    format:'plain'

generate = (options = {}) ->
    options[key] = defaults[key] for key of defaults when options[key] == undefined
    lorem options
