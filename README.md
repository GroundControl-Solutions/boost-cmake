# boost-cmake
Mirror of the CMake build scripts we use for boost internally

# Usage
This directory of CMake scripts is intended to be placed *alongside* a boost clone directory. We include the scripts by using add_subdirectory(boost-cmake) in our root CMakeList file.

# Note
To make including boost easier from XCode, the boost repo structure has been altered by the script in the conversion directory.
