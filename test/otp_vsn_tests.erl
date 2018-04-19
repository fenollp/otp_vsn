%% Copyright © 2018 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(otp_vsn_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("otp_vsn/include/otp_vsn.hrl").

do_test_() ->
    [?_assertMatch([_|_], ?OTP_VSN)

    ,?_assert(is_integer(?OTP_VSN_MAJOR) andalso ?OTP_VSN_MAJOR >  0)
    ,?_assert(is_integer(?OTP_VSN_MINOR) andalso ?OTP_VSN_MINOR >= 0)
    ,?_assert(is_integer(?OTP_VSN_PATCH) andalso ?OTP_VSN_PATCH >= 0)

    ,?_assertMatch([_|_], ?OTP_VSN_MAJOR_STRING)
    ,?_assertMatch([_|_], ?OTP_VSN_MINOR_STRING)
    ,?_assertMatch([_|_], ?OTP_VSN_PATCH_STRING)

    ] ++ %% More tests if running inside CI
        lists:flatten(
          [[?_assertMatch([_|_], OTP_VSN)
           ,?_assertEqual(OTP_VSN, ?OTP_VSN)
           ,?_assertNotEqual(nomatch, re:run(<<?OTP_VSN>>, <<"^[0-9]+\\.[0-9]+\\.[0-9]+$">>))

           ,?_assertMatch([_|_], OTP_VSN_M)
           ,?_assertMatch([_|_], OTP_VSN_m)
           ,?_assertMatch([_|_], OTP_VSN_P)
           ,?_assertEqual(list_to_integer(OTP_VSN_M), ?OTP_VSN_MAJOR)
           ,?_assertEqual(list_to_integer(OTP_VSN_m), ?OTP_VSN_MINOR)
           ,?_assertEqual(list_to_integer(OTP_VSN_P), ?OTP_VSN_PATCH)

           ,?_assertEqual(OTP_VSN_M, ?OTP_VSN_MAJOR_STRING)
           ,?_assertEqual(OTP_VSN_m, ?OTP_VSN_MINOR_STRING)
           ,?_assertEqual(OTP_VSN_P, ?OTP_VSN_PATCH_STRING)
           ]
           || os:getenv("CI") =:= "true",
              {OTP_VSN
              ,OTP_VSN_M
              ,OTP_VSN_m
              ,OTP_VSN_P
              } <- [{os:getenv("_OTP_VSN")
                    ,os:getenv("_OTP_VSN_M")
                    ,os:getenv("_OTP_VSN_m")
                    ,os:getenv("_OTP_VSN_P")
                    }]
          ]).
