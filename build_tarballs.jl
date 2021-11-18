using BinaryBuilder

# Collection of sources required to build Xsum
sources = [
    "https://github.com/Cyan4973/xxHash/archive/v0.7.0.tar.gz" =>
    "b34792646d5e19964bb7bba24f06cb13aecaac623ab91a54da08aa19d3686d7e",
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/xxHash-0.7.0
mkdir -p ${prefix}/lib
make
if [ $target = "x86_64-w64-mingw32" ] || [ $target = "i686-w64-mingw32" ]
then
    cp libxxhash.so ${prefix}/lib/libxxhash.so
else
    cp libxxhash.${dlext} ${prefix}/lib/libxxhash.${dlext}
fi
"""
# if [[ "$(uname)" == 'Darwin' ]]
# then
#     cp libxxhash.dylib ${prefix}/lib/libxxhash.${dlext}
# else
#     cp libxxhash.so ${prefix}/lib/libxxhash.${dlext}
# fi

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms() # build on all supported platforms

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libxxhash", :libxxhash),
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "xxhash", v"0.7", sources, script, platforms, products, dependencies)

println("Contents of ", pwd(), " = ", readdir("."))
if isdir("products")
    println("PRODUCTS = ", readdir("products"))
else
    println("products/ directory not found")
end
