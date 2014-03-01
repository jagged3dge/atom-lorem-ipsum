{WorkspaceView} = require 'atom'

describe 'lorem-ipsum', ->
    [view, editor, buffer, promise] = []

    beforeEach ->
        atom.workspaceView = new WorkspaceView
        atom.workspaceView.openSync 'empty.txt'
        atom.workspaceView.attachToDom()

        atom.workspace = {}
        atom.workspace.getActiveEditor = ->
            editor

        promise = atom.packages.activatePackage('atom-lorem-ipsum')

        runs ->
            view = atom.workspaceView.getActiveView()
            {editor} = view
            {buffer} = editor

    describe 'lorem-ipsum:sentence', ->
        it 'generates one sentence', ->
            expect(editor.getText()).toEqual ""
            view.trigger 'lorem-ipsum:sentence'

            waitsForPromise ->
                promise

            runs ->
                text = editor.getText()
                expect(text).not.toEqual ""
                expect(text.indexOf('.') - text.length + 1).toEqual 0

    describe 'lorem-ipsum:paragraph', ->
        it 'generate one paragraph', ->

            expect(editor.getText()).toEqual ""
            view.trigger 'lorem-ipsum:paragraph'

            waitsForPromise ->
                promise

            runs ->
                text = editor.getText()
                expect(text).not.toEqual ""
                expect(text.indexOf("\n") - text.length + 1).toEqual 0
                expect(text.split('.').length).toBeGreaterThan 1

    describe 'lorem-ipsum:paragraphs', ->
        it 'generate multiple paragraphs', ->

            expect(editor.getText()).toEqual ""
            view.trigger 'lorem-ipsum:paragraphs'

            waitsForPromise ->
                promise

            runs ->
                text = editor.getText()
                expect(text).not.toEqual ""
                expect(text.split("\n").length).toBeGreaterThan 1