GTF_SOURCE=src
SELFTEST_SOURCE=selftest
BASETEST_SOURCE=basetest
IMPL_SOURCE=impl

# GTF_SOURCE = src/gtf/Test.hx src/gtf/Runner.hx src/gtf/Result.hx src/gtf/AssertResult.hx src/gtf/TimingResult.hx
# SELFTEST_SOURCE = selftest/SelfTest.hx selftest/TestAssertions.hx selftest/TestTiming.hx
# BASETEST_SOURCE = basetest/BaseTest.hx basetest/TestFloat.hx basetest/TestDynamic.hx basetest/TestDS.hx basetest/BugsRemaining.hx basetest/Bugs.hx
# IMPL_SOURCE = impl/Impl.hx impl/ChooseVector.hx impl/ChooseDigraph.hx

#compile all
all: bin/neko/SelfTest.n bin/neko/BaseTest.n bin/neko/BugsRemaining.n bin/neko/Impl.n bin/cpp64/SelfTest/SelfTest bin/cpp64/BaseTest/BaseTest bin/cpp64/BugsRemaining/BugsRemaining bin/cpp64/Impl/Impl

#clean all
clean:
	rm -Rf bin
	rm -Rf bin
	rm -Rf out
	rm -Rf out

#make dirs
mkdirs:
	mkdir bin 2> /dev/null
	mkdir bin/neko 2> /dev/null
	mkdir bin/cpp64 2> /dev/null
	mkdir out 2> /dev/null
	mkdir out/neko 2> /dev/null
	mkdir out/cpp64 2> /dev/null

#run all
run: out/neko/SelfTest out/neko/BaseTest out/neko/BugsRemaining out/neko/Impl out/cpp64/SelfTest out/cpp64/BaseTest out/cpp64/BugsRemaining out/cpp64/Impl

#print all
print: run
	./printAll.sh


#neko builds
bin/neko/SelfTest.n: ${GTF_SOURCE} ${SELFTEST_SOURCE} selftest-neko.hxml
	haxe selftest-neko.hxml
bin/neko/BaseTest.n bin/neko/BugsRemaining.n: ${GTF_SOURCE} ${BASETEST_SOURCE} basetest-neko.hxml
	haxe basetest-neko.hxml
bin/neko/Impl.n: ${GTF_SOURCE} ${IMPL_SOURCE} impl-neko.hxml
	haxe impl-neko.hxml

#hxcpp builds
bin/cpp64/SelfTest/SelfTest: ${GTF_SOURCE} ${SELFTEST_SOURCE} selftest-cpp.hxml
	haxe selftest-cpp.hxml
bin/cpp64/BaseTest/BaseTest bin/cpp64/BugsRemaining/BugsRemaining: ${GTF_SOURCE} ${BASETEST_SOURCE} basetest-cpp.hxml
	haxe basetest-cpp.hxml
bin/cpp64/Impl/Impl: ${GTF_SOURCE} ${IMPL_SOURCE} impl-cpp.hxml
	haxe impl-cpp.hxml
	
#output
out/neko/SelfTest: bin/neko/SelfTest.n
	neko bin/neko/SelfTest.n > out/neko/SelfTest
out/neko/BaseTest: bin/neko/BaseTest.n
	neko bin/neko/BaseTest.n > out/neko/BaseTest
out/neko/BugsRemaining: bin/neko/BugsRemaining.n
	neko bin/neko/BugsRemaining.n > out/neko/BugsRemaining
out/neko/Impl: bin/neko/Impl.n
	neko bin/neko/Impl.n > out/neko/Impl
out/cpp64/SelfTest: bin/cpp64/SelfTest/SelfTest
	bin/cpp64/SelfTest/SelfTest > out/cpp64/SelfTest
out/cpp64/BaseTest: bin/cpp64/BaseTest/BaseTest
	bin/cpp64/BaseTest/BaseTest > out/cpp64/BaseTest
out/cpp64/BugsRemaining: bin/cpp64/BugsRemaining/BugsRemaining
	bin/cpp64/BugsRemaining/BugsRemaining > out/cpp64/BugsRemaining
out/cpp64/Impl: bin/cpp64/Impl/Impl
	bin/cpp64/Impl/Impl > out/cpp64/Impl

.PHONY: all clean mkdirs run print
