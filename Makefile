GTF_SOURCE=src
SELFTEST_SOURCE=selftest
BASETEST_SOURCE=basetest
IMPL_SOURCE=impltest

RESOURCE_DIR=res

SELFTEST_SOURCE_DEP=$(shell find ${GTF_SOURCE} ${SELFTEST_SOURCE} -name *.hx -type f) $(shell find ${RESOURCE_DIR}/ -type f)
BASETEST_SOURCE_DEP=$(shell find ${GTF_SOURCE} ${BASETEST_SOURCE} -name *.hx -type f) $(shell find ${RESOURCE_DIR}/ -type f)
IMPL_SOURCE_DEP=$(shell find ${GTF_SOURCE} ${IMPL_SOURCE} -name *.hx -type f) $(shell find ${RESOURCE_DIR}/ -type f)

HX_FLAGS+=-resource res/HTMLReport.template.html@report
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
SelfTest: cSelfTest out/neko/SelfTest.html out/cpp/SelfTest.html out/java/SelfTest.html
BaseTest: cBaseTest out/neko/BaseTest.html out/cpp/BaseTest.html out/java/BaseTest.html
BugsRemaining: cBugsRemaining out/neko/BugsRemaining.html out/cpp/BugsRemaining.html out/java/BugsRemaining.html
ImplTest: cImplTest out/neko/ImplTest.html out/cpp/ImplTest.html out/java/ImplTest.html
#neko
neko: cNeko out/neko/SelfTest.html out/neko/BaseTest.html out/neko/BugsRemaining.html out/neko/ImplTest.html
out/neko/SelfTest.html: bin/neko/SelfTest.n
	mkdir -p out/neko && neko bin/neko/SelfTest.n > out/neko/SelfTest.html
out/neko/BaseTest.html: bin/neko/BaseTest.n
	mkdir -p out/neko && neko bin/neko/BaseTest.n > out/neko/BaseTest.html
out/neko/BugsRemaining.html: bin/neko/BugsRemaining.n
	mkdir -p out/neko && neko bin/neko/BugsRemaining.n > out/neko/BugsRemaining.html
out/neko/ImplTest.html: bin/neko/ImplTest.n
	mkdir -p out/neko && neko bin/neko/ImplTest.n > out/neko/ImplTest.html
#hxcpp
cpp: cNeko out/cpp/SelfTest.html out/cpp/BaseTest.html out/cpp/BugsRemaining.html out/cpp/ImplTest.html
out/cpp/SelfTest.html: bin/cpp/SelfTest/SelfTest
	mkdir -p out/cpp && bin/cpp/SelfTest/SelfTest > out/cpp/SelfTest.html
out/cpp/BaseTest.html: bin/cpp/BaseTest/BaseTest
	mkdir -p out/cpp && bin/cpp/BaseTest/BaseTest > out/cpp/BaseTest.html
out/cpp/BugsRemaining.html: bin/cpp/BugsRemaining/BugsRemaining
	mkdir -p out/cpp && bin/cpp/BugsRemaining/BugsRemaining > out/cpp/BugsRemaining.html
out/cpp/ImplTest.html: bin/cpp/ImplTest/ImplTest
	mkdir -p out/cpp && bin/cpp/ImplTest/ImplTest > out/cpp/ImplTest.html
#java
java: cJava out/java/SelfTest.html out/java/BaseTest.html out/java/BugsRemaining.html out/java/ImplTest.html
out/java/SelfTest.html: bin/java/SelfTest/SelfTest.jar
	mkdir -p out/java && java -jar bin/java/SelfTest/SelfTest.jar > out/java/SelfTest.html
out/java/BaseTest.html: bin/java/BaseTest/BaseTest.jar
	mkdir -p out/java && java -jar bin/java/BaseTest/BaseTest.jar > out/java/BaseTest.html
out/java/BugsRemaining.html: bin/java/BugsRemaining/BugsRemaining.jar
	mkdir -p out/java && java -jar bin/java/BugsRemaining/BugsRemaining.jar > out/java/BugsRemaining.html
out/java/ImplTest.html: bin/java/ImplTest/ImplTest.jar
	mkdir -p out/java && java -jar bin/java/ImplTest/ImplTest.jar > out/java/ImplTest.html

.PHONY: all run cleanBin cleanOut cleanNeko cleanCpp cleanJava clean cSelfTest cBaseTest cBugsRemaining cImplTest SelfTest BaseTest BugsRemaining ImplTest cNeko cCpp cJava neko cpp java