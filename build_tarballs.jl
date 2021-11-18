using BinaryBuilder

# Collection of sources required to build Xsum
sources = [
    "https://github.com/v1j4y/div_by_2/releases/download/v5.0/div_by_2-5.0.tar.gz" =>
    "68c13113d738611d48e998d2f966809b132d61095b0305d5b7d2497c99a3e2e4",
]

# Bash recipe for building across all platforms
script = raw"""
cd $WORKSPACE/srcdir/div_by_2-5.0
./autogen.sh
./configure --prefix=${prefix}
make
make install
"""

# These are the platforms we will build for by default, unless further
# platforms are passed in on the command line
platforms = supported_platforms() # build on all supported platforms

# The products that we will ensure are always built
products(prefix) = [
    LibraryProduct(prefix, "libdivby2", :libdivby2),
]

# Dependencies that must be installed before this package can be built
dependencies = [
]

# Build the tarballs, and possibly a `build.jl` as well.
build_tarballs(ARGS, "div_by_2", v"5.0", sources, script, platforms, products, dependencies)

println("Contents of ", pwd(), " = ", readdir("."))
if isdir("products")
    println("PRODUCTS = ", readdir("products"))
else
    println("products/ directory not found")
end
