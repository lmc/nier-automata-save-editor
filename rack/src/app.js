(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.App = (function() {

    function App() {
      this.chip_options_html = __bind(this.chip_options_html, this);

      this.row_html = __bind(this.row_html, this);

      this.reader_onload = __bind(this.reader_onload, this);

      this.file_change = __bind(this.file_change, this);
      document.getElementById('file').addEventListener('change', this.file_change, false);
      this.output = document.getElementById('output');
      this.tbody = document.getElementById('tbody');
    }

    App.prototype.CHIPS_OFFSET = 206012;

    App.prototype.CHIPS_SIZE = 48;

    App.prototype.CHIPS_COUNT = 64;

    App.prototype.CHIP_NIL = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 0];

    App.prototype.CATEGORIES = {
      42: "System",
      9: "Max HP Up",
      29: "Hijack Boost",
      30: "Stun",
      7: "Ranged Defense",
      6: "Melee Defense",
      4: "Ranged Attack Up",
      1: "Weapon Attack Up",
      63: "Auto Weapon Switch",
      62: "Auto Program",
      61: "Auto Evade",
      60: "Auto Fire",
      59: "Auto Attack",
      35: "Item Scan",
      58: "HUD: Fishing Spots",
      55: "HUD: Control",
      54: "HUD: Objectives",
      53: "HUD: Damage Values",
      52: "HUD: Save Points",
      51: "HUD: EXP Gauge",
      50: "HUD: Mini-Map",
      49: "HUD: Text Log",
      48: "HUD: Skill Gauge",
      41: "HUD: Enemy Data",
      40: "HUD: Sound Waves",
      39: "HUD: HP Gauge",
      47: "Auto-Collect Items",
      45: "Continuous Combo",
      46: "Bullet Detonation",
      44: "Evasive System",
      38: "Death Rattle"
    };

    App.prototype.CHIP_IDS = {
      3338: "OS Chip",
      3073: "Max HP Up",
      3074: "Max HP Up +1",
      3075: "Max HP Up +2",
      3076: "Max HP Up +3",
      3289: "Stun",
      3290: "Stun +1",
      3291: "Stun +2",
      3262: "Hijack Boost",
      3263: "Hijack Boost +1",
      3264: "Hijack Boost +2",
      3055: "Ranged Defense",
      3046: "Melee Defense",
      3047: "Melee Defense +1",
      3028: "Ranged Attack Up",
      3001: "Weapon Attack Up",
      3358: "Auto Weapon Switch",
      3357: "Auto Program",
      3356: "Auto Evade",
      3355: "Auto Fire",
      3354: "Auto Attack",
      3208: "Item Scan",
      3353: "HUD: Fishing Spots",
      3350: "HUD: Control",
      3349: "HUD: Objectives",
      3348: "HUD: Damage Values",
      3347: "HUD: Save Points",
      3346: "HUD: EXP Gauge",
      3345: "HUD: Mini-Map",
      3344: "HUD: Text Log",
      3343: "HUD: Skill Gauge",
      3337: "HUD: Enemy Data",
      3336: "HUD: Sound Waves",
      3335: "HUD: HP Gauge",
      3342: "Auto-Collect Items",
      3340: "Continuous Combo",
      3341: "Bullet Detonation",
      3339: "Evasive System",
      3334: "Death Rattle"
    };

    App.prototype.file_change = function(evt) {
      var blob, file, files, reader;
      files = evt.target.files;
      file = files[0];
      blob = file.slice(this.CHIPS_OFFSET, this.CHIPS_OFFSET + (this.CHIPS_SIZE * this.CHIPS_COUNT));
      reader = new FileReader;
      reader.onload = this.reader_onload;
      return reader.readAsArrayBuffer(blob);
    };

    App.prototype.reader_onload = function(event) {
      var chips, i, idx, ints, j, view, _i, _j, _len, _ref, _results;
      view = new DataView(event.target.result);
      chips = [];
      for (i = _i = 0, _ref = this.CHIPS_COUNT; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        j = 0;
        ints = [];
        while (j < this.CHIPS_SIZE) {
          ints.push(view.getInt32((this.CHIPS_SIZE * i) + j, true));
          j += 4;
        }
        chips.push(ints);
      }
      _results = [];
      for (idx = _j = 0, _len = chips.length; _j < _len; idx = ++_j) {
        ints = chips[idx];
        _results.push(this.tbody.innerHTML += this.row_html(ints, idx));
      }
      return _results;
    };

    App.prototype.row_html = function(chip, index) {
      return "<tr id=\"chip_" + index + "\">\n  <td>\n    <input name=\"chip[" + index + "][id]\" value=\"" + chip[0] + "\">\n  </td>\n  <td>\n    <select name=\"chip[" + index + "][chip]\" class=\"chip\">" + (this.chip_options_html(chip)) + "</select>\n  </td>\n  <td>\n    <input name=\"chip[" + index + "][slots]\" value=\"" + chip[4] + "\">\n  </td>\n</tr>";
    };

    App.prototype.chip_options_html = function(chip) {
      var chip_id, html, name, _ref;
      html = "<option value>-</option>";
      _ref = this.CHIP_IDS;
      for (chip_id in _ref) {
        name = _ref[chip_id];
        html += "<option value='" + chip_id + "' " + (parseInt(chip_id) === parseInt(chip[1]) ? ' selected' : '') + ">" + name + "</option>\n";
      }
      return html;
    };

    return App;

  })();

  window.onload = function() {
    return window.app = new App;
  };

}).call(this);
