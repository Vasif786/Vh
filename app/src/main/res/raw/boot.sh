#!/data/data/vn.com.termux/files/usr/bin/bash
[ -f ~/.profile ] && . ~/.profile
function _at_exit() {
  kill $(cat /data/data/vn.com.termux/files/.pid)
  rm -f /data/data/vn.com.termux/files/.pid
}
trap _at_exit EXIT SIGHUP SIGTERM SIGINT SIGKILL

/data/data/vn.com.termux/files/node <<SCRIPT

const fs = require("fs");


(function() {
  try{
    let p
    try{
      p = JSON.parse(fs.readFileSync("/data/data/vn.com.termux/files/home/.local/share/code-server/User/settings.json"));
    }catch(e){
    }
    if(!p) p = {};
    let needwrite = false;
    if(!p.hasOwnProperty("security.workspace.trust.enabled")) {
      console.log("Setting default option for security.workspace.trust.enabled: false");
      p["security.workspace.trust.enabled"]=false;
      needwrite = true;
    }
    if(!p.hasOwnProperty("terminal.integrated.gpuAcceleration")) {
      console.log("Setting default option for terminal.integrated.gpuAcceleration: off");
      p["terminal.integrated.gpuAcceleration"] = "off";
      needwrite = true;
    }
    if(needwrite) {
      try{
        fs.mkdirSync("/data/data/vn.com.termux/files/home/.local/share/code-server/User", {recursive: true});
      }catch(e){}
      fs.writeFileSync("/data/data/vn.com.termux/files/home/.local/share/code-server/User/settings.json", JSON.stringify(p, null, 2));
    }
  }catch(e){
    console.log("Error: ",e);
  }
})();

(function() {
  const p = JSON.parse(fs.readFileSync("/data/data/vn.com.termux/files/code-server/release-standalone/lib/termux/product.json"));
  if(p.extensionsGallery) {
    console.log("Extensions gallery defined, removing...");
    delete p.extensionsGallery;
    fs.writeFileSync("/data/data/vn.com.termux/files/code-server/release-standalone/lib/termux/product.json", JSON.stringify(p, null, 2));
  }
})()
SCRIPT

chmod +x /data/user/0/vn.com.termux/files/code-server/release-standalone/lib/termux/node_modules/@termux/ripgrep/bin/rg
mkdir -p /data/data/vn.com.termux/files/tmp
echo '$' /data/data/vn.com.termux/files/node "$@"
/data/data/vn.com.termux/files/node "$@" &
echo $! >/data/data/vn.com.termux/files/.pid
wait $!
