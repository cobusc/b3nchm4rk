%% -*- mode: nitrogen -*-
-module (user_logout).
-compile(export_all).
-include_lib("nitrogen_core/include/wf.hrl").
-include("records.hrl").

main() -> #template { file="./site/templates/bare.html" }.

title() -> "Hello from user_logout.erl!".

body() ->
    case wf:user() of
        undefined ->
            [
                #p{},
                "You are not logged in."
            ];
        _ ->
            wf:clear_session(),
            [
                #p{},
                "You have been logged out."
            ]
    end.
