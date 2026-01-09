if (HEMTT_RFS.join(".local").exists()) {
    print("Skipping production flag");
    exit(0);
}

let file = HEMTT_VFS.join("addons")
    .join("main")
    .join("script_production.hpp")
    .create_file()
    .write("#define __A3USPCM_PRODUCTION__");
