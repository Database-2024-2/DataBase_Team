DROP DATABASE soccerdb;
CREATE DATABASE soccerdb;
use soccerdb;
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
    LocationID INT,                     -- 경기장 ID, 외래 키
    FOREIGN KEY (LocationID) REFERENCES Stadium(StadiumID)
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

INSERT INTO Stadium (StadiumID, Name, Capacity, Location)
VALUES
    (1, '춘천', 20000, '강원'),
    (2, '광주', 10007, '광주'),
    (3, '대구전', 15000, '대구'),
    (4, '대전w', 50535, '대전'),
    (5, '서울w', 66704, '서울'),
    (6, '수원w', 42542, '수원'),
    (7, '수원', 11808, '수원'), -- Location을 '수원'으로 변경
    (8, '문수', 43554, '울산'),
    (9, '인천', 25000, '인천'),
    (10, '전주w', 36781, '전북'),
    (11, '제주w', 25000, '제주'),
    (12, '포항', 20000, '포항');

INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (1, '2023-02-25', 8),  -- 문수
    (2, '2023-02-25', 5),  -- 서울w
    (3, '2023-02-25', 6),  -- 수원w
    (4, '2023-02-26', 12), -- 포항
    (5, '2023-02-26', 11), -- 제주w
    (6, '2023-02-26', 4),  -- 대전w
    (7, '2023-03-04', 9),  -- 인천
    (8, '2023-03-04', 7),  -- 수원
    (9, '2023-03-04', 3),  -- 대구전
    (10, '2023-03-05', 10), -- 전주w
    (11, '2023-03-05', 1),  -- 춘천
    (12, '2023-03-05', 2),  -- 광주
    (13, '2023-03-11', 7),  -- 수원
    (14, '2023-03-11', 4),  -- 대전w 
    (15, '2023-03-11', 1),  -- 춘천
    (16, '2023-03-12', 5),  -- 서울w
    (17, '2023-03-12', 10), -- 전주w
    (18, '2023-03-12', 9),  -- 인천
    (19, '2023-03-18', 12), -- 포항
    (20, '2023-03-18', 2),  -- 광주
    (21, '2023-03-18', 11), -- 제주w
    (22, '2023-03-19', 3),  -- 대구전
    (23, '2023-03-19', 6),  -- 수원w
    (24, '2023-03-19', 8),  -- 문수
    (25, '2023-04-01', 10), -- 전주w
    (26, '2023-04-01', 9),  -- 인천
    (27, '2023-04-01', 2),  -- 광주
    (28, '2023-04-01', 4),  -- 대전w
    (29, '2023-04-02', 11), -- 제주w
    (30, '2023-04-02', 7);  -- 수원
    INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (31, '2023-04-08', 8),  -- 문수
    (32, '2023-04-08', 5),  -- 서울w
    (33, '2023-04-08', 12), -- 포항
    (34, '2023-04-09', 10), -- 전주w
    (35, '2023-04-09', 1),  -- 춘천
    (36, '2023-04-09', 7),  -- 수원
    (37, '2023-04-15', 6),  -- 수원w
    (38, '2023-04-15', 12), -- 포항
    (39, '2023-04-15', 7),  -- 수원
    (40, '2023-04-16', 1),  -- 춘천
    (41, '2023-04-16', 4),  -- 대전w
    (42, '2023-04-16', 3),  -- 대구전
    (43, '2023-04-22', 5),  -- 서울w
    (44, '2023-04-22', 8),  -- 문수
    (45, '2023-04-22', 3),  -- 대구전
    (46, '2023-04-22', 9),  -- 인천
    (47, '2023-04-23', 2),  -- 광주
    (48, '2023-04-23', 11), -- 제주w
    (49, '2023-04-25', 12), -- 포항
    (50, '2023-04-25', 9),  -- 인천
    (51, '2023-04-26', 1),  -- 춘천
    (52, '2023-04-26', 2),  -- 광주
    (53, '2023-04-26', 10), -- 전주w
    (54, '2023-04-26', 7),  -- 수원
    (55, '2023-04-29', 7),  -- 수원
    (56, '2023-04-29', 10), -- 전주w
    (57, '2023-04-30', 4),  -- 대전w
    (58, '2023-04-30', 12), -- 포항
    (59, '2023-04-30', 6),  -- 수원w (수정됨)
    (60, '2023-04-30', 8);  -- 문수 (수정됨)
    INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (61, '2023-05-05', 3),  -- 대구전
    (62, '2023-05-05', 5),  -- 서울W
    (63, '2023-05-05', 9),  -- 인천
    (64, '2023-05-06', 11), -- 제주W
    (65, '2023-05-06', 7),  -- 수원
    (66, '2023-05-06', 2),  -- 광주
    (67, '2023-05-09', 8),  -- 문수
    (68, '2023-05-09', 3),  -- 대구전
    (69, '2023-05-09', 5),  -- 서울W
    (70, '2023-05-10', 11), -- 제주W
    (71, '2023-05-10', 6),  -- 수원W
    (72, '2023-05-10', 4),  -- 대전W
    (73, '2023-05-13', 12), -- 포항
    (74, '2023-05-13', 2),  -- 광주
    (75, '2023-05-13', 1),  -- 춘천
    (76, '2023-05-14', 8),  -- 문수
    (77, '2023-05-14', 9),  -- 인천
    (78, '2023-05-14', 7),  -- 수원
    (79, '2023-05-20', 9),  -- 인천
    (80, '2023-05-20', 5),  -- 서울W
    (81, '2023-05-20', 4),  -- 대전W
    (82, '2023-05-21', 1),  -- 춘천
    (83, '2023-05-21', 6),  -- 수원W
    (84, '2023-05-21', 10), -- 전주W
    (85, '2023-05-27', 11), -- 제주W
    (86, '2023-05-27', 3),  -- 대구전
    (87, '2023-05-28', 5),  -- 서울W
    (88, '2023-05-28', 7),  -- 수원
    (89, '2023-05-28', 8),  -- 문수
    (90, '2023-05-29', 12); -- 포항
    INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (91, '2023-06-03', 10), -- 전주W
    (92, '2023-06-03', 6),  -- 수원W
    (93, '2023-06-03', 11), -- 제주W
    (94, '2023-06-03', 2),  -- 광주
    (95, '2023-06-04', 4),  -- 대전W
    (96, '2023-06-04', 3),  -- 대구전
    (97, '2023-06-06', 7),  -- 수원
    (98, '2023-06-06', 12), -- 포항
    (99, '2023-06-07', 10), -- 전주W
    (100, '2023-06-07', 2), -- 광주
    (101, '2023-06-07', 9), -- 인천
    (102, '2023-06-07', 1), -- 춘천
    (103, '2023-06-10', 3), -- 대구전
    (104, '2023-06-10', 8), -- 문수
    (105, '2023-06-10', 4), -- 대전W
    (106, '2023-06-11', 1), -- 춘천
    (107, '2023-06-11', 5), -- 서울W
    (108, '2023-06-11', 6), -- 수원W
    (109, '2023-06-24', 6), -- 수원W
    (110, '2023-06-24', 11), -- 제주W
    (111, '2023-06-24', 2), -- 광주
    (112, '2023-06-24', 8), -- 문수
    (113, '2023-06-25', 9), -- 인천
    (114, '2023-06-25', 7), -- 수원
    (115, '2023-07-01', 10), -- 전주W
    (116, '2023-07-01', 3),  -- 대구전
    (117, '2023-07-01', 5),  -- 서울W
    (118, '2023-07-02', 2),  -- 광주
    (119, '2023-07-02', 12), -- 포항
    (120, '2023-07-02', 9);  -- 인천
INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (121, '2023-07-07', 11), -- 제주W
    (122, '2023-07-07', 1),  -- 춘천
    (123, '2023-07-08', 12), -- 포항
    (124, '2023-07-08', 7),  -- 수원
    (125, '2023-07-08', 10), -- 전주W
    (126, '2023-07-09', 4),  -- 대전W
    (127, '2023-07-11', 3),  -- 대구전
    (128, '2023-07-11', 11), -- 제주W
    (129, '2023-07-12', 8),  -- 문수
    (130, '2023-07-12', 6),  -- 수원W
    (131, '2023-07-12', 4),  -- 대전W
    (132, '2023-07-12', 5),  -- 서울W
    (133, '2023-07-15', 6),  -- 수원W
    (134, '2023-07-15', 1),  -- 춘천
    (135, '2023-07-15', 2),  -- 광주
    (136, '2023-07-16', 10), -- 전주W
    (137, '2023-07-16', 12), -- 포항
    (138, '2023-07-16', 9),  -- 인천
    (139, '2023-07-21', 8),  -- 문수
    (140, '2023-07-21', 12), -- 포항
    (141, '2023-07-22', 7),  -- 수원
    (142, '2023-07-22', 1),  -- 춘천
    (143, '2023-07-22', 5),  -- 서울W
    (144, '2023-07-22', 4),  -- 대전W
    (145, '2023-08-04', 5),  -- 서울W
    (146, '2023-08-04', 2),  -- 광주
    (147, '2023-08-05', 6),  -- 수원W
    (148, '2023-08-05', 3),  -- 대구전
    (149, '2023-08-06', 10), -- 전주W
    (150, '2023-08-06', 11); -- 제주W
INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (151, '2023-08-12', 10), -- 전주W
    (152, '2023-08-12', 1),  -- 춘천
    (153, '2023-08-12', 11), -- 제주W
    (154, '2023-08-13', 4),  -- 대전W
    (155, '2023-08-13', 9),  -- 인천
    (156, '2023-08-13', 12), -- 포항
    (157, '2023-08-18', 6),  -- 수원W
    (158, '2023-08-18', 9),  -- 인천
    (159, '2023-08-19', 8),  -- 문수
    (160, '2023-08-19', 1),  -- 춘천
    (161, '2023-08-19', 5),  -- 서울W
    (162, '2023-08-20', 12), -- 포항
    (163, '2023-08-25', 7),  -- 수원
    (164, '2023-08-25', 10), -- 전주W
    (165, '2023-08-26', 3),  -- 대구전
    (166, '2023-08-26', 1),  -- 춘천
    (167, '2023-08-27', 5),  -- 서울W
    (168, '2023-08-27', 2);  -- 광주
INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (169, '2023-09-01', 4),  -- 대전W
    (170, '2023-09-01', 3),  -- 대구전
    (171, '2023-09-02', 6),  -- 수원W
    (172, '2023-09-02', 9),  -- 인천
    (173, '2023-09-03', 8),  -- 문수
    (174, '2023-09-03', 11), -- 제주W
    (175, '2023-09-16', 10), -- 전주W
    (176, '2023-09-16', 9),  -- 인천
    (177, '2023-09-16', 12), -- 포항
    (178, '2023-09-16', 8),  -- 문수
    (179, '2023-09-17', 5),  -- 서울W
    (180, '2023-09-17', 6),  -- 수원W
    (181, '2023-09-23', 4),  -- 대전W
    (182, '2023-09-23', 11), -- 제주W
    (183, '2023-09-23', 7),  -- 수원
    (184, '2023-09-24', 2),  -- 광주
    (185, '2023-09-24', 1),  -- 춘천
    (186, '2023-09-24', 3);  -- 대구전
INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (187, '2023-09-30', 12), -- 포항
    (188, '2023-09-30', 7),  -- 수원
    (189, '2023-09-30', 10), -- 전주W
    (190, '2023-09-30', 9),  -- 인천
    (191, '2023-10-01', 1),  -- 춘천
    (192, '2023-10-01', 11), -- 제주W
    (193, '2023-10-08', 8),  -- 문수
    (194, '2023-10-08', 3),  -- 대구전
    (195, '2023-10-08', 5),  -- 서울W
    (196, '2023-10-08', 6),  -- 수원W
    (197, '2023-10-08', 2),  -- 광주
    (198, '2023-10-08', 4),  -- 대전W
    (199, '2023-10-20', 12), -- 포항
    (200, '2023-10-21', 2),  -- 광주
    (201, '2023-10-21', 3),  -- 대구전
    (202, '2023-10-22', 5),  -- 서울W
    (203, '2023-10-22', 11), -- 제주W
    (204, '2023-10-22', 4),  -- 대전W
    (205, '2023-10-28', 10), -- 전주W
    (206, '2023-10-28', 2),  -- 광주
    (207, '2023-10-28', 1);  -- 춘천
INSERT INTO Game (GameID, Date, LocationID)
VALUES
    (208, '2023-10-29', 8),  -- 문수
    (209, '2023-10-29', 6),  -- 수원W
    (210, '2023-10-29', 7),  -- 수원
    (211, '2023-11-11', 4),  -- 대전W
    (212, '2023-11-11', 3),  -- 대구전
    (213, '2023-11-11', 11), -- 제주W
    (214, '2023-11-12', 9),  -- 인천
    (215, '2023-11-12', 7),  -- 수원
    (216, '2023-11-12', 8),  -- 문수
    (217, '2023-11-24', 9),  -- 인천
    (218, '2023-11-25', 10), -- 전주W
    (219, '2023-11-25', 11), -- 제주W
    (220, '2023-11-25', 12), -- 포항
    (221, '2023-11-25', 5),  -- 서울W
    (222, '2023-11-25', 1),  -- 춘천
    (223, '2023-12-02', 4),  -- 대전W
    (224, '2023-12-02', 7),  -- 수원
    (225, '2023-12-02', 6),  -- 수원W
    (226, '2023-12-03', 8),  -- 문수
    (227, '2023-12-03', 2),  -- 광주
    (228, '2023-12-03', 3);  -- 대구전

INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (1, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (1, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (2, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (2, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (3, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (3, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (4, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (4, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (5, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (5, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (6, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (6, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (7, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (7, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (8, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (8, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (9, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (9, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (10, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (10, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (11, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (11, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (12, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (12, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (13, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (13, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (14, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (14, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (15, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (15, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (16, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (16, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (17, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (17, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (18, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (18, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (19, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (19, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (20, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (20, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (21, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (21, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (22, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (22, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (23, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (23, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (24, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (24, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (25, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (25, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (26, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (26, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (27, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (27, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (28, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (28, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (29, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (29, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (30, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (30, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (31, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (31, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (32, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (32, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (33, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (33, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (34, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (34, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (35, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (35, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (36, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (36, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (37, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (37, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (38, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (38, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (39, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (39, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (40, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (40, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (41, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (41, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (42, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (42, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (43, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (43, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (44, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (44, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (45, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (45, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (46, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (46, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (47, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (47, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (48, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (48, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (49, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (49, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (50, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (50, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (51, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (51, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (52, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (52, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (53, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (53, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (54, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (54, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (55, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (55, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (56, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (56, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (57, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (57, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (58, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (58, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (59, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (59, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (60, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (60, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (61, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (61, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (62, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (62, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (63, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (63, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (64, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (64, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (65, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (65, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (66, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (66, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (67, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (67, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (68, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (68, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (69, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (69, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (70, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (70, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (71, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (71, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (72, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (72, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (73, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (73, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (74, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (74, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (75, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (75, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (76, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (76, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (77, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (77, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (78, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (78, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (79, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (79, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (80, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (80, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (81, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (81, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (82, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (82, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (83, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (83, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (84, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (84, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (85, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (85, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (86, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (86, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (87, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (87, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (88, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (88, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (89, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (89, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (90, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (90, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (91, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (91, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (92, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (92, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (93, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (93, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (94, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (94, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (95, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (95, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (96, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (96, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (97, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (97, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (98, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (98, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (99, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (99, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (100, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (100, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (101, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (101, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (102, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (102, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (103, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (103, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (104, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (104, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (105, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (105, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (106, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (106, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (107, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (107, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (108, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (108, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (109, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (109, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (110, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (110, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (111, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (111, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (112, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (112, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (113, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (113, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (114, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (114, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (115, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (115, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (116, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (116, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (117, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (117, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (118, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (118, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (119, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (119, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (120, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (120, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (121, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (121, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (122, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (122, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (123, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (123, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (124, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (124, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (125, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (125, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (126, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (126, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (127, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (127, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (128, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (128, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (129, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (129, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (130, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (130, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (131, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (131, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (132, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (132, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (133, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (133, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (134, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (134, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (135, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (135, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (136, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (136, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (137, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (137, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (138, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (138, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (139, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (139, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (140, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (140, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (141, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (141, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (142, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (142, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (143, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (143, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (144, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (144, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (145, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (145, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (146, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (146, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (147, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (147, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (148, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (148, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (149, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (149, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (150, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (150, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (151, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (151, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (152, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (152, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (153, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (153, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (154, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (154, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (155, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (155, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (156, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (156, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (157, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (157, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (158, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (158, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (159, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (159, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (160, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (160, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (161, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (161, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (162, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (162, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (163, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (163, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (164, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (164, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (165, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (165, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (166, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (166, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (167, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (167, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (168, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (168, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (169, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (169, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (170, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (170, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (171, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (171, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (172, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (172, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (173, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (173, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (174, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (174, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (175, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (175, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (176, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (176, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (177, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (177, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (178, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (178, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (179, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (179, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (180, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (180, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (181, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (181, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (182, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (182, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (183, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (183, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (184, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (184, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (185, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (185, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (186, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (186, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (187, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (187, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (188, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (188, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (189, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (189, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (190, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (190, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (191, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (191, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (192, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (192, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (193, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (193, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (194, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (194, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (195, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (195, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (196, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (196, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (197, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (197, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (198, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (198, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (199, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (199, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (200, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (200, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (201, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (201, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (202, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (202, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (203, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (203, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (204, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (204, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (205, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (205, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (206, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (206, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (207, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (207, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (208, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (208, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (209, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (209, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (210, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (210, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (211, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (211, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (212, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (212, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (213, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (213, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (214, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (214, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (215, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (215, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (216, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (216, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (217, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (217, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (218, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (218, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (219, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (219, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (220, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (220, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (221, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (221, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (222, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (222, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (223, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (223, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (224, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (224, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (225, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (225, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (226, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (226, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (227, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (227, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (228, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (228, 5, 'Away');




