-module(test_resource).
 
-compile([export_all]).
 
-include_lib("webmachine/include/webmachine.hrl").
 
init(Config) ->
%    {ok, Config}.
    %%enable tracing the decision core for debugging
    {{trace, "/tmp"}, Config}.
              
content_types_provided(RD, Ctx) ->
    {[ {"application/json", to_json} ], RD, Ctx}.

allowed_methods(RD, Ctx) ->
    {['GET'], RD, Ctx}.
                    
to_html(RD, Ctx) ->
    Id = wrq:path_info(id, RD),
    Resp = "<html><body>" ++ Id ++ "</body></html>",
    {Resp, RD, Ctx}.

to_json(RD, Ctx) ->
    Id = wrq:path_info(id, RD),
    Foo = wrq:get_qs_value("extra", "unknown", RD),
    Resp = mochijson2:encode({struct, [{name, list_to_binary(Id)},
                                       {extra, list_to_binary(Foo)}]}),
    {Resp, RD, Ctx}.
