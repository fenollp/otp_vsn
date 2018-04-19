REBAR3 ?= rebar3
RELEASES_TXT ?= releases.txt
KERL = ./kerl
GEN = ./gen
KERL_URL ?= https://raw.githubusercontent.com/kerl/kerl/master/kerl

.PHONY: gen clean
all: gen
	$(REBAR3) eunit

test:
	git clone https://github.com/fenollp/otp_vsn_testing.git
	cd otp_vsn_testing && $(REBAR3) do eunit,release

$(KERL):
	curl -#fSLo $@ $(KERL_URL)
	chmod +x $(KERL)

gen: SHELL = /bin/bash
gen: $(KERL)
	KERL_BUILD_BACKEND=git $(KERL) update releases >$(RELEASES_TXT)
	$(GEN) $(RELEASES_TXT)
	@git status --porcelain
	@[[ 0 -eq $$(git status --porcelain | wc -l) ]]

clean:
	$(if $(wildcard $(KERL)),rm $(KERL))
	$(if $(wildcard $(RELEASES_TXT)),rm $(RELEASES_TXT))
	$(if $(wildcard _build/),rm -r _build/)
