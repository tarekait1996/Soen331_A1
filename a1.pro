%% =============================================================================
%%
%%  CONCORDIA UNIVERSITY
%%  Department of Computer Science and Software Engineering
%%  SOEN 331-W:  Assingment 1
%%  Winter term, 2019
%%  Date submitted: February 11, 2019
%%
%%  Authors:
%%
%%  name1, id1, email1
%%  name2, id2, email2
%%  ...
%%
%% =============================================================================

%% =============================================================================
%%
%%  Facts
%%
%% =============================================================================

%% Top-level states
state(idle).
state('warming up').
state(configuration).
state(exit).

%% States under active state
state(input).
state(add).
state(override).

%%Initial states
initial_state(idle, null).
initial_state(configuration, input).

%%Superstates
superstates(configuration, 'warming up').
superstates(configuration, add).
superstates(configuration, override).

%%Transitions within the top-level STRUCTURE IS TRANSITION(STATE1, STATE2, EVENT, GUARD, ACTION).

transition(idle,idle,'every two minutes','current is greater or equal than desired temperature', null).
transition(idle, 'warming up','every two minutes', 'current is less or equal desired temperature minus 1', 'furnace on; fan off' ).
transition(idle, exit, 'shut off', null, null).

transition('warming up', 'warming up', 'every three minutes', 'furnace temperature less than desired temperatue plus 1', null).
transition('warming up', idle, null, 'furnace temperature greater or equal than desired temp plus 1', 'fan on; click sound produced').
transition('warming up', configuration, interrupt, null, 'furnace on').

transition(configuration, idle, cancel, null, 'prolonged beep sound').
transition(configuration, idle, null, null, null).

%%Transitions within active state
transition(input, add, null, 'tiplet does not exist in list', null).
transition(input, override, null, 'tiplet does exist in list', null).
transition(add, input, null, null, null).
transition(override, input, null, null, null).
transition(input, exitConfigure, 'after one minute of inactivity', null).
transition(add, exitConfigure, null, completed, null ).
transition(override, exitConfigure, null, completed, null).

%% =============================================================================
%%
%%  Rules
%%
%% =============================================================================

ancestor(A,B):- transition(A,B,_,_).
ancestor(A,B):- transition(A,X,_,_), ancestor(X,B,_,_).

get_all_transitions(L):- findall((A, B, C, D, E), (transition(A,B,C,D,E), \+ transition(A,B,C,null,D),\+ transition(A,B,C,D,null)), L).

%% eof.
