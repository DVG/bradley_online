wrapText = (elementID, openTag, closeTag) ->
  textArea = $("##{elementID}") #select the text area
  len = textArea.val().length #total length of the text area
  start = textArea[0].selectionStart # start of the selected text
  end = textArea[0].selectionEnd # end of the selected text
  selectedText = textArea.val().substring(start, end) # The selected Text
  replacement = openTag + selectedText + closeTag # string with the selected text wrapped in the bbcode
  textArea.val(textArea.val().substring(0,start) + replacement + textArea.val().substring(end, len)) # perform the replacement

insertTextAtBeginningOfLine = (elementID, tag) ->
  textArea = $("##{elementID}") #select the text area
  len = textArea.val().length #total length of the text area
  start = textArea[0].selectionStart # start of the selected text
  end = textArea[0].selectionEnd # end of the selected text
  selectedText = textArea.val().substring(start, end) # The selected Text
  #insert tag after newlines
  selectedText = selectedText.replace(/(\n)/gm,"\n#{tag}");
  replacement = "#{tag}#{selectedText}"
  textArea.val(textArea.val().substring(0,start) + replacement + textArea.val().substring(end, len)) # perform the replacement

$ ->
  $('#italics_button').click (event) ->
    event.preventDefault()
    wrapText('post_body', '*', '*')
  $('#bold_button').click (event) ->
    event.preventDefault()
    wrapText('post_body', '**', '**')
  $('#code_button').click (event) ->
    event.preventDefault()
    wrapText('post_body', "~~~\n", "\n~~~")
  $('#quote_button').click (event) ->
    event.preventDefault()
    insertTextAtBeginningOfLine('post_body', '> ')
  $('#inline_code_button').click (event) ->
    event.preventDefault()
    wrapText('post_body', "`", "`")