-module(add).
-export([add/2]).
-nifs([add/2]).
-on_load(init/0).

init() ->
    ok = erlang:load_nif("./priv/add_nif", 0).

add(_X, _Y) ->
    erlang:nif_error(nif_library_not_loaded).
