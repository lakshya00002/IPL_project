CREATE DATABASE IPL;
USE IPL;

CREATE TABLE League(
	League_id INT PRIMARY KEY AUTO_INCREMENT,
	League_name VARCHAR(65),
	No_of_seasons INT DEFAULT 0,
	Started_in DATE,
	Season_id INT,
	Sponsership_id INT,
	Team_id INT,
	FOREIGN KEY (Season_id) REFERENCES Season(Season_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Sponsership_id) REFERENCES Sponsership(Sponsership_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Team_id) REFERENCES Team(Team_id) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE Player(
	Player_id INT PRIMARY KEY AUTO_INCREMENT,
	First_name VARCHAR(50),
	Last_name VARCHAR(50),
	Date_of_birth DATE,
	Nationality VARCHAR(55),
	Role VARCHAR(60),
	Batting_style ENUM('Right_handed','Left_handed'),
	Bowling_style ENUM('Right_arm Fast','Left_arm Fast','Left_arm Spin','Right_arm Spin'),
	-- Base_price INT, -- base price will consider in auction detail
	Current_team_id INT,
	IPL_deput_year DATE,
	International_career_start DATE,
	Total_ipl_trophies_won INT,
	player_photo BLOB,
    Contract_id INT,
    Statistics_id INT,
    FOREIGN KEY (Current_team_id) REFERENCES Team(Team_id),
    FOREIGN KEY (Contract_id) REFERENCES Contract(Contract_id),
    FOREIGN KEY (Statistics_id) REFERENCES Statisttics(Statistics_id)
    
    
);

CREATE TABLE Team(
	Team_id INT PRIMARY KEY AUTO_INCREMENT,
	Team_name VARCHAR(65),
	Home_stadium INT,
	Owner_name VARCHAR(70),
	Player_id INT,
	Coach_id INT,
	Captain INT,
	Match_id INT,
	Team_foundation_year DATE,
	Total_titles_won INT DEFAULT 0,
	Team_logo BLOB,
	Team_dress_color VARCHAR(60),
	Team_website_link VARCHAR(255),
	Team_networth INT DEFAULT 0,
    Statistics_id INT,
	FOREIGN KEY (Home_stadium) REFERENCES Stadium(Home_stadium) ON UPDATE CASCADE,
    FOREIGN KEY (Statistics_id) REFERENCES Team_statistics(Team_statistics_id) ON UPDATE CASCADE,
	FOREIGN KEY (Player_id) REFERENCES Player(Player_id) ON UPDATE CASCADE,
	FOREIGN KEY (Coach_id) REFERENCES Coach(Coach_id) ON UPDATE CASCADE,
	FOREIGN KEY (Match_id) REFERENCES Matches(Matches_id) ON UPDATE CASCADE,
    FOREIGN KEY (Captain) REFERENCES Player(Player_id) ON UPDATE CASCADE
 
);


CREATE TABLE Coach(
	Coach_id INT PRIMARY KEY AUTO_INCREMENT,
	First_name VARCHAR(55),
	Last_name VARCHAR(55),
	Nationality VARCHAR(55),
	Coach_role ENUM('Head Coach','Batting Coach','Bowling Coach'),
	Years_of_experience INT DEFAULT 0,
    Statistics INT,
    Contract_id INT,
    FOREIGN KEY (Contract_id) REFERENCES Contract(Contract_id),
    FOREIGN KEY (Statistics) REFERENCES Statistics(Statistics_id)
    
); 


CREATE TABLE Stadium(
	Stadium_id INT PRIMARY KEY AUTO_INCREMENT,
	Stadium_name VARCHAR(100),
	Address INT,
	Capacity INT DEFAULT 0,
	Pitch_type TEXT,
	Average_first_innings_score INT DEFAULT 0,
	Total_matches_hosted INT DEFAULT 0,
    FOREIGN KEY (Address) REFERENCES Location(Location_id)

);

CREATE Table Contract (
	Contract_id INT PRIMARY KEY AUTO_INCREMENT,
    Contract_Start_Year DATE,
    Contract_End_Year DATE,
    Amount DECIMAL (10, 2),
    Contract_status ENUM('Active','Expired','Terminated'),
    Sign_date DATE,
    Termination_clause TEXT,
    Renewal_option ENUM('Yes','No'),
    Contract_details TEXT
    );
    
CREATE TABLE Location(
	Location_id INT PRIMARY KEY AUTO_INCREMENT,
    Country VARCHAR(60),
    State VARCHAR(60),
    City VARCHAR(60),
    PINCODE VARCHAR(10),
    Address_line VARCHAR(255),
    Latitude DECIMAL(10,8),
    Longitude DECIMAL(10,8),
    Region ENUM('Rural','Urban','Suburban')
);    


CREATE TABLE Umpire (
	Umpire_ID INT PRIMARY KEY NOT NULL,
    First_Name VARCHAR(20),
    Last_Name VARCHAR (20),
    Nationality VARCHAR (20),
    Total_Matches INT,
    Date_of_Birth DATE,
    Umpire_Rating INT CHECK (Umpire_Rating BETWEEN 0 AND 10),
    Contract INT,
    Umpire_role ENUM('On_field_umpire','Third_umpire','Match_referee'),
    Experience_level ENUM ('Internationl','Domestic','Local'),
    Deput_year DATE,
    Retirement_status ENUM('Retired','Active'),
    FOREIGN KEY (Contract_id) REFERENCES Contract(Contract_id)
    );

CREATE TABLE Sponsorship(
	Sponsorship_id INT PRIMARY KEY,
    Sponsor_name varchar(200),
    Sponsorship_type varchar(200),
    Contract_Start_year DATETIME,
    Contract_End_year DATETIME,
    Sponsorship_amount float,
    Payment_frequency ENUM ('Monthly','Quarterly','Annually'),
    Contract INT,
    Sponser_logo BLOB,
    FOREIGN KEY (Contract) REFERENCES Contract(Contract_id)
    
);

CREATE TABLE Matches (
	Match_id INT PRIMARY KEY AUTO_INCREMENT,
    Team1_id INT,
    Team2_id INT,
    Match_date DATETIME,
    Umpire1_id INT,
    Umpire2_id INT,
    Match_result varchar(200),
    Team1_score INT,
    Team2_score INT,
    Wickets_taken_team1 INT,
    Wickets_taken_team2 INT,
    Stadium INT,
    Winning_margin varchar(255),
    Total_Overs_bowled INT CHECK (Total_Overs_Bowled BETWEEN 0 AND 40) ,
    Match_Type ENUM('League', 'Qualifier', 'Eliminator', 'Final'),
    Match_status ENUM('Upcoming','Ongoing','Abandoned','Completed'),
    Scorecard_id INT,
	FOREIGN KEY (Stadium_id) REFERENCES Stadium (Stadium_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Team1_id) REFERENCES Team (Team_id) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Team2_id) REFERENCES Team (Team_id) ON DELETE CASCADE ON UPDATE CASCADE,
	FOREIGN KEY (Umpire1_id) REFERENCES Umpire (Umpire_id) ON UPDATE CASCADE,
	FOREIGN KEY (Umpire2_id) REFERENCES Umpire (Umpire_id) ON UPDATE CASCADE,
    FOREIGN KEY (Scorecard_id) REFERENCES Scorecard(Scorecard_id) ON UPDATE CASCADE
        
);

