KERL = ./kerl
REBAR3 ?= rebar3
RELEASES_TXT ?= releases.txt

all: SHELL = /bin/bash
all: kerl
	KERL_BUILD_BACKEND=git $(KERL) update releases >$(RELEASES_TXT)
	rm $(KERL)
	./gen $(RELEASES_TXT)
	rm $(RELEASES_TXT)
	@git status --porcelain
	[[ 0 -eq $(git status --porcelain | wc -l) ]]

test:
	$(REBAR3) eunit
	git clone https://github.com/fenollp/otp_vsn_testing.git
	cd otp_vsn_testing && $(REBAR3) do eunit,release
