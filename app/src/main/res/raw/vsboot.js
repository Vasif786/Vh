if(!window.termuxOrigKeyboardEventDescriptorCode) window.termuxOrigKeyboardEventDescriptorCode = Object.getOwnPropertyDescriptor(window.KeyboardEvent.prototype, 'code');
var codeGetter = window.termuxOrigKeyboardEventDescriptorCode.get;
// if(!window.termuxOrigKeyboardEventDescriptorShift) window.termuxOrigKeyboardEventDescriptorShift = Object.getOwnPropertyDescriptor(KeyboardEvent.prototype, 'shiftKey');
// var shiftGetter = window.termuxOrigKeyboardEventDescriptorShift.get;
// if(!window.termuxOrigKeyboardEventDescriptorAlt) window.termuxOrigKeyboardEventDescriptorAlt = Object.getOwnPropertyDescriptor(KeyboardEvent.prototype, 'altKey');
// var altGetter = window.termuxOrigKeyboardEventDescriptorAlt.get;

var customMapper = {
    27: 'Escape',
    9: 'Tab'
};
var customKeyRemapper = {
    'Backspace': 'Backspace',
    'Control': 'ControlLeft',
    'Alt': 'AltLeft',
};
var prepareCustomProps = function() {
    if(this._termux_modded) return;
    this._termux_modded = true;
    var orig = codeGetter.apply(this);
    if (this.key == 'Alt') {
        this._termuxCode = "";
    } else if (this.key === 'Shift') {
        this._termuxCode = "ShiftLeft";
    } else if (this.key.match(/^F[0-9]+$/)) {
        this._termuxCode = this.key;
    } else if (this.which in customMapper) {
        this._termuxCode = customMapper[this.which];
    } else if (orig === "" && typeof this.key === "string" && this.key.length) {
        if (this.key in customKeyRemapper) this._termuxCode = customKeyRemapper[this.key];
        else if(this.key>="a" && this.key<="z") this._termuxCode = "Key" + this.key.toUpperCase();
        else if(this.key>="A" && this.key<="Z") this._termuxCode = "Key" + this.key;
    } else this._termuxCode = orig;
}
Object.defineProperty(window.KeyboardEvent.prototype, 'code', {
    get(){
        prepareCustomProps.apply(this);
        return this._termuxCode;
    }
});
//Object.defineProperty(window.KeyboardEvent.prototype, 'altKey', {
//    get(){
//        if (!altGetter.apply(this)) return false;
//        prepareCustomProps.apply(this);
//        return this.code === "";
//    }
//});

//navigator.clipboard.read
