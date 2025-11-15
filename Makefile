# /*─────────────────────────────────────────────────────────────────╗
# │ To the extent possible under law, Jared Miller has waived        │
# │ all copyright and related or neighboring rights to this file,    │
# │ as it is written in the following disclaimers:                   │
# │   • http://unlicense.org/                                        │
# ╚─────────────────────────────────────────────────────────────────*/
.PHONY: all clean test

# Change redbean to whatever you want
PROJECT=redbean
REDBEAN=${PROJECT}.com
REDBEAN_VERSION=3.0.0
REDBEAN_DL=https://redbean.dev/redbean-${REDBEAN_VERSION}.com

ZIP=zip.com
ZIP_DL=https://redbean.dev/zip.com
UNZIP=unzip.com
UNZIP_DL=https://redbean.dev/unzip.com

NPD=--no-print-directory

all: add

${REDBEAN}.template:
	curl -Rs ${REDBEAN_DL} -o $@ && \
		chmod +x ${@}

${REDBEAN}: ${REDBEAN}.template
	cp ${REDBEAN}.template ${REDBEAN}

eff_large_wordlist.txt:
	curl -Lo - https://www.eff.org/files/2016/07/18/eff_large_wordlist.txt > eff_large_wordlist.txt

srv/.lua/words.lua: eff_large_wordlist.txt
	python3 genset.py > srv/.lua/words.lua

${ZIP}: srv/.lua/words.lua
	curl -Rso ${ZIP} ${ZIP_DL}
	chmod +x ${ZIP}

add: ${ZIP} ${REDBEAN}
	cp -f ${REDBEAN}.template ${REDBEAN}
	cd srv/ && ../${ZIP} -r ../${REDBEAN} `ls -A`

unzip.com: ; curl -Rs ${ZIP_DL} -o $@
ls: unzip.com
	@unzip -vl ./${REDBEAN} | grep -v \
		'usr/\|.symtab'

log: ${PROJECT}.log
	tail -f ${PROJECT}.log

start: ${REDBEAN}
	./${REDBEAN} -vv

start-daemon: ${REDBEAN}
	@(test ! -f ${PROJECT}.pid && \
		./${REDBEAN} -vv -d -L ${PROJECT}.log -P ${PROJECT}.pid && \
		printf "started $$(cat ${PROJECT}.pid)\n") \
		|| echo "already running $$(cat ${PROJECT}.pid)"

restart-daemon:
	@(test ! -f ${PROJECT}.pid && \
		./${REDBEAN} -vv -d -L ${PROJECT}.log -P ${PROJECT}.pid && \
		printf "started $$(cat ${PROJECT}.pid)") \
		|| kill -HUP $$(cat ${PROJECT}.pid) && \
		printf "restarted $$(cat ${PROJECT}.pid)\n"

stop-daemon: ${PROJECT}.pid
	@kill -TERM $$(cat ${PROJECT}.pid) && \
		printf "stopped $$(cat ${PROJECT}.pid)\n" && \
		rm ${PROJECT}.pid \

clean:
	rm -f ${PROJECT}.log ${PROJECT}.pid ${REDBEAN} ${REDBEAN}.template ${ZIP} ${UNZIP}
