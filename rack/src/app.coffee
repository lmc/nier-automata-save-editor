class @App
  constructor: () ->
    console.log("app constructor")
    document.getElementById('file').addEventListener('change', @file_change, false)

    $('a[href="#save"').on("click",@save_tab_click)

    @output = document.getElementById('output')
    @tbody = document.getElementById('tbody')

  CHIPS_OFFSET: 206012
  CHIPS_SIZE: 48
  # CHIPS_COUNT: 300
  CHIPS_COUNT: 64
  CHIP_NIL: [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0]

  CATEGORIES: {
     1 : "Weapon Attack Up",
     2 : "Down Attack Up",
     3 : "Critical Up",
     4 : "Ranged Attack Up",
     5 : null,
     6 : "Melee Defense",
     7 : "Ranged Defense",
     8 : null,
     9 : "Max HP Up",
    10 : "Offensive Heal",
    11 : "Deadly Heal",
    12 : "Auto Heal",
    13 : "Evade Range Up",
    14 : "Moving Speed Up",
    15 : null,
    16 : null,
    17 : "Shock Wave",
    18 : "Last Stand",
    19 : "Damage Absorb",
    20 : "Vengeance",
    21 : "Reset",
    22 : "Overclock",
    23 : "Resilience",
    24 : "Counter",
    25 : "Taunt Up",
    26 : "Charge Attack",
    27 : "Auto-Use Item",
    29 : "Hijack Boost",
    30 : "Stun",
    31 : "Combust",
    34 : null,
    35 : "Item Scan",
    38 : "Death Rattle",
    39 : "HUD: HP Gauge",
    40 : "HUD: Sound Waves",
    41 : "HUD: Enemy Data",
    42 : "OS Chip",
    44 : "Evasive System",
    45 : "Continuous Combo",
    46 : "Bullet Detonation",
    47 : "Auto-Collect Items",
    48 : "HUD: Skill Gauge",
    49 : "HUD: Text Log",
    50 : "HUD: Mini-Map",
    51 : "HUD: EXP Gauge",
    52 : "HUD: Save Points",
    53 : "HUD: Damage Values",
    54 : "HUD: Objectives",
    55 : "HUD: Control",
    58 : "HUD: Fishing Spots",
    59 : "Auto Attack",
    60 : "Auto Fire",
    61 : "Auto Evade",
    62 : "Auto Program",
    63 : "Auto Weapon Switch",
  }

  CATEGORIES_TO_BASE_ITEM_IDS: {
     1 : 3001,
     2 : 3010,
     3 : 3019,
     4 : 3028,
     5 : null,
     6 : 3046,
     7 : 3055,
     8 : null,
     9 : 3073,
    10 : 3082,
    11 : 3091,
    12 : 3100,
    13 : 3109
    14 : 3118,
    15 : null,
    16 : null,
    17 : 3145,
    18 : 3154,
    19 : 3163,
    20 : 3172,
    21 : 3181,
    22 : 3190,
    23 : 3199
    24 : 3217,
    25 : 3226,
    26 : 3235,
    27 : 3244,
    29 : 3262,
    30 : 3289,
    31 : 3298,
    34 : null,
    35 : 3208,
    38 : 3334,
    39 : 3335, # noup
    40 : 3336, # noup,
    41 : 3337, # noup
    42 : 3338, # noup,
    44 : 3339, # noup,
    45 : 3340, # noup,
    46 : 3341, # noup,
    47 : 3342, # noup,
    48 : 3343,
    49 : 3344,
    50 : 3345,
    51 : 3346,
    52 : 3347,
    53 : 3348,
    54 : 3349,
    55 : 3350,
    58 : 3353,
    59 : 3354,
    60 : 3355,
    61 : 3356,
    62 : 3357,
    63 : 3358,
  }

  CHIP_IDS: {
    3001 : "Weapon Attack Up",
    3010 : "Down Attack Up",
    3019 : "Critical Up",
    3028 : "Ranged Attack Up",
    3046 : "Melee Defense",
    3055 : "Ranged Defense",
    3073 : "Max HP Up",
    3082 : "Offensive Heal",
    3091 : "Deadly Heal",
    3100 : "Auto Heal",
    3109 : "Evade Range Up",
    3118 : "Moving Speed Up",
    3145 : "Shock Wave",
    3154 : "Last Stand",
    3163 : "Damage Absorb",
    3172 : "Vengeance",
    3181 : "Reset",
    3190 : "Overclock",
    3199 : "Resilience",
    3208 : "Item Scan",
    3217 : "Counter",
    3226 : "Taunt Up",
    3235 : "Charge Attack",
    3244 : "Auto-Use Item",
    3262 : "Hijack Boost",
    3289 : "Stun",
    3298 : "Combust",
    3334 : "Death Rattle",
    3335 : "HUD: HP Gauge",
    3336 : "HUD: Sound Waves",
    3337 : "HUD: Enemy Data",
    3338 : "OS Chip",
    3339 : "Evasive System",
    3340 : "Continuous Combo",
    3341 : "Bullet Detonation",
    3342 : "Auto-Collect Items",
    3343 : "HUD: Skill Gauge",
    3344 : "HUD: Text Log",
    3345 : "HUD: Mini-Map",
    3346 : "HUD: EXP Gauge",
    3347 : "HUD: Save Points",
    3348 : "HUD: Damage Values",
    3349 : "HUD: Objectives",
    3350 : "HUD: Control",
    3353 : "HUD: Fishing Spots",
    3354 : "Auto Attack",
    3355 : "Auto Fire",
    3356 : "Auto Evade",
    3357 : "Auto Program",
    3358 : "Auto Weapon Switch",

  }

  # derive chip id from category + level
  # have map of category => case chip id, add level
  # auto-calculate id number
  # have map of which categories can be levelled or not

  file_change: (evt) =>
    @tbody.innerHTML = ""
    @nav_tab('edit').tab('show')

    files = evt.target.files
    file = files[0]
    @blob = file
    # @blob = file.slice(@CHIPS_OFFSET,@CHIPS_OFFSET+(@CHIPS_SIZE*@CHIPS_COUNT))

    @reader = new FileReader
    @reader.onload = @reader_onload
    @reader.readAsArrayBuffer(@blob)

  reader_onload: (event) =>
    @view = new DataView(@reader.result)

    chips = []
    for i in [0...@CHIPS_COUNT]
      j = 0
      ints = []
      while j < @CHIPS_SIZE
        ints.push(@view.getInt32(@CHIPS_OFFSET + (@CHIPS_SIZE * i) + j,true))
        j += 4
      chips.push(ints)
    @chips = chips

    @tbody.innerHTML = ""
    for ints,idx in chips
      @tbody.innerHTML += @row_html(ints,idx)

  row_html: (chip,index) =>
    """
      <tr id="chip_#{index}">
        <td>
          <select name="chip[#{index}][type]" class="form-control">#{@chip_options_html(chip)}</select>
        </td>
        <td>
          <input name="chip[#{index}][level]" value="#{chip[3]}" class="form-control" size="3">
        </td>
        <td>
          <input name="chip[#{index}][slots]" value="#{chip[4]}" class="form-control" size="3">
        </td>
        <td>
          <input name="chip[#{index}][raw]" value="#{chip.join(", ")}" id="input_chip_#{index}" class="form-control" size="50" style="font-family: monospace;">
        </td>
      </tr>
    """

  write_form_values_to_blob: =>
    for i in [0...@CHIPS_COUNT]
      input = $("#input_chip_#{i}")
      values = input.val().split(/, ?/)
      debugger
      for value,j in values
        value = parseInt(value)
        @view.setInt32(@CHIPS_OFFSET + (@CHIPS_SIZE * i) + (j * 4),value,true)

    blob = new Blob([@view], {type: "octet/stream"})

    @nav_tab('save').tab('show')
    $('#save_link').attr("download","edited.dat")
    $('#save_link').attr("href",window.URL.createObjectURL(blob))

  chip_options_html: (chip) =>
    html = "<option value>-</option>"
    for id,name of @CATEGORIES
      html += "<option value='#{id}' #{if parseInt(id) == parseInt(chip[2]) then ' selected' else ''}>#{name}</option>\n"
    html

  nav_tabs: =>
    $('.nav.nav-tabs a')

  nav_tab: (id) =>
    @nav_tabs().filter('[href="#'+id+'"]')

  save_tab_click: (event) =>
    # generate save link

window.onload = ->
  window.app = new App
