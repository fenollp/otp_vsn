%% Copyright © 2018 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(otp_vsn_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("otp_vsn/include/otp_vsn.hrl").

do_test_() ->
    [?_assertEqual("20.3.0", ?OTP_VSN)
    ].
