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

echo -e "================    \x1b[1;4mBugsRemaining\x1b[0;0m   ================"
echo -e "----------------        \x1b[1;1mneko\x1b[0;0m        ----------------"
cat out/neko/BugsRemaining
echo -e "----------------        \x1b[1;1mhxcpp\x1b[0;0m       ----------------"
cat out/cpp64/BugsRemaining

echo -e "================        \x1b[1;4mImpl\x1b[0;0m        ================"
echo -e "----------------        \x1b[1;1mneko\x1b[0;0m        ----------------"
cat out/neko/Impl
echo -e "----------------        \x1b[1;1mhxcpp\x1b[0;0m       ----------------"
cat out/cpp64/Impl
