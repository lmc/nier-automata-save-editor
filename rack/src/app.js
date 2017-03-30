(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  this.App = (function() {

    function App() {
      this.reader_onload = __bind(this.reader_onload, this);

      this.file_change = __bind(this.file_change, this);
      document.getElementById('file').addEventListener('change', this.file_change, false);
      this.output = document.getElementById('output');
    }

    App.prototype.CHIPS_OFFSET = 206012;

    App.prototype.CHIPS_SIZE = 48;

    App.prototype.CHIPS_COUNT = 300;

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
      var chips, i, ints, j, view, _i, _j, _len, _ref, _results;
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
      for (_j = 0, _len = chips.length; _j < _len; _j++) {
        ints = chips[_j];
        _results.push(this.output.innerText += "[" + (ints.join(', ')) + "]\n");
      }
      return _results;
    };

    return App;

  })();

  window.onload = function() {
    return window.app = new App;
  };

}).call(this);
