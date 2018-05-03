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
       ]
       || X <- [a,b,c]
      ]).

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


% Get the stacktrace in a way that is backwards compatible
-ifdef(ERLANG_OTP_VERSION_21_FEATURES).
-define(STACKTRACE(ErrorType, Error, ErrorStackTrace),
        ErrorType:Error:ErrorStackTrace ->).
-else.
-define(STACKTRACE(ErrorType, Error, ErrorStackTrace),
        ErrorType:Error ->
            ErrorStackTrace = erlang:get_stacktrace(),).
-endif.
That allows use like:

try function1(Arg1)
catch
    ?STACKTRACE(exit, badarg, ErrorStackTrace)
        % do stuff with ErrorStackTrace
