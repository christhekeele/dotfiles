install_package "openssl-1.0.2h" "https://www.openssl.org/source/openssl-1.0.2h.tar.gz#1d4007e53aad94a5b2002fe045ee7bb0b3d98f1a47f8b2bc851dcd1c74332919" mac_openssl --if has_broken_mac_openssl
install_git "2.4.0.tenderlove" "https://github.com/tenderlove/ruby.git" "binload" ldflags_dirs autoconf standard verify_openssl
