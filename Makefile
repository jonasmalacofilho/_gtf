GTF_SOURCE=src
SELFTEST_SOURCE=selftest
BASETEST_SOURCE=basetest
IMPL_SOURCE=impltest

SELFTEST_SOURCE_DEP=$(shell find ${GTF_SOURCE} ${SELFTEST_SOURCE} -name *.hx)
BASETEST_SOURCE_DEP=$(shell find ${GTF_SOURCE} ${BASETEST_SOURCE} -name *.hx)
IMPL_SOURCE_DEP=$(shell find ${GTF_SOURCE} ${IMPL_SOURCE} -name *.hx)

HX_FLAGS+=
HXNEKO_FLAGS+=
HXCPP_FLAGS+=
HXJAVA_FLAGS+=

#compile all
all: cSelfTest cBaseTest cBugsRemaining cImplTest

#run all
run: SelfTest BaseTest BugsRemaining ImplTest

#clean
cleanBin:
	rm -Rf bin
cleanOut:
	rm -Rf out
cleanNeko:
	rm -Rf bin/neko
	rm -Rf out/neko
cleanCpp:
	rm -Rf bin/cpp
	rm -Rf out/cpp
cleanJava:
	rm -Rf bin/java
	rm -Rf out/java
clean: cleanBin cleanOut

#compilation
cSelfTest: bin/neko/SelfTest.n bin/cpp/SelfTest/SelfTest bin/java/SelfTest/SelfTest.jar
cBaseTest: bin/neko/BaseTest.n bin/cpp/BaseTest/BaseTest bin/java/BaseTest/BaseTest.jar
cBugsRemaining: bin/neko/BugsRemaining.n bin/cpp/BugsRemaining/BugsRemaining bin/java/BugsRemaining/BugsRemaining.jar
cImplTest: bin/neko/ImplTest.n bin/cpp/ImplTest/ImplTest bin/java/ImplTest/ImplTest.jar
#neko builds
cNeko: bin/neko/SelfTest.n bin/neko/BaseTest.n bin/neko/BugsRemaining.n bin/neko/ImplTest.n
bin/neko/SelfTest.n: ${SELFTEST_SOURCE_DEP}
	mkdir -p bin/neko && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${SELFTEST_SOURCE} -main SelfTest -neko bin/neko/SelfTest.n ${HXNEKO_FLAGS}
bin/neko/BaseTest.n: ${BASETEST_SOURCE_DEP}
	mkdir -p bin/neko && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${BASETEST_SOURCE} -main BaseTest -neko bin/neko/BaseTest.n ${HXNEKO_FLAGS}
bin/neko/BugsRemaining.n: ${BASETEST_SOURCE_DEP}
	mkdir -p bin/neko && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${BASETEST_SOURCE} -main BugsRemaining -neko bin/neko/BugsRemaining.n ${HXNEKO_FLAGS}
bin/neko/ImplTest.n: ${IMPL_SOURCE_DEP}
	mkdir -p bin/neko && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${IMPL_SOURCE} -main ImplTest -neko bin/neko/ImplTest.n ${HXNEKO_FLAGS}
#hxcpp builds
cCpp: bin/cpp/SelfTest/SelfTest bin/cpp/BaseTest/BaseTest bin/cpp/BugsRemaining/BugsRemaining bin/cpp/ImplTest/ImplTest
bin/cpp/SelfTest/SelfTest: ${SELFTEST_SOURCE_DEP}
	mkdir -p bin/cpp && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${SELFTEST_SOURCE} -main SelfTest -cpp bin/cpp/SelfTest ${HXCPP_FLAGS}
bin/cpp/BaseTest/BaseTest: ${BASETEST_SOURCE_DEP}
	mkdir -p bin/cpp && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${BASETEST_SOURCE} -main BaseTest -cpp bin/cpp/BaseTest ${HXCPP_FLAGS}
bin/cpp/BugsRemaining/BugsRemaining: ${BASETEST_SOURCE_DEP}
	mkdir -p bin/cpp && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${BASETEST_SOURCE} -main BugsRemaining -cpp bin/cpp/BugsRemaining ${HXCPP_FLAGS}
bin/cpp/ImplTest/ImplTest: ${IMPL_SOURCE_DEP}
	mkdir -p bin/cpp && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${IMPL_SOURCE} -main ImplTest -cpp bin/cpp/ImplTest ${HXCPP_FLAGS}
