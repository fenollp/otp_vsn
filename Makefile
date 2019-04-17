REBAR3 ?= rebar3
RELEASES_TXT ?= releases.txt
KERL = ./kerl
GEN = ./gen
KERL_URL ?= https://raw.githubusercontent.com/kerl/kerl/master/kerl
TESTING = otp_vsn_testing

.PHONY: gen clean fmt test
all: gen
	$(REBAR3) eunit

test:
	$(if $(wildcard $(TESTING)),,git clone --depth=1 https://github.com/fenollp/otp_vsn_testing.git $(TESTING))
	cd otp_vsn_testing && $(REBAR3) do eunit,release

$(KERL):
	curl -#fSLo $@ $(KERL_URL) && chmod +x $@

gen: $(KERL)
	KERL_BUILD_BACKEND=git $(KERL) update releases >$(RELEASES_TXT)
	$(GEN) $(RELEASES_TXT)
	@git status --porcelain
	@[ '0' = "$$(git status --porcelain | grep -F include/otp_vsn.hrl | wc -l)" ]

clean:
	$(if $(wildcard $(KERL)),rm $(KERL))
	$(if $(wildcard $(RELEASES_TXT)),rm $(RELEASES_TXT))
	$(if $(wildcard _build/),rm -r _build/)

FMT = _build/erlang-formatter-master/fmt.sh
$(FMT):
	mkdir -p _build/
	curl -f#SL 'https://codeload.github.com/fenollp/erlang-formatter/tar.gz/master' | tar xvz -C _build/
fmt: TO_FMT ?= .
fmt: $(FMT)
	$(if $(TO_FMT), $(FMT) $(TO_FMT))
