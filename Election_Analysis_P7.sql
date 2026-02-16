-- Election Analysis -- 


--➢ 1. Total Seats.

SELECT 
   DISTINCT COUNT(Parliament_Constituency) AS Total_seats
   FROM constituencywise_results;



--➢ 2. What are the total number of seats available for election in each state.


SELECT 
   s.state,
   COUNT(cr.Parliament_Constituency) AS Total_seats
FROM constituencywise_results AS cr
JOIN statewise_results AS sr
ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states as s
ON s.state_id = sr.state_id
GROUP BY 1


--➢ 3. Total Seats won by NDA Alliance.

SELECT 
    SUM(CASE 
            WHEN party IN (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
            ) THEN Won
            ELSE 0 
        END) AS NDA_Total_Seats_Won
FROM 
    partywise_result
                          -- OR 



SELECT 
    party as Party_Name,
    won as Seats_Won
FROM 
    partywise_result
WHERE 
    party IN (
        'Bharatiya Janata Party - BJP', 
        'Telugu Desam - TDP', 
		'Janata Dal  (United) - JD(U)',
        'Shiv Sena - SHS', 
        'AJSU Party - AJSUP', 
        'Apna Dal (Soneylal) - ADAL', 
        'Asom Gana Parishad - AGP',
        'Hindustani Awam Morcha (Secular) - HAMS', 
        'Janasena Party - JnP', 
		'Janata Dal  (Secular) - JD(S)',
        'Lok Janshakti Party(Ram Vilas) - LJPRV', 
        'Nationalist Congress Party - NCP',
        'Rashtriya Lok Dal - RLD', 
        'Sikkim Krantikari Morcha - SKM'
    )
ORDER BY Seats_Won DESC




-- ➢ 4. Seats Won by I.N.D.I.A Alliance


SELECT 
   SUM(CASE
           WHEN party IN(
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
				) THEN won
				ELSE 0
				END) AS INDIA_Total_Seats_Won

FROM partywise_result;


-- ➢ 5. Add new column field in the table partywise_results to get the part Alianz as NDA, I.N.D.I.A and OTHER.


ALTER TABLE partywise_result
ADD COLUMN party_alliance VARCHAR(50)


--I.N.D.I.A Allianz

UPDATE partywise_result
SET party_alliance = 'I.N.D.I.A'
WHERE party IN (
    'Indian National Congress - INC',
    'Aam Aadmi Party - AAAP',
    'All India Trinamool Congress - AITC',
    'Bharat Adivasi Party - BHRTADVSIP',
    'Communist Party of India  (Marxist) - CPI(M)',
    'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
    'Communist Party of India - CPI',
    'Dravida Munnetra Kazhagam - DMK',	
    'Indian Union Muslim League - IUML',
    'Jammu & Kashmir National Conference - JKN',
    'Jharkhand Mukti Morcha - JMM',
    'Kerala Congress - KEC',
    'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
    'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
    'Rashtriya Janata Dal - RJD',
    'Rashtriya Loktantrik Party - RLTP',
    'Revolutionary Socialist Party - RSP',
    'Samajwadi Party - SP',
    'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
    'Viduthalai Chiruthaigal Katchi - VCK'
);

--NDA Allianz

UPDATE partywise_result
SET party_alliance = 'NDA'
WHERE party IN (
    'Bharatiya Janata Party - BJP',
    'Telugu Desam - TDP',
    'Janata Dal  (United) - JD(U)',
    'Shiv Sena - SHS',
    'AJSU Party - AJSUP',
    'Apna Dal (Soneylal) - ADAL',
    'Asom Gana Parishad - AGP',
    'Hindustani Awam Morcha (Secular) - HAMS',
    'Janasena Party - JnP',
    'Janata Dal  (Secular) - JD(S)',
    'Lok Janshakti Party(Ram Vilas) - LJPRV',
    'Nationalist Congress Party - NCP',
    'Rashtriya Lok Dal - RLD',
    'Sikkim Krantikari Morcha - SKM'
);

--OTHER

UPDATE partywise_result
SET party_alliance = 'OTHER'
WHERE party_alliance IS NULL;



--➢ 6. Winning Candidate’s name, their party name, total votes, and the margin of victory for a specific state and constituency?


