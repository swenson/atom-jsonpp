module.exports =
  activate: ->
    atom.workspaceView.command "jsonpp:jsonpp", => @jsonpp()

  jsonpp: ->
    editor = atom.workspace.activePaneItem
    code = editor.getText()
    newCode = JSON.stringify(JSON.parse(code), null, 2)
    editor.setText(newCode)
