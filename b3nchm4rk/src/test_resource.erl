-module(test_resource).
 
-compile([export_all]).
 
-include_lib("webmachine/include/webmachine.hrl").
 
init(Config) ->
%    {ok, Config}.
    %%enable tracing the decision core for debugging
    {{trace, "/tmp"}, Config}.
              
content_types_provided(RD, Ctx) ->
    {[ {"text/html", to_html} ], RD, Ctx}.

allowed_methods(RD, Ctx) ->
    {['GET', 'HEAD'], RD, Ctx}.
                    
to_html(RD, Ctx) ->
    Id = wrq:path_info(id, RD),
    Resp = "<html><body>" ++ Id ++ "</body></html>",
    {Resp, RD, Ctx}.
