%% Copyright © 2018 Pierre Fenoll ‹pierrefenoll@gmail.com›
%% See LICENSE for licensing information.
%% -*- coding: utf-8 -*-
-module(has_maps_tests).

-include_lib("eunit/include/eunit.hrl").
-include_lib("otp_vsn/include/otp_vsn.hrl").

-ifdef(OTP_VSN_HAS_MAPS).
has_maps() -> true.
-else.
has_maps() -> false.
-endif.

has_maps_test() ->
    ?assertEqual(has_maps(), {module,maps} =:= code:ensure_loaded(maps)).
