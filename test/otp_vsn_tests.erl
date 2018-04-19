%% Copyright © 2018 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(otp_vsn_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("otp_vsn/include/otp_vsn.hrl").

do_test_() ->
    [?_assertEqual("20.3.0", ?OTP_VSN)

    ,?_assert(is_integer(?OTP_VSN_MAJOR) andalso ?OTP_VSN_MAJOR > 0)
    ,?_assert(is_integer(?OTP_VSN_MINOR) andalso ?OTP_VSN_MINOR >= 0)
    ,?_assert(is_integer(?OTP_VSN_PATCH) andalso ?OTP_VSN_PATCH >= 0)

    ,?_assertMatch([_|_], ?OTP_VSN_MAJOR_STRING)
    ,?_assertMatch([_|_], ?OTP_VSN_MINOR_STRING)
    ,?_assertMatch([_|_], ?OTP_VSN_PATCH_STRING)
    ].
