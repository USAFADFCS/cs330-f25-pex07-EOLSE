% pex5.pl
% USAFA UFO Sightings 2024
%
% name: C1C Eric Olsen
%
% Documentation: I used https://stackoverflow.com/questions/13506569/prolog-or-operator-query for understanding how the OR operator worked in Prolog(line 70) and HW7. C1C Zamrin confirmed my method
%for switching to output sorted by day instead of Cadet
%
% 'It's a UFO", PEX 7
% tie -> UFO
ufo(weather_balloon).
ufo(kite).
ufo(fighter_aircraft).
ufo(cloud).
%mr -> cadet
cadet(smith).
cadet(garcia).
cadet(chen).
cadet(jones).
%relative ->day
day(tuesday).
day(wednesday).
day(thursday).
day(friday).

%C4C Smith did not see a weather balloon, nor kite. - IMPLEMENTED
% The one who saw the kite isn’t C4C Garcia. - IMPLEMENTED
% Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.-IMPLEMENTED
% The kite was not sighted on Tuesday. - IMPLEMENTED
% Neither C4C Garcia nor C4C Jones saw the weather balloon.-IMPLEMENTED
% C4C Jones did not make their sighting on Tuesday.-IMPLEMENTED
% C4C Smith saw an object that turned out to be a cloud.-IMPLEMENTED
% The fighter aircraft was spotted on Friday.-IMPLEMENTED
% The weather balloon was not spotted on Wednesday.-IMPLEMENTED
solve :-
    ufo(SmithUFO), ufo(GarciaUFO), ufo(ChenUFO), ufo(JonesUFO),
    all_different([SmithUFO, GarciaUFO, ChenUFO, JonesUFO]),
    
    day(SmithDay), day(GarciaDay),
    day(ChenDay), day(JonesDay),
    all_different([SmithDay, GarciaDay, ChenDay, JonesDay]),
    
    cadet(SmithPerson), cadet(GarciaPerson),
    cadet(ChenPerson), cadet(JonesPerson),
    all_different([SmithPerson, GarciaPerson, ChenPerson, JonesPerson]),
    
    Triples = [ [tuesday,SmithUFO, SmithPerson],
                [wednesday, GarciaUFO, GarciaPerson],
                [thursday, ChenUFO, ChenPerson],
                [friday, JonesUFO, JonesPerson] ],
    
    % 1. The tie with the grinning leprechauns wasn't a present from a daughter.
    % The kite was not sighted on Tuesday.
    \+ member([tuesday, kite, _], Triples),
    
    % 2. Mr. Crow's tie features neither the dancing reindeer not the yellow fappy faces.
    %C4C Smith did not see a weather balloon, nor kite.
    \+ member([_, weather_balloon, smith], Triples),
    \+ member([_, kite, smith], Triples),
    
    % 3. Mr. Speighler's tie wasn't a present from his uncle.
    % C4C Jones did not make their sighting on Tuesday.
    \+ member([tuesday, _, jones], Triples),
    
    % The one who saw the kite isn’t C4C Garcia.
    \+ member([_, kite, garcia], Triples),
    
    % 4. The tie with the yellow happy faces wasn't a gift from a sister.
    % The weather balloon was not spotted on Wednesday.
    \+ member([wednesday, weather_balloon, _], Triples),
    
    % 5. Mr. Evans and Mr. Speigler own the tie with the grinning leprechauns
    % and the tie that was a present from a father-in-law, in some order.
    % Friday’s sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    ( (member([friday, fighter_aircraft, _], Triples);
     	member([friday, _, chen], Triples))),
       %(member([chen, _, friday], Triples),
       %	member([_, fighter_aircraft, friday], Triples))  ),
    
    % C4C Smith saw an object that turned out to be a cloud
    member([_, cloud, smith], Triples),
    
    % Neither C4C Garcia nor C4C Jones saw the weather balloon.
    \+ member([_, weather_balloon, garcia], Triples),
    \+ member([_, weather_balloon, jones], Triples),
    
    % The fighter aircraft was spotted on Friday.
    member([friday, fighter_aircraft, _], Triples),
    
    tell(tuesday, SmithUFO, SmithPerson),
    tell(wednesday, GarciaUFO, GarciaPerson),
    tell(thursday, ChenUFO, ChenPerson),
    tell(friday, JonesUFO, JonesPerson).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

tell(X, Y, Z) :-
    write('C4C '), write(Z), write(' saw the '), write(Y),
    write(' on '), write(X), write('.'), nl.