SELECT 
    cr.winning_candidate,
	pr.party,
	pr.party_alliance,
	cr.total_votes,
    cr.margin,
	s.state,
	cr.constituency_name
FROM constituencywise_results AS cr
JOIN partywise_result AS pr
ON cr.party_id = pr.party_id
JOIN statewise_results AS sr
ON sr.Parliament_Constituency = cr.Parliament_Constituency
JOIN states as s
ON s.state_id = sr.state_id
WHERE 
    cr.constituency_name = 'AHMEDNAGAR' ;



--➢ 7. What is the distribution of EVM votes versus postal votes forcandidates in a specific constituency?


SELECT 
   cd.evm_votes,
   cd.postal_votes,
   cd.total_votes,
   cd.candidate,
   cr.constituency_name
FROM constituencywise_results AS cr
JOIN constituencywise_details AS cd
ON cr.Constituency_ID = cd.Constituency_ID
WHERE 
   cr.constituency_name = 'BANKA'



--➢ 8. Which parties won the most seats in a State, and how many seats did each party win?


SELECT 
    pr.party,
	COUNT(cr.Constituency_ID) AS Total_seats
FROM constituencywise_results AS cr
JOIN partywise_result AS pr
ON pr.party_id = cr.party_id
JOIN statewise_results AS sr
ON sr.Parliament_Constituency = cr.Parliament_Constituency
JOIN states AS s
ON s.state_id = sr.state_id
WHERE 
    s.state = 'Bihar'
GROUP BY 1
ORDER BY 2 DESC



--➢ 9. What is total number of seats won by each alliance (NDA, I.N.D.I.A,and OTHER) in each state for 
-- the Indian election 2024



SELECT 
    s.State AS State_Name,
    SUM(CASE WHEN p.party_alliance = 'NDA' THEN 1 ELSE 0 END) AS NDA_Seats_Won,
    SUM(CASE WHEN p.party_alliance = 'I.N.D.I.A' THEN 1 ELSE 0 END) AS INDIA_Seats_Won,
	SUM(CASE WHEN p.party_alliance = 'OTHER' THEN 1 ELSE 0 END) AS OTHER_Seats_Won
FROM constituencywise_results AS cr
JOIN partywise_result p 
ON cr.Party_ID = p.Party_ID
JOIN statewise_results sr 
ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s 
ON sr.State_ID = s.State_ID
WHERE 
    p.party_alliance IN ('NDA', 'I.N.D.I.A',  'OTHER')  -- Filter for NDA and INDIA alliances
GROUP BY 
    s.State
ORDER BY 
    s.State;



--➢ 10. Which candidate received the highest number of EVM votes in each constituency (Top 10)?


SELECT 
    cr.Constituency_Name,
    cd.Constituency_ID,
    cd.Candidate,
    cd.EVM_Votes
FROM constituencywise_details cd
JOIN constituencywise_results cr 
ON cd.Constituency_ID = cr.Constituency_ID
WHERE 
    cd.EVM_Votes = (
        SELECT MAX(cd1.EVM_Votes)
        FROM constituencywise_details cd1
        WHERE cd1.Constituency_ID = cd.Constituency_ID
    )

ORDER BY 
    cd.EVM_Votes DESC;




/*
➢ 11.  For the state of Maharashtra, What are the total number of seats,
total number of candidates, total number of parties, total votes
(including EVM and postal), and the breakdown of EVM and postal
votes?
*/


SELECT 
    COUNT(DISTINCT cr.Constituency_ID) AS Total_Seats,
    COUNT(DISTINCT cd.Candidate) AS Total_Candidates,
    COUNT(DISTINCT p.Party) AS Total_Parties,
    SUM(cd.EVM_Votes + cd.Postal_Votes) AS Total_Votes,
    SUM(cd.EVM_Votes) AS Total_EVM_Votes,
    SUM(cd.Postal_Votes) AS Total_Postal_Votes
FROM constituencywise_results cr
JOIN constituencywise_details cd 
ON cr.Constituency_ID = cd.Constituency_ID
JOIN statewise_results sr 
ON cr.Parliament_Constituency = sr.Parliament_Constituency
JOIN states s 
ON sr.State_ID = s.State_ID
JOIN partywise_result p 
ON cr.Party_ID = p.Party_ID
WHERE 
    s.State = 'Maharashtra';







                                         -- END --




