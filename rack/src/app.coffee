class @App
  constructor: () ->
    document.getElementById('file').addEventListener('change', @file_change, false)
    @output = document.getElementById('output')
    @tbody = document.getElementById('tbody')

  CHIPS_OFFSET: 206012
  CHIPS_SIZE: 48
  # CHIPS_COUNT: 300
  CHIPS_COUNT: 64
  CHIP_NIL: [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0]

  CATEGORIES: {
    42 : "System",
    9  : "Max HP Up",
    29 : "Hijack Boost",
    30 : "Stun",
    7  : "Ranged Defense",
    6  : "Melee Defense",
    4  : "Ranged Attack Up",
    1  : "Weapon Attack Up",
    63 : "Auto Weapon Switch",
    62 : "Auto Program",
    61 : "Auto Evade",
    60 : "Auto Fire",
    59 : "Auto Attack",
    35 : "Item Scan",
    58 : "HUD: Fishing Spots",
    55 : "HUD: Control",
    54 : "HUD: Objectives",
    53 : "HUD: Damage Values",
    52 : "HUD: Save Points",
    51 : "HUD: EXP Gauge",
    50 : "HUD: Mini-Map",
    49 : "HUD: Text Log",
    48 : "HUD: Skill Gauge",
    41 : "HUD: Enemy Data",
    40 : "HUD: Sound Waves",
    39 : "HUD: HP Gauge",
    47 : "Auto-Collect Items",
    45 : "Continuous Combo",
    46 : "Bullet Detonation",
    44 : "Evasive System",
    38 : "Death Rattle",
  }

  CHIP_IDS: {
    3338 : "OS Chip",

    3073 : "Max HP Up",
    3074 : "Max HP Up +1",
    3075 : "Max HP Up +2",
    3076 : "Max HP Up +3",

    3289 : "Stun",
    3290 : "Stun +1",
    3291 : "Stun +2",

    3262 : "Hijack Boost",
    3263 : "Hijack Boost +1",
    3264 : "Hijack Boost +2",

    3055 : "Ranged Defense",
    3046 : "Melee Defense",
    3047 : "Melee Defense +1",

    3028 : "Ranged Attack Up",

    3001 : "Weapon Attack Up",

    3358 : "Auto Weapon Switch",
    3357 : "Auto Program",
    3356 : "Auto Evade",
    3355 : "Auto Fire",
    3354 : "Auto Attack",

    3208 : "Item Scan",

    3353 : "HUD: Fishing Spots",
    3350 : "HUD: Control",
    3349 : "HUD: Objectives",
    3348 : "HUD: Damage Values",
    3347 : "HUD: Save Points",
    3346 : "HUD: EXP Gauge",
    3345 : "HUD: Mini-Map",
    3344 : "HUD: Text Log",
    3343 : "HUD: Skill Gauge",
    3337 : "HUD: Enemy Data",
    3336 : "HUD: Sound Waves",
    3335 : "HUD: HP Gauge",

    3342 : "Auto-Collect Items",

    3340 : "Continuous Combo",

    3341 : "Bullet Detonation",

    3339 : "Evasive System",

    3334 : "Death Rattle",

  }

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

    for ints,idx in chips
      @tbody.innerHTML += @row_html(ints,idx)

  row_html: (chip,index) =>
    """
      <tr id="chip_#{index}">
        <td>
          <input name="chip[#{index}][id]" value="#{chip[0]}">
        </td>
        <td>
          <select name="chip[#{index}][chip]" class="chip">#{@chip_options_html(chip)}</select>
        </td>
        <td>
          <input name="chip[#{index}][slots]" value="#{chip[4]}">
        </td>
      </tr>
    """

  chip_options_html: (chip) =>
    html = "<option value>-</option>"
    for chip_id,name of @CHIP_IDS
      html += "<option value='#{chip_id}' #{if parseInt(chip_id) == parseInt(chip[1]) then ' selected' else ''}>#{name}</option>\n"
    html

window.onload = ->
  window.app = new App
