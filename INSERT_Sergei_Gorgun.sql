DECLARE
    new_film_id INTEGER;
BEGIN
    INSERT INTO film (title, description, release_year, language_id, length, rating, special_features, fulltext)
    VALUES (
        UPPER('The Matrix'),
        'A computer hacker learns about the true nature of his reality and his role in the war against its controllers.',
        1999,
        1,
        136,
        'R',
        '{"Trailers","Commentaries","Behind the Scenes"}',
        'The Matrix A computer hacker learns about the true nature of his reality and his role in the war against its controllers.'
    )
    RETURNING film_id INTO new_film_id;

    WITH new_actors AS (
        INSERT INTO actor (first_name, last_name)
        VALUES 
            (UPPER('Keanu'), UPPER('Reeves')),
            (UPPER('Laurence'), UPPER('Fishburne')),
            (UPPER('Carrie-Anne'), UPPER('Moss'))
        RETURNING actor_id
    )
    INSERT INTO film_actor (actor_id, film_id)
    SELECT actor_id, new_film_id
    FROM new_actors;

    INSERT INTO inventory (film_id, store_id)
    VALUES (new_film_id, 1);

    RAISE NOTICE 'Added film with ID: %', new_film_id;
END $$;


--The code below is to check if the rows were added to the database correctly.

-- SELECT * FROM public.film
-- ORDER BY film_id DESC LIMIT 10;

-- SELECT * FROM public.actor
-- ORDER BY actor_id DESC LIMIT 10;

-- SELECT * FROM public.film_actor
-- ORDER BY actor_id DESC, film_id DESC LIMIT 10;

-- SELECT * FROM public.inventory
-- ORDER BY inventory_id DESC LIMIT 10;

