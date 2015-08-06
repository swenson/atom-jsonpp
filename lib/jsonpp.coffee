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

  deactivate: ->
    if @errorPanel?
      @errorPanel.destroy()

  jsonpp: ->
    try
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
    catch error
      @showError()

  compact: ->
    editor = atom.workspace.getActivePaneItem()
    select = editor.getLastSelection()

    try
      if not select? or not select or select.isEmpty()
        # transform all the text
        newCode = JSON.stringify(JSON.parse(editor.getText()))
        editor.setText(newCode)
      else
        # replace the selection
        newCode = JSON.stringify(JSON.parse(select.getText()))
        select.insertText(newCode)
    catch error
      @showError()

  showError: ->
    div = document.createElement('div')
    div.textContent = 'JSON Syntax Error'
    div.classList.add('message')
    button = document.createElement('span')
    button.textContent = '×'
    button.style.float = 'right';
    button.style.cursor = 'pointer';
    div.appendChild(button)
    @errorPanel = atom.workspace.addModalPanel(item: div, visible: true)
    div.onclick = =>
      @errorPanel.hide()
