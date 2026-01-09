let modcpp = HEMTT_VFS.join("mod.cpp").open_file().read();
modcpp.replace("0.0.0", HEMTT.project().version().to_string());
HEMTT_VFS.join("mod.cpp").create_file().write(modcpp);
print("mod.cpp version set");

let scriptversion = HEMTT_VFS.join("addons").join("main").join("script_version.hpp").open_file().read();
let scriptversion_date = date("[year repr:last_two][month][day]");
scriptversion.replace("000000", scriptversion_date);
HEMTT_VFS.join("addons").join("main").join("script_version.hpp").create_file().write(scriptversion);
print("addons/main/script_version.hpp build set to " + scriptversion_date);
