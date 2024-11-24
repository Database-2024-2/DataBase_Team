-- create_tables.sql
DROP DATABASE IF EXISTS soccerdb;
CREATE DATABASE soccerdb;
USE soccerdb;

-- 1. Stadium 테이블 생성
CREATE TABLE Stadium (
    StadiumID INT PRIMARY KEY,          -- 경기장 ID, 기본 키
    Name VARCHAR(100) NOT NULL,         -- 경기장 이름
    Capacity INT,                       -- 수용 인원
    Location VARCHAR(100)               -- 위치
);

-- 2. Team 테이블 생성
CREATE TABLE Team (
    TeamID INT PRIMARY KEY,             -- 팀 ID, 기본 키
    Name VARCHAR(100) NOT NULL,         -- 팀 이름
    Strength INT,                       -- 팀 전력
    WinRate FLOAT,                      -- 승률
    Strategy VARCHAR(100),              -- 전술
    Formation VARCHAR(100),             -- 포메이션
    AvgScore FLOAT,                     -- 평균 득점
    AvgConcede FLOAT                    -- 평균 실점
);

-- 3. Game 테이블 생성
CREATE TABLE Game (
    GameID INT PRIMARY KEY,             -- 경기 ID, 기본 키
    Date DATE NOT NULL,                 -- 경기 날짜
    StadiumID INT,                     -- 경기장 ID, 외래 키
    FOREIGN KEY (StadiumID) REFERENCES Stadium(StadiumID)
);

-- 4. Game_Participation 테이블 생성 (경기 참여 중간 테이블)
CREATE TABLE Game_Participation (
    GameID INT,                         -- 경기 ID, 외래 키
    TeamID INT,                         -- 팀 ID, 외래 키
    Role ENUM('Home', 'Away') NOT NULL, -- 팀 역할 (Home 또는 Away)
    PRIMARY KEY (GameID, TeamID),       -- 복합 기본 키
    FOREIGN KEY (GameID) REFERENCES Game(GameID),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

-- 5. Game_Result 테이블 생성
CREATE TABLE Game_Result (
    GameID INT,                         -- 경기 ID, 외래 키
    TeamID INT,                         -- 팀 ID, 외래 키
    Goals INT DEFAULT 0,                -- 득점 수
    Assists INT DEFAULT 0,              -- 어시스트 수
    Shots INT DEFAULT 0,                -- 슈팅 수
    Fouls INT DEFAULT 0,                -- 파울 수
    YellowCards INT DEFAULT 0,          -- 경고 카드 수
    RedCards INT DEFAULT 0,             -- 퇴장 카드 수
    PRIMARY KEY (GameID, TeamID),       -- 복합 기본 키
    FOREIGN KEY (GameID) REFERENCES Game(GameID),
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

-- 6. Player 테이블 생성
CREATE TABLE Player (
    PlayerID INT PRIMARY KEY,           -- 선수 ID, 기본 키
    Name VARCHAR(100) NOT NULL,         -- 선수 이름
    Weight FLOAT,                       -- 몸무게
    Height FLOAT,                       -- 키
    Age INT,                            -- 나이
    Position VARCHAR(50),               -- 포지션
    TeamID INT,                         -- 팀 ID, 외래 키
    FOREIGN KEY (TeamID) REFERENCES Team(TeamID)
);

-- 7. Player_Performance 테이블 생성 (선수 경기 성과)
CREATE TABLE Player_Performance (
    GameID INT,                         -- 경기 ID, 외래 키
    PlayerID INT,                       -- 선수 ID, 외래 키
    Goals INT DEFAULT 0,                -- 득점 수
    Assists INT DEFAULT 0,              -- 어시스트 수
    Shots INT DEFAULT 0,                -- 슈팅 수
    Fouls INT DEFAULT 0,                -- 파울 수
    YellowCards INT DEFAULT 0,          -- 경고 카드 수
    RedCards INT DEFAULT 0,             -- 퇴장 카드 수
    PRIMARY KEY (GameID, PlayerID),     -- 복합 기본 키
    FOREIGN KEY (GameID) REFERENCES Game(GameID),
    FOREIGN KEY (PlayerID) REFERENCES Player(PlayerID)
);