module.exports =
  config:
    numberOfSpacesForIndent:
      title: 'Indent width for pretty print'
      description: 'The number of spaces used for indent when pretty-printing.'
      type: 'integer'
      default: 2
      minimum: 1

  activate: ->
    atom.commands.add 'atom-workspace', "jsonpp:jsonpp", => @jsonpp()
    atom.commands.add 'atom-workspace', "jsonpp:compact", => @compact()

  jsonpp: ->
    editor = atom.workspace.getActivePaneItem()
    select = editor.getLastSelection()
    tabspace = atom.config.get("jsonpp.numberOfSpacesForIndent")

    if not select? or not select or select.isEmpty()
      # transform all the text
      newCode = JSON.stringify(JSON.parse(editor.getText()), null, tabspace)
      editor.setText(newCode)
    else
      # replace the selection
      newCode = JSON.stringify(JSON.parse(select.getText()), null, tabspace)
      select.insertText(newCode)

  compact: ->
    editor = atom.workspace.getActivePaneItem()
    select = editor.getLastSelection()

    if not select? or not select or select.isEmpty()
      # transform all the text
      newCode = JSON.stringify(JSON.parse(editor.getText()))
      editor.setText(newCode)
    else
      # replace the selection
      newCode = JSON.stringify(JSON.parse(select.getText()))
      select.insertText(newCode)