CREATE TABLE Match_info(
	Schedule_id INT PRIMARY KEY AUTO_INCREMENT,
	Toss_winner VARCHAR(100),
	Toss_decision ENUM('Bat','Bowl'),
	Date_time DATETIME,
	Team1 INT,
	Team2 INT,
	Team1_squad JSON,
	Team1_support_staff JSON,
	Team1_bench JSON,
	Team2_squad JSON,
	Team2_support_staff JSON,
	Team2_bench JSON,
	Match_status ENUM('Completed','Delayed','Abandoned','Scheduled'),
	Venue INT,
	FOREIGN KEY (Team1) REFERENCES Team(Team_id),
	FOREIGN KEY (Team1) REFERENCES Team(Team_id),
	FOREIGN KEY (Venue) REFERENCES Stadium(Stadium_id)
);

CREATE TABLE Statistics(
	Stat_id INT PRIMARY KEY AUTO_INCREMENT,
	Matches_played INT DEFAULT 0,
	Runs_scored INT DEFAULT 0,
	Wickets_taken INT DEFAULT 0,
	Catches_taken INT DEFAULT 0,
	Fours INT DEFAULT 0,
	Sixes INT DEFAULT 0,
	Strike_rate DECIMAL(5,2)DEFAULT 0,
	Economy_rate DECIMAL(5,2)DEFAULT 0,
	Bowling_average DECIMAL(5,2)DEFAULT 0,
	Batting_average DECIMAL(5,2)DEFAULT 0,
	High_score INT DEFAULT 0
);


