module.exports =
  activate: ->
    atom.workspaceView.command "jsonpp:jsonpp", => @jsonpp()
    atom.workspaceView.command "jsonpp:compact", => @compact()

  jsonpp: ->
    editor = atom.workspace.activePaneItem
    select = editor.getSelection()

    if not select? or not select or select.isEmpty()
      # transform all the text
      newCode = JSON.stringify(JSON.parse(editor.getText()), null, 2)
      editor.setText(newCode)
    else
      # replace the selection
      newCode = JSON.stringify(JSON.parse(select.getText()), null, 2)
      select.insertText(newCode)

  compact: ->
    editor = atom.workspace.activePaneItem
    select = editor.getSelection()

    if not select? or not select or select.isEmpty()
      # transform all the text
      newCode = JSON.stringify(JSON.parse(editor.getText()))
      editor.setText(newCode)
    else
      # replace the selection
      newCode = JSON.stringify(JSON.parse(select.getText()))
      select.insertText(newCode)
