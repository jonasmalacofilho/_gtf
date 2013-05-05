GTF_SOURCE=src
SELFTEST_SOURCE=selftest
BASETEST_SOURCE=basetest
IMPL_SOURCE=impltest

#compile all
all: cSelfTest cBaseTest cBugsRemaining cImplTest

#run all
run: SelfTest BaseTest BugsRemaining ImplTest

#clean all
clean:
	rm -Rf bin
	rm -Rf out

#compilation
cSelfTest: mkdirs bin/neko/SelfTest.n bin/cpp64/SelfTest/SelfTest
cBaseTest: mkdirs bin/neko/BaseTest.n bin/cpp64/BaseTest/BaseTest
cBugsRemaining: mkdirs bin/neko/BugsRemaining.n bin/cpp64/BugsRemaining/BugsRemaining
cImplTest: mkdirs bin/neko/ImplTest.n bin/cpp64/ImplTest/ImplTest
#neko builds
bin/neko/SelfTest.n: ${GTF_SOURCE} ${SELFTEST_SOURCE}
	haxe -cp ${GTF_SOURCE} -cp ${SELFTEST_SOURCE} -main SelfTest -neko bin/neko/SelfTest.n
bin/neko/BaseTest.n: ${GTF_SOURCE} ${BASETEST_SOURCE}
	haxe -cp ${GTF_SOURCE} -cp ${BASETEST_SOURCE} -main BaseTest -neko bin/neko/BaseTest.n
bin/neko/BugsRemaining.n: ${GTF_SOURCE} ${BASETEST_SOURCE}
	haxe -cp ${GTF_SOURCE} -cp ${BASETEST_SOURCE} -main BugsRemaining -neko bin/neko/BugsRemaining.n
bin/neko/ImplTest.n: ${GTF_SOURCE} ${IMPL_SOURCE}
	haxe -cp ${GTF_SOURCE} -cp ${IMPL_SOURCE} -main ImplTest -neko bin/neko/ImplTest.n
#hxcpp M64 builds
bin/cpp64/SelfTest/SelfTest: ${GTF_SOURCE} ${SELFTEST_SOURCE}
	haxe -cp ${GTF_SOURCE} -cp ${SELFTEST_SOURCE} -main SelfTest -cpp bin/cpp64/SelfTest -D HXCPP_M64
bin/cpp64/BaseTest/BaseTest: ${GTF_SOURCE} ${BASETEST_SOURCE}
	haxe -cp ${GTF_SOURCE} -cp ${BASETEST_SOURCE} -main BaseTest -cpp bin/cpp64/BaseTest -D HXCPP_M64
bin/cpp64/BugsRemaining/BugsRemaining: ${GTF_SOURCE} ${BASETEST_SOURCE}
	haxe -cp ${GTF_SOURCE} -cp ${BASETEST_SOURCE} -main BugsRemaining -cpp bin/cpp64/BugsRemaining -D HXCPP_M64
bin/cpp64/ImplTest/ImplTest: ${GTF_SOURCE} ${IMPL_SOURCE}
	haxe -cp ${GTF_SOURCE} -cp ${IMPL_SOURCE} -main ImplTest -cpp bin/cpp64/ImplTest -D HXCPP_M64
	
#running
SelfTest: cSelfTest out/neko/SelfTest out/cpp64/SelfTest
BaseTest: cBaseTest out/neko/BaseTest out/cpp64/BaseTest
BugsRemaining: cBugsRemaining out/neko/BugsRemaining out/cpp64/BugsRemaining
ImplTest: cImplTest out/neko/ImplTest out/cpp64/ImplTest
#neko
out/neko/SelfTest: bin/neko/SelfTest.n
	neko bin/neko/SelfTest.n > out/neko/SelfTest
out/neko/BaseTest: bin/neko/BaseTest.n
	neko bin/neko/BaseTest.n > out/neko/BaseTest
out/neko/BugsRemaining: bin/neko/BugsRemaining.n
	neko bin/neko/BugsRemaining.n > out/neko/BugsRemaining
out/neko/ImplTest: bin/neko/ImplTest.n
	neko bin/neko/ImplTest.n > out/neko/ImplTest
#hxcpp M64
out/cpp64/SelfTest: bin/cpp64/SelfTest/SelfTest
	bin/cpp64/SelfTest/SelfTest > out/cpp64/SelfTest
out/cpp64/BaseTest: bin/cpp64/BaseTest/BaseTest
	bin/cpp64/BaseTest/BaseTest > out/cpp64/BaseTest
out/cpp64/BugsRemaining: bin/cpp64/BugsRemaining/BugsRemaining
	bin/cpp64/BugsRemaining/BugsRemaining > out/cpp64/BugsRemaining
out/cpp64/ImplTest: bin/cpp64/ImplTest/ImplTest
	bin/cpp64/ImplTest/ImplTest > out/cpp64/ImplTest

#make dirs
mkdirs:
	mkdir -p bin/neko
	mkdir -p bin/cpp64
	mkdir -p out/neko
	mkdir -p out/cpp64

.PHONY: all run clean cSelfTest cBaseTest cBugsRemaining cImplTest SelfTest BaseTest BugsRemaining ImplTest mkdirs