CREATE TABLE Season (
	Season_ID INT PRIMARY KEY NOT NULL,
    Year DATE,
    Total_Matches_Played INT,
    Winning_Team_ID INT,
    Runner_Team_ID INT,
    Orange_Cap_Winnner_ID INT,
    Purple_Cap_Winner_ID INT,
    Highest_Scorer_ID INT,
	Best_Bowler_ID INT,
    Total_Revenue DECIMAL(15,2) DEFAULT 0,
    Total_Teams INT,
    Start_Date DATE,
	End_Date DATE,
    Team_id INT,
	FOREIGN KEY (Highest_Scorer_ID) REFERENCES PLAYER (Player_ID),
	FOREIGN KEY (Best_Bowler_ID) REFERENCES PLAYER (Player_ID),
    FOREIGN KEY (Team_id) REFERENCES Team(Team_id),
    FOREIGN KEY (Winning_Team_ID) REFERENCES Team (Team_ID),
    FOREIGN KEY (Orange_Cap_Winnner_ID) REFERENCES PLAYER (Player_ID),
    FOREIGN KEY (Purple_Cap_Winner_ID) REFERENCES PLAYER (Player_ID),
    FOREIGN KEY (Runner_Team_ID) REFERENCES Team (Team_ID)
    );
    
CREATE TABLE Scorecard (

    Scorecard_id INT PRIMARY KEY AUTO_INCREMENT,
    Player_ID INT,
    Runs_Scored INT DEFAULT 0,
    Balls_Faced INT DEFAULT 0,
    Fours INT DEFAULT 0,
    Sixes INT DEFAULT 0,
    Catches INT DEFAULT 0,
    Run_Outs INT DEFAULT 0,
    Wickets_Taken INT DEFAULT 0,
    Overs_Bowled DECIMAL(3,1) DEFAULT 0,
    Bowling_Average DECIMAL(5,2) DEFAULT 0,
    Economy_Rate DECIMAL(5,2) DEFAULT 0,
    FOREIGN KEY (Player_ID) REFERENCES Player(Player_ID) ON DELETE CASCADE
);

CREATE TABLE Team_statistics (
    Team_statistics_id INT PRIMARY KEY AUTO_INCREMENT,
    Matches_Played INT DEFAULT 0,
    Wins INT DEFAULT 0,
    Losses INT DEFAULT 0,
    No_Result INT DEFAULT 0,
    Total_Runs_Scored INT DEFAULT 0,
    Total_Wickets INT DEFAULT 0
);



























-- league();
--  , player, team, coach, stadium, contract, location, umpire, season ,sponsership , statistics , matches , ball ,scorecard , matchinfo ,team_statistics

-- league has season ,
-- league has sponsership,
-- league has teams, 
-- team has coach, 
-- team has players,
-- team has home_stadium,
-- team has matches,
-- team has team_stat ******************,
-- player has statistics ***********,
-- player has contract,
-- player faced ball,
-- player bowled ball,
-- coach has contract,
-- coach has statistics**********,
-- stadium has location,
-- sponsership has contract,
-- umpire has statistics ,
-- umpire has contract,
-- season has statistics,
-- season has matches,
-- Season has winning team,
-- season has runner up team
-- season has player(purple cap winner, orange cap winner, highest scorer , best bowler)
-- season has sponsership,
-- matches has teams ,
-- matches has umpires,
-- matches has scorecard ,
-- matches has match_info,
