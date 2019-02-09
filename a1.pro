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
transition(pseudoState, idle, null, null).
transition(idle,idle,twoMinutes,currentGreaterOrEqualDesiredTemp).
transition(idle, warmUp,twoMinutes,currentLessOrEqualDesiredTemp).
%%transition(idle, configuration).
transition(idle, exit, shutOff, null).

transition(warmUp, warmUp, threeMinutes, furnaceTempLessDesiredTemp+1).
transition(warmUp, idle, null, furnaceTempGreaterEqualDesiredTemp+1).
transition(warmUp, configuration, interrupt, null).


transition(configuration, idle, cancel, null).
transition(configuration, idle, null, null).

transition(pseudoStateConfigure, input, null, null).
transition(input, add, null, null, tripletNotExist).
transition(input, override, null, tripletExist).
transition(add, input, null, null).
transition(override, input, null, null).
transition(input, exitConfigure, afterMinuteInactive, null).
transition(add, exitConfigure, null, completed ).
transition(override, exitConfigure, null, completed).




%% =============================================================================
%%
%%  Rules
%%
%% =============================================================================

ancestor(A,B):= transition(A,B,_,_).
ancestor(A,B):= transition(A,X,_,_), ancestor(X,B,_,_).

get_all_transitions(X):= \+ transition(A,B,?,?), [].

%% eof.
