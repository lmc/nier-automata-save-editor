class @App
  constructor: () ->
    document.getElementById('file').addEventListener('change', @file_change, false)
    @output = document.getElementById('output')

  CHIPS_OFFSET: 206012
  CHIPS_SIZE: 48
  CHIPS_COUNT: 300

  file_change: (evt) =>
    files = evt.target.files
    file = files[0]
    blob = file.slice(@CHIPS_OFFSET,@CHIPS_OFFSET+(@CHIPS_SIZE*@CHIPS_COUNT))

    reader = new FileReader
    reader.onload = @reader_onload
    reader.readAsArrayBuffer(blob)

  reader_onload: (event) =>
    view = new DataView(event.target.result)

    chips = []
    for i in [0...@CHIPS_COUNT]
      j = 0
      ints = []
      while j < @CHIPS_SIZE
        ints.push(view.getInt32((@CHIPS_SIZE * i) + j,true))
        j += 4
      chips.push(ints)

    for ints in chips
      @output.innerText += "[#{ints.join(', ')}]\n"

window.onload = ->
  window.app = new App
