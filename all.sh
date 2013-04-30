echo -e "===================================================="
echo -e "================    \x1b[1;4mCOMPILATION\x1b[0;0m     ================"
echo -e "===================================================="
set -o verbose

haxe all.hxml

set +o verbose
echo -e "===================================================="
echo -e "================     \x1b[1;4mEXECUTION\x1b[0;0m      ================"
echo -e "===================================================="
set -o verbose

neko bin/neko/SelfTest.n > out/neko/SelfTest
neko bin/neko/BaseTest.n > out/neko/BaseTest
neko bin/neko/BugsRemaining.n > out/neko/BugsRemaining
neko bin/neko/Impl.n > out/neko/Impl

bin/cpp64/SelfTest/SelfTest > out/cpp64/SelfTest
bin/cpp64/BaseTest/BaseTest > out/cpp64/BaseTest
bin/cpp64/BugsRemaining/BugsRemaining > out/cpp64/BugsRemaining
bin/cpp64/Impl/Impl > out/cpp64/Impl

set +o verbose
echo -e "===================================================="
echo -e "================      \x1b[1;4mOUTPUTS\x1b[0;0m       ================"
echo -e "===================================================="

echo -e "================      \x1b[1;4mSelfTest\x1b[0;0m      ================"
echo -e "----------------        \x1b[1;1mneko\x1b[0;0m        ----------------"
cat out/neko/SelfTest
echo -e "----------------        \x1b[1;1mhxcpp\x1b[0;0m       ----------------"
cat out/cpp64/SelfTest

echo -e "================      \x1b[1;4mBaseTest\x1b[0;0m      ================"
echo -e "----------------        \x1b[1;1mneko\x1b[0;0m        ----------------"
cat out/neko/BaseTest
echo -e "----------------        \x1b[1;1mhxcpp\x1b[0;0m       ----------------"
cat out/cpp64/BaseTest

echo -e "================    \x1b[1;4mBugsRemaining\x1b[0;0m    ================"
echo -e "----------------        \x1b[1;1mneko\x1b[0;0m        ----------------"
cat out/neko/BugsRemaining
echo -e "----------------        \x1b[1;1mhxcpp\x1b[0;0m       ----------------"
cat out/cpp64/BugsRemaining

echo -e "================        \x1b[1;4mImpl\x1b[0;0m        ================"
echo -e "----------------        \x1b[1;1mneko\x1b[0;0m        ----------------"
cat out/neko/Impl
echo -e "----------------        \x1b[1;1mhxcpp\x1b[0;0m       ----------------"
cat out/cpp64/Impl