#java builds
cJava: bin/java/SelfTest/SelfTest.jar bin/java/BaseTest/BaseTest.jar bin/java/BugsRemaining/BugsRemaining.jar bin/java/ImplTest/ImplTest.jar
bin/java/SelfTest/SelfTest.jar: ${SELFTEST_SOURCE_DEP}
	mkdir -p bin/java && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${SELFTEST_SOURCE} -main SelfTest -java bin/java/SelfTest ${HXJAVA_FLAGS}
bin/java/BaseTest/BaseTest.jar: ${BASETEST_SOURCE_DEP}
	mkdir -p bin/java && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${BASETEST_SOURCE} -main BaseTest -java bin/java/BaseTest ${HXJAVA_FLAGS}
bin/java/BugsRemaining/BugsRemaining.jar: ${BASETEST_SOURCE_DEP}
	mkdir -p bin/java && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${BASETEST_SOURCE} -main BugsRemaining -java bin/java/BugsRemaining ${HXJAVA_FLAGS}
bin/java/ImplTest/ImplTest.jar: ${IMPL_SOURCE_DEP}
	mkdir -p bin/java && haxe ${HX_FLAGS} -cp ${GTF_SOURCE} -cp ${IMPL_SOURCE} -main ImplTest -java bin/java/ImplTest ${HXJAVA_FLAGS}
	
#running
SelfTest: cSelfTest out/neko/SelfTest out/cpp/SelfTest out/java/SelfTest
BaseTest: cBaseTest out/neko/BaseTest out/cpp/BaseTest out/java/BaseTest
BugsRemaining: cBugsRemaining out/neko/BugsRemaining out/cpp/BugsRemaining out/java/BugsRemaining
ImplTest: cImplTest out/neko/ImplTest out/cpp/ImplTest out/java/ImplTest
#neko
neko: cNeko out/neko/SelfTest out/neko/BaseTest out/neko/BugsRemaining out/neko/ImplTest
out/neko/SelfTest: bin/neko/SelfTest.n
	mkdir -p out/neko && neko bin/neko/SelfTest.n > out/neko/SelfTest
out/neko/BaseTest: bin/neko/BaseTest.n
	mkdir -p out/neko && neko bin/neko/BaseTest.n > out/neko/BaseTest
out/neko/BugsRemaining: bin/neko/BugsRemaining.n
	mkdir -p out/neko && neko bin/neko/BugsRemaining.n > out/neko/BugsRemaining
out/neko/ImplTest: bin/neko/ImplTest.n
	mkdir -p out/neko && neko bin/neko/ImplTest.n > out/neko/ImplTest
#hxcpp
cpp: cNeko out/cpp/SelfTest out/cpp/BaseTest out/cpp/BugsRemaining out/cpp/ImplTest
out/cpp/SelfTest: bin/cpp/SelfTest/SelfTest
	mkdir -p out/cpp && bin/cpp/SelfTest/SelfTest > out/cpp/SelfTest
out/cpp/BaseTest: bin/cpp/BaseTest/BaseTest
	mkdir -p out/cpp && bin/cpp/BaseTest/BaseTest > out/cpp/BaseTest
out/cpp/BugsRemaining: bin/cpp/BugsRemaining/BugsRemaining
	mkdir -p out/cpp && bin/cpp/BugsRemaining/BugsRemaining > out/cpp/BugsRemaining
out/cpp/ImplTest: bin/cpp/ImplTest/ImplTest
	mkdir -p out/cpp && bin/cpp/ImplTest/ImplTest > out/cpp/ImplTest
#java
java: cJava out/java/SelfTest out/java/BaseTest out/java/BugsRemaining out/java/ImplTest
out/java/SelfTest: bin/java/SelfTest/SelfTest.jar
	mkdir -p out/java && java -jar bin/java/SelfTest/SelfTest.jar > out/java/SelfTest
out/java/BaseTest: bin/java/BaseTest/BaseTest.jar
	mkdir -p out/java && java -jar bin/java/BaseTest/BaseTest.jar > out/java/BaseTest
out/java/BugsRemaining: bin/java/BugsRemaining/BugsRemaining.jar
	mkdir -p out/java && java -jar bin/java/BugsRemaining/BugsRemaining.jar > out/java/BugsRemaining
out/java/ImplTest: bin/java/ImplTest/ImplTest.jar
	mkdir -p out/java && java -jar bin/java/ImplTest/ImplTest.jar > out/java/ImplTest

.PHONY: all run cleanBin cleanOut cleanNeko cleanCpp cleanJava clean cSelfTest cBaseTest cBugsRemaining cImplTest SelfTest BaseTest BugsRemaining ImplTest cNeko cCpp cJava neko cpp java