
-- FilmLocations(
--     Title:              titles of the films, 
--     ReleaseYear:        time of public release of the films, 
--     Locations:          locations of San Francisco where the films were shot, 
--     FunFacts:           funny facts about the filming locations, 
--     ProductionCompany:  companies who produced the films, 
--     Distributor:        companies who distributed the films, 
--     Director:           people who directed the films, 
--     Writer:             people who wrote the films, 
--     Actor1:             person 1 who acted in the films, 
--     Actor2:             person 2 who acted in the films, 
--     Actor3:             person 3 who acted in the films
-- )

-- Retrieve all records with all columns from the “FilmLocations” table.
SELECT * FROM FilmLocations;
-- Retrieve the names of all films with director names and writer names.
SELECT Title, Director, Writer FROM FilmLocations;
-- Retrieve the names of all films released in the 21st century and onwards (release years after 2001 including 2001), along with filming locations and release years.
SELECT Title, ReleaseYear, Locations FROM FilmLocations WHERE ReleaseYear>=2001;
-- Retrieve the fun facts and filming locations of all films.
SELECT Locations, FunFacts FROM FilmLocations;
-- Retrieve the names of all films released in the 20th century and before (release years before 2000 including 2000) that, along with filming locations and release years.
SELECT Title, ReleaseYear, Locations FROM FilmLocations WHERE ReleaseYear<=2000;
-- Retrieve the names, production company names, filming locations, and release years of the films which are not written by James Cameron.
SELECT Title,  ProductionCompany, Locations, ReleaseYear FROM FilmLocations WHERE Writer <> "James Cameron" ;