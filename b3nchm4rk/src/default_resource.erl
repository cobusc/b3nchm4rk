-module(default_resource).
 
-compile([export_all]).
 
-include_lib("webmachine/include/webmachine.hrl").
 
init(Config) ->
    %%fill the database with some test data
    %% prp_schema:init_tables(),
    %% prp_schema:fill_with_dummies(),
    %% {ok, Config}.

    %%enable tracing the decision core for debugging
    {{trace, "traces"}, Config}.
              
content_types_provided(ReqData, Context) ->
    {[ {"text/html", to_html}, 
       {"application/json", to_json}
     ], ReqData, Context}.

allowed_methods(ReqData, Context) ->
    {['GET', 'HEAD'], ReqData, Context}.
                    
to_html(ReqData, Context) ->
    Id = wrq:path_info(id, ReqData),
    Resp = "<html><body>" ++ Id ++ "</body></html>",
    {Resp, ReqData, Context}.

to_json(ReqData, Context) ->
     Id = wrq:path_info(id, ReqData),
     Resp = mochijson:encode({struct, [{"Id", Id}]}),
     {Resp, ReqData, Context}.
