-- Election Analysis -- 

--Creating Table

DROP TABLE IF EXISTS constituencywise_details;
CREATE TABLE constituencywise_details
      ( S_N INT,
	   Candidate VARCHAR(75),	
	   Party VARCHAR(70),
	   EVM_Votes BIGINT,
	   Postal_Votes	INT,
	   Total_Votes	INT,
	   Percent_of_Votes	FLOAT,
	   Constituency_ID VARCHAR(20) 
);



DROP TABLE IF EXISTS constituencywise_results;
CREATE TABLE constituencywise_results
        (S_No INT,
		 Parliament_Constituency VARCHAR(100),	
		 Constituency_Name	VARCHAR(100),
		 Winning_Candidate	VARCHAR(100),
		 Total_Votes INT,
		 Margin	INT,
		 Constituency_ID VARCHAR(20) PRIMARY KEY,	
		 Party_ID INT
);




DROP TABLE IF EXISTS partywise_result;
CREATE TABLE partywise_result
        (Party VARCHAR(150),
		 Won INT,
		 Party_ID INT PRIMARY KEY
);





DROP TABLE IF EXISTS states;
CREATE TABLE states
         (State_ID	VARCHAR(10) PRIMARY KEY,
		  State VARCHAR (100)
);




DROP TABLE IF EXISTS statewise_results;
CREATE TABLE statewise_results
         (Constituency VARCHAR(100),
		  Const_No INT,
		  Parliament_Constituency VARCHAR(100) PRIMARY KEY,
		  Leading_Candidate	VARCHAR(160),
		  Trailing_Candidate VARCHAR(150),
		  Margin BIGINT,
		  Status VARCHAR(20),
		  State_ID	VARCHAR(10),
		  State VARCHAR(50)
);



ALTER TABLE constituencywise_details
ADD CONSTRAINT fk_Constituency_ID
FOREIGN KEY (Constituency_ID)
REFERENCES constituencywise_results(Constituency_ID);



ALTER TABLE constituencywise_results
ADD CONSTRAINT fk_Parliament_Constituency
FOREIGN KEY (Parliament_Constituency)
REFERENCES statewise_results(Parliament_Constituency);


ALTER TABLE constituencywise_results
ADD CONSTRAINT fk_Party_ID
FOREIGN KEY(Party_ID)
REFERENCES partywise_result(Party_ID);


ALTER TABLE statewise_results
ADD CONSTRAINT fk_State_ID
FOREIGN KEY (State_ID)
REFERENCES states(State_ID);




SELECT * FROM statewise_results

SELECT * FROM constituencywise_results

SELECT * FROM constituencywise_details

SELECT * FROM states

SELECT * FROM partywise_result	












