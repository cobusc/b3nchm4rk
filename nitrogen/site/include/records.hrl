##-record(google_chart_new, {?ELEMENT_BASE(element_google_chart_new), 
##                           chartType :: string(),
##                           containerId :: string(),
##                           options :: #google_chart_options{},
##                           dataTable :: #google_chart_data{},
##                           view
##                          }).
##
##-record(google_chart_data, {?ELEMENT_BASE(element_google_chart_data), 
##                            cols :: list(#google_chart_column{}), 
##                            rows :: list(#google_chart_row{}), 
##                            p
##                           }).
##
##-record(google_chart_column, {?ELEMENT_BASE(element_google_chart_column), 
##                              type :: 'boolean', 'number', 'string', 'date', 'datetime', 'timeofday',
##                              id :: string(), 
##                              label :: string(), 
##                              p
##                             }).
##
##-record(google_chart_row, {?ELEMENT_BASE(element_google_chart_row), 
##                           cells :: list(google_chart_cell), 
##                           p
##                          }).
##
##-record(google_chart_cell, {?ELEMENT_BASE(element_google_chart_cell), 
##                            value, 
##                            formattedValue :: string(), 
##                            p
##                           }).
##
##-record(google_chart_options, {?ELEMENT_BASE(element_google_chart_options),
##                               width,
##                               height,
##                               is3D :: boolean(),
##                               title :: string()
##                              }). 
##
##
