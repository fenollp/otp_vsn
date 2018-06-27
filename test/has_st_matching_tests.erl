%% Copyright © 2018 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(has_st_matching_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("otp_vsn/include/otp_vsn.hrl").

do_test_() ->
    lists:flatten(
      [[?_assertEqual(X, try_compact(X))
       ,?_assertEqual(X, try_not_DRY(X))
       ,?_assertEqual(X, really_DRY(X))
       ]
       || X <- [a,b,c]
      ]).

really_DRY(X) ->
    try explode(X)
    catch
        ?OTP_VSN_STACKTRACE(error, _, ST)
            begin f(ST), X end;
        ?OTP_VSN_STACKTRACE(throw, only_matching, ST) f(X,ST);
        ?OTP_VSN_STACKTRACE(throw, b, ST) f(X,ST);
        ?OTP_VSN_STACKTRACE(_, _, ST)
            f(X, ST)
    end.

try_compact(X) ->
    try explode(X)
    catch
        ?OTP_VSN_IF_HAS_ST_MATCHING(
           error:_:ST -> begin f(ST), X end;
          ,error:_ -> begin f(erlang:get_stacktrace()), X end;
          )
        ?OTP_VSN_IF_HAS_ST_MATCHING(throw:only_matching:ST -> f(X,ST);)
        ?OTP_VSN_IF_HAS_ST_MATCHING(throw:b:ST -> f(X,ST);, throw:b -> f(X,erlang:get_stacktrace());)
        ?OTP_VSN_IF_HAS_ST_MATCHING(_:_:ST -> f(X, ST),
                                    _:_    -> f(X, erlang:get_stacktrace()))
    end.

-ifdef(OTP_VSN_HAS_ST_MATCHING).
try_not_DRY(X) ->
    try explode(X)
    catch
        error:_:ST -> begin f(ST), X end;
        throw:only_matching:ST -> f(X,ST);
        throw:b:ST -> f(X,ST);
        _:_:ST -> f(X, ST)
    end.
-else.
try_not_DRY(X) ->
    try explode(X)
    catch
        error:_ -> begin f(erlang:get_stacktrace()), X end;
        throw:b -> f(X,erlang:get_stacktrace());
        _:_    -> f(X, erlang:get_stacktrace())
    end.
-endif.

explode(a) -> error(a);
explode(b) -> throw(b);
explode(c) -> throw(c).

f(X, ST) ->
    f(ST),
    X.

f([_|_]) -> ok.
