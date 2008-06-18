/*
Stop||Reload button
by Caio Chassot 

modified by onemen 2006-11-21

The magic is achieved by a dirty little hack:
we still have two buttons, but one of them is always hidden.
If you can stop, stop appears, otherwise reload appears
*/

var stopOrReload = {
  _BrowserToolboxCustomizeDone: null,
  _BrowserCustomizeToolbar: null,
  customizingToolbar: null,
  stopButton: null,
  reloadButton: null,

  init: function sr_init() {
    window.removeEventListener("load", this, false);
    window.addEventListener("unload", this, false);
    // both buttons must be showing while customizing toolbars otherwise we run into trouble. we use this var to keep track
    customizingToolbar = false;

    this.getButtons();
    this.toggleStopAndReloadButtons();

    this._BrowserCustomizeToolbar = BrowserCustomizeToolbar;
    BrowserCustomizeToolbar = function BrowserCustomizeToolbar() {
      stopOrReload.customizingToolbar = true;
      stopOrReload.reloadButton.style.display = '-moz-box';
      stopOrReload.stopButton  .style.display = '-moz-box';
      stopOrReload._BrowserCustomizeToolbar();
    }

    this._BrowserToolboxCustomizeDone = BrowserToolboxCustomizeDone;
    BrowserToolboxCustomizeDone = function BrowserToolboxCustomizeDone(aToolboxChanged) {
      stopOrReload.customizingToolbar = false;
      stopOrReload._BrowserToolboxCustomizeDone(aToolboxChanged);
      stopOrReload.getButtons();
      stopOrReload.toggleStopAndReloadButtons();
    }
  },

  toggleStopAndReloadButtons: function sr_toggleStopAndReloadButtons() {
    if (this.customizingToolbar)
      return;
    var stopDisabled = this.stopButton.getAttribute('disabled') == 'true';
    this.reloadButton.style.display =  stopDisabled ? '-moz-box' : 'none';
    this.stopButton  .style.display = !stopDisabled ? '-moz-box' : 'none';
  },

  getButtons: function sr_getButtons() {
    this.stopButton  = document.getElementById('stop-button');
    this.reloadButton = document.getElementById('reload-button');
    this.stopButton.addEventListener('DOMAttrModified', this, false);
  },
  
  handleEvent: function sr_handleEvent(aEvent) {
    switch (aEvent.type) {
      case "load":
        this.init();
        break;
      case "unload":
        window.removeEventListener("unload", this, false);
        this.stopButton.removeEventListener('DOMAttrModified', this, false);
        break;
      case "DOMAttrModified":
        if (aEvent.attrName == 'disabled')
          this.toggleStopAndReloadButtons();
        break;
    }
  }
}

window.addEventListener("load", stopOrReload, false);
