%% Copyright © 2018 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(has_st_matching_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("otp_vsn/include/otp_vsn.hrl").

do_test_() ->
    [?_assertEqual(a, do_try(a))
    ,?_assertEqual(b, do_try(b))
    ,?_assertEqual(c, do_try(c))
    ].

do_try(X) ->
    try explode(X)
    catch
        ?OTP_VSN_HAS_ST_MATCHING(
           error:_:ST -> begin f(ST), X end;
          ,error:_ -> begin f(erlang:get_stacktrace()), X end;
          )
        ?OTP_VSN_HAS_ST_MATCHING(throw:only_matching:ST -> f(X,ST);)
        ?OTP_VSN_HAS_ST_MATCHING(throw:b:ST -> f(X,ST);, throw:b -> f(X,erlang:get_stacktrace());)
        ?OTP_VSN_HAS_ST_MATCHING(_:_:ST -> f(X, ST),
                                 _:_    -> f(X, erlang:get_stacktrace()))
    end.

explode(a) -> error(a);
explode(b) -> throw(b);
explode(c) -> throw(c).

f(X, ST) ->
    f(ST),
    X.

f([_|_]) -> ok.
