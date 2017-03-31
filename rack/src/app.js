(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.App = (function() {

    function App() {
      this.save_tab_click = __bind(this.save_tab_click, this);

      this.nav_tab = __bind(this.nav_tab, this);

      this.nav_tabs = __bind(this.nav_tabs, this);

      this.chip_options_html = __bind(this.chip_options_html, this);

      this.row_html = __bind(this.row_html, this);

      this.reader_onload = __bind(this.reader_onload, this);

      this.file_change = __bind(this.file_change, this);
      console.log("app constructor");
      document.getElementById('file').addEventListener('change', this.file_change, false);
      $('a[href="#save"').on("click", this.save_tab_click);
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
      var file, files;
      this.tbody.innerHTML = "";
      this.nav_tab('edit').tab('show');
      files = evt.target.files;
      file = files[0];
      this.blob = file;
      this.reader = new FileReader;
      this.reader.onload = this.reader_onload;
      return this.reader.readAsArrayBuffer(this.blob);
    };

    App.prototype.reader_onload = function(event) {
      var chips, i, idx, ints, j, _i, _j, _len, _ref, _results;
      this.view = new DataView(event.target.result);
      chips = [];
      for (i = _i = 0, _ref = this.CHIPS_COUNT; 0 <= _ref ? _i < _ref : _i > _ref; i = 0 <= _ref ? ++_i : --_i) {
        j = 0;
        ints = [];
        while (j < this.CHIPS_SIZE) {
          ints.push(this.view.getInt32(this.CHIPS_OFFSET + (this.CHIPS_SIZE * i) + j, true));
          j += 4;
        }
        chips.push(ints);
      }
      this.chips = chips;
      this.tbody.innerHTML = "";
      _results = [];
      for (idx = _j = 0, _len = chips.length; _j < _len; idx = ++_j) {
        ints = chips[idx];
        _results.push(this.tbody.innerHTML += this.row_html(ints, idx));
      }
      return _results;
    };

    App.prototype.row_html = function(chip, index) {
      return "<tr id=\"chip_" + index + "\">\n  <td>\n    <input name=\"chip[" + index + "][id]\" value=\"" + chip[0] + "\" class=\"form-control\" size=\"3\">\n  </td>\n  <td>\n    <select name=\"chip[" + index + "][chip]\" class=\"chip form-control\">" + (this.chip_options_html(chip)) + "</select>\n  </td>\n  <td>\n    <input name=\"chip[" + index + "][2]\" value=\"" + chip[2] + "\" class=\"form-control\" size=\"3\">\n  </td>\n  <td>\n    <input name=\"chip[" + index + "][3]\" value=\"" + chip[3] + "\" class=\"form-control\" size=\"3\">\n  </td>\n  <td>\n    <input name=\"chip[" + index + "][slots]\" value=\"" + chip[4] + "\" class=\"form-control\" size=\"3\">\n  </td>\n  <td>\n    <input name=\"chip[" + index + "][5]\" value=\"" + chip[5] + "\" class=\"form-control\" size=\"3\">\n  </td>\n  <td>\n    <input name=\"chip[" + index + "][6]\" value=\"" + chip[6] + "\" class=\"form-control\" size=\"3\">\n  </td>\n  <td>\n    <input name=\"chip[" + index + "][7]\" value=\"" + chip[7] + "\" class=\"form-control\" size=\"3\">\n  </td>\n  <td>\n    <input name=\"chip[" + index + "][8]\" value=\"" + chip[8] + "\" class=\"form-control\" size=\"3\">\n  </td>\n  <td>\n    <input name=\"chip[" + index + "][9]\" value=\"" + chip[9] + "\" class=\"form-control\" size=\"3\">\n  </td>\n  <td>\n    <input name=\"chip[" + index + "][10]\" value=\"" + chip[10] + "\" class=\"form-control\" size=\"3\">\n  </td>\n  <td>\n    <input name=\"chip[" + index + "][11]\" value=\"" + chip[11] + "\" class=\"form-control\" size=\"3\">\n  </td>\n\n</tr>";
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

    App.prototype.nav_tabs = function() {
      return $('.nav.nav-tabs a');
    };

    App.prototype.nav_tab = function(id) {
      return this.nav_tabs().filter('[href="#' + id + '"]');
    };

    App.prototype.save_tab_click = function(event) {};

    return App;

  })();

  window.onload = function() {
    return window.app = new App;
  };

}).call(this);
