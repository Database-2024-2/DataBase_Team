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
    Formation VARCHAR(100),  			-- 포메이션
    Coach VARCHAR(100),                 -- 코치
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
    
    INSERT INTO Team (TeamID, Name, Strength, WinRate, Strategy, Formation, Coach, AvgScore, AvgConcede) VALUES
(1, '강원 FC', 70, 0.30, '중앙 압박', '4-3-3', '이영표', 1.21, 1.68),
(2, '광주 FC', 78, 0.47, '중앙 플레이', '4-2-3-1', '이정효', 1.42, 1.42),
(3, '대구 FC', 62, 0.28, '빠른 역습', '3-4-3', '최원권', 1.05, 1.84),
(4, '대전 하나 시티즌', 82, 0.52, '측면 활용', '3-4-3', '이민성', 1.58, 1.42),
(5, 'FC 서울', 85, 0.57, '공격+수비 밸런스', '4-3-3', '안익수', 1.58, 1.34),
(6, '수원 삼성', 65, 0.30, '수비 반격', '4-4-2', '김병수', 1.11, 1.79),
(7, '수원 FC', 68, 0.34, '롱볼 중심', '4-2-3-1', '이병근', 1.26, 1.74),
(8, '울산 현대', 95, 0.71, '공격 중심', '4-2-3-1', '홍명보', 1.94, 1.05),
(9, '인천 유나이티드', 76, 0.45, '수비적인 전술', '5-4-1', '조성환', 1.26, 1.37),
(10, '전북 현대', 88, 0.60, '수비 안정화', '4-4-2', '댄 페트레스쿠', 1.63, 1.18),
(11, '제주 유나이티드', 80, 0.50, '포지셔닝 기반', '4-4-2', '남기일', 1.47, 1.37),
(12, '포항 스틸러스', 90, 0.65, '빠른 역습', '4-1-4-1', '김기동', 1.68, 1.11);


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

INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (1, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (1, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (2, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (2, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (3, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (3, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (4, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (4, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (5, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (5, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (6, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (6, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (7, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (7, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (8, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (8, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (9, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (9, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (10, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (10, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (11, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (11, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (12, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (12, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (13, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (13, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (14, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (14, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (15, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (15, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (16, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (16, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (17, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (17, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (18, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (18, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (19, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (19, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (20, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (20, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (21, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (21, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (22, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (22, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (23, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (23, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (24, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (24, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (25, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (25, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (26, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (26, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (27, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (27, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (28, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (28, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (29, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (29, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (30, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (30, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (31, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (31, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (32, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (32, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (33, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (33, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (34, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (34, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (35, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (35, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (36, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (36, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (37, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (37, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (38, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (38, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (39, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (39, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (40, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (40, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (41, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (41, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (42, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (42, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (43, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (43, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (44, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (44, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (45, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (45, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (46, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (46, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (47, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (47, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (48, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (48, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (49, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (49, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (50, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (50, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (51, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (51, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (52, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (52, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (53, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (53, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (54, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (54, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (55, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (55, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (56, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (56, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (57, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (57, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (58, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (58, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (59, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (59, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (60, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (60, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (61, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (61, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (62, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (62, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (63, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (63, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (64, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (64, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (65, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (65, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (66, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (66, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (67, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (67, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (68, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (68, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (69, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (69, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (70, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (70, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (71, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (71, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (72, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (72, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (73, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (73, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (74, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (74, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (75, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (75, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (76, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (76, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (77, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (77, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (78, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (78, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (79, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (79, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (80, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (80, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (81, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (81, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (82, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (82, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (83, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (83, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (84, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (84, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (85, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (85, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (86, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (86, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (87, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (87, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (88, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (88, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (89, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (89, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (90, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (90, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (91, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (91, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (92, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (92, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (93, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (93, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (94, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (94, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (95, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (95, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (96, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (96, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (97, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (97, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (98, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (98, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (99, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (99, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (100, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (100, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (101, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (101, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (102, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (102, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (103, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (103, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (104, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (104, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (105, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (105, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (106, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (106, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (107, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (107, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (108, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (108, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (109, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (109, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (110, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (110, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (111, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (111, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (112, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (112, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (113, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (113, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (114, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (114, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (115, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (115, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (116, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (116, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (117, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (117, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (118, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (118, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (119, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (119, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (120, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (120, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (121, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (121, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (122, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (122, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (123, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (123, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (124, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (124, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (125, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (125, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (126, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (126, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (127, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (127, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (128, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (128, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (129, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (129, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (130, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (130, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (131, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (131, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (132, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (132, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (133, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (133, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (134, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (134, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (135, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (135, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (136, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (136, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (137, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (137, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (138, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (138, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (139, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (139, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (140, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (140, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (141, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (141, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (142, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (142, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (143, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (143, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (144, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (144, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (145, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (145, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (146, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (146, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (147, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (147, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (148, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (148, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (149, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (149, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (150, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (150, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (151, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (151, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (152, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (152, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (153, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (153, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (154, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (154, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (155, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (155, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (156, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (156, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (157, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (157, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (158, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (158, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (159, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (159, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (160, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (160, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (161, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (161, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (162, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (162, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (163, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (163, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (164, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (164, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (165, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (165, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (166, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (166, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (167, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (167, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (168, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (168, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (169, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (169, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (170, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (170, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (171, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (171, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (172, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (172, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (173, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (173, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (174, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (174, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (175, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (175, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (176, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (176, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (177, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (177, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (178, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (178, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (179, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (179, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (180, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (180, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (181, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (181, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (182, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (182, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (183, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (183, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (184, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (184, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (185, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (185, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (186, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (186, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (187, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (187, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (188, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (188, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (189, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (189, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (190, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (190, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (191, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (191, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (192, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (192, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (193, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (193, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (194, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (194, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (195, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (195, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (196, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (196, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (197, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (197, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (198, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (198, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (199, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (199, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (200, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (200, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (201, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (201, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (202, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (202, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (203, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (203, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (204, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (204, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (205, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (205, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (206, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (206, 9, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (207, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (207, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (208, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (208, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (209, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (209, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (210, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (210, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (211, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (211, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (212, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (212, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (213, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (213, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (214, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (214, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (215, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (215, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (216, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (216, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (217, 9, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (217, 8, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (218, 10, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (218, 2, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (219, 11, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (219, 4, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (220, 12, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (220, 3, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (221, 5, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (221, 6, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (222, 1, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (222, 7, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (223, 4, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (223, 5, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (224, 7, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (224, 11, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (225, 6, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (225, 1, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (226, 8, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (226, 10, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (227, 2, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (227, 12, 'Away');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (228, 3, 'Home');
INSERT INTO Game_Participation (GameID, TeamID, Role) VALUES (228, 9, 'Away');


INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (1, 8, 2, 2, 10, 11, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (1, 10, 1 ,1 ,14 ,17 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (2, 5, 2, 2, 13, 15, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (2, 9, 1, 1, 15, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (3, 6, 0,0 ,10 ,13 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (3, 2, 1, 1,10 ,11 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (4, 12, 3,3 ,9 ,8 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (4, 3, 2, 2,5 ,13 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (5, 11,0 ,0 ,14 ,13 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (5, 1, 0, 0, 8, 10, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (6, 4, 2, 2,9 ,12 ,5 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (6, 1, 0,0 ,11 ,7 , 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (7, 9, 3, 3, 22,10 ,3 ,1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (7, 4, 2, 2, 7, 10, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (8, 7, 1,1 , 5,13 ,1 ,1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (8, 12, 2, 2, 9,10 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (9, 3, 1,1 ,11 ,19 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (9, 11, 1, 1,12 ,14 ,3 , 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (10, 10, 1,1 ,8 ,15 ,2 , 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (10, 6, 1, 1, 20, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (11, 1, 0, 0, 9,6 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (11, 8, 1, 1, 10, 8,4 , 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (12, 2, 0,0 ,6 ,12 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (12, 5, 2, 2,7 ,15 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (13, 7, 2,2 ,11 ,10 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (13, 6, 1, 1, 10, 13, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (14, 4, 0, 0, 10, 11,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (14, 12, 0, 0, 3,17 ,1 ,1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (15, 1, 1, 1,7 ,13 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (15, 3, 1, 1, 10, 14, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (16, 5, 1, 1,3 ,10 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (16, 8, 2,2 ,8 ,11 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (17, 10, 2, 2, 15, 18, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (17, 2, 0, 0, 8,18 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (18, 9, 1,1 ,13 ,12 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (18, 11,0 ,0 ,9 ,5 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (19, 12, 1, 1, 12, 11, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (19, 1, 1, 1, 3,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (20, 2, 5, 5, 17, 7,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (20, 9, 0,0 ,9 ,14 , 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (21, 11, 1,1 ,10 ,6 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (21, 5, 2, 2, 9,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (22, 3, 2, 2, 11,15 ,5 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (22, 10, 0, 0, 11,10 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (23, 6, 1, 1, 15,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (23, 4, 3, 3, 11,11 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (24, 8, 3, 3, 16, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (24, 7, 0, 0, 9,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (25, 10, 1, 1, 8, 14, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (25, 12, 2, 2, 8,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (26, 9, 0,0 ,6 ,8 , 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (26, 3, 0, 0, 5,12 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (27, 2, 2, 2, 17,10 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (27, 7, 0, 0, 6, 12, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (28, 4, 3, 3, 16, 6, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (28, 5, 2, 2, 13, 8, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (29, 11, 1, 1, 15, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (29, 8, 3, 3, 15, 13, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (30, 6, 1, 1, 9, 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (30, 1, 1, 1, 12, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (31, 8, 2, 2, 10, 13, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (31, 6, 1, 1, 14, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (32, 5, 3, 3, 14, 8, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (32, 3, 0, 0, 12, 11,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (33, 12, 2, 2, 9, 11,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (33, 2, 0, 0, 3, 9,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (34, 10, 2, 2, 5, 14, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (34, 9, 0, 0, 4, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (35, 1, 0, 0, 11,13 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (35, 11, 1, 1, 8, 13, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (36, 7, 5, 5, 19, 11, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (36, 4, 3, 3, 8, 16, 1, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (37, 6, 2,2 , 11, 17, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (37, 11, 3,3 ,12 ,9 ,5 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (38, 12, 1, 1, 8, 5, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (38, 5, 1, 1, 5, 14, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (39, 7, 1,1 ,16 ,6 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (39, 10, 0, 0, 11,8 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (40, 1,  0, 0 , 5 ,11  ,2  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (40, 9,  2, 2 , 7 ,14  ,2  , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (41, 4,  2,  2, 10 , 14 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (41, 8,  1, 1 , 16 , 7 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (42, 3,  3, 3 , 11 , 17 , 5 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (42, 2, 4 , 4 , 13 , 14 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (43, 5,  3, 3 , 15 , 3 , 3 ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (43, 6, 1 ,1  ,10  ,12  ,1  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (44, 8, 2 , 2 , 14 , 5 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (44, 12,  2, 2 , 13 , 15 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (45, 3, 1 , 1 , 12 , 13 , 4 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (45, 4,  0,  0,  11,  9, 5 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (46, 9, 2 , 2 , 16 , 10 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (46, 7,  2, 2 , 12 , 7 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (47, 2, 0 , 0 , 10 , 8 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (47, 1, 0 , 0 , 6 , 11 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (48, 11, 0 , 0 , 12 ,  8,  3, 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (48, 10, 2 , 2 , 9 , 14 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (49, 12, 1 , 1 , 7 , 14 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (49, 6,  0, 0 , 4 , 18 ,4  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (50, 9,  0,  0,  6, 14 , 0 ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (50, 8,  1, 1 , 9 , 12 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (51, 1,  3, 3 , 7 , 9 ,0  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (51, 5,  2, 2 , 9 , 5 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (52, 2,  0, 0 , 16 , 15 , 2 ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (52, 11, 1 , 1 , 6 , 14 , 4 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (53, 10, 1 , 1 , 9 , 8 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (53, 4, 2 , 2 , 10 , 17 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (54, 7, 1 , 1 , 14 , 11, 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (54, 3, 1 , 1 , 18 , 8 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (55, 7,  0,  0,  8, 13 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (55, 5, 3 , 3 , 13 , 14 , 3 ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (56, 10, 0 , 0 , 10 , 9 , 3 , 1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (56, 1, 1 , 1 , 4 , 14 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (57, 4,  0, 0 , 7 , 12 , 0 ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (57, 11, 3 , 3 , 15 ,17  ,2  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (58, 12, 0 , 0 , 2 , 8 , 4 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (58, 9,  2,  2, 6 , 15 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (59, 6,  0,  0, 13 , 10 ,4  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (59, 3,  1,  1, 6 , 13 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (60, 8, 2 , 2 , 12 ,  8,  3, 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (60, 2, 1 , 1 , 14 , 15 , 5 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (61, 3, 0 , 0 , 12 , 17 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (61, 8, 3 , 3 , 8 , 7 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (62, 5, 1 , 1 , 14 , 8 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (62, 10, 1 , 1 , 9 , 19 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (63, 9, 0 , 0 , 13 , 8 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (63, 6, 1 , 1 , 7 , 26 , 8 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (64, 11, 2 , 2 , 6 , 15 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (64, 12, 1 , 1 , 13 , 12 ,5  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (65, 7, 2 , 2 ,  13,  11, 5 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (65, 1,  0,  0, 11 , 17 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (66, 2, 0 , 0 , 10 , 10 , 3 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (66, 4,  0,  0, 5 ,  21, 4 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (67, 8,  1, 1 , 11 , 7 ,2  ,0  );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (67, 1,  0, 0 , 6 , 6 , 0 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (68, 3, 1 , 1 , 7 , 14 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (68, 12,  1, 1 , 12 , 8 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (69, 5, 3 , 3 , 13 , 10 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (69, 2, 1 , 1 , 5 , 12 ,  3,  0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (70, 11,  2, 2 , 17 , 7 , 2 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (70, 9, 0 , 0 , 8 , 10 , 1 , 0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (71, 6, 0, 0, 5, 11, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (71, 10, 3, 3, 18, 12,3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (72, 4, 2, 2, 12, 18,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (72, 7, 1, 1,20 ,11, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (73, 12, 3, 3, 10, 7, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (73, 4, 2, 2, 6, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (74, 2, 0, 0, 7, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (74, 3, 2,2 ,6 ,7 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (75, 1, 0, 0, 11, 11, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (75, 6, 2, 2, 8, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (76, 8, 3, 3, 13, 5, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (76, 5, 2, 2,17 ,11 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (77, 9, 0, 0, 9, 16, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (77, 10, 0, 0, 9, 7, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (78, 7, 0, 0, 11, 12, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (78, 11, 5, 5, 13, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (79, 9, 1, 1, 14, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (79, 2, 1, 1, 11, 12, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (80, 5, 1, 1, 15,8 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (80, 11, 1, 1, 5, 3, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (81, 4, 0, 0,16 ,7 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (81, 3, 1, 1, 8, 16, 6, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (82, 1, 0, 0, 5,16 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (82, 12, 0, 0,11 ,11 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (83, 6, 2, 2, 5, 6, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (83, 8, 3, 3, 21, 10, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (84, 10, 3, 3, 15, 9, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (84, 7, 1, 1, 8, 10, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (85, 11, 2, 2, 10, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (85, 6, 1,1 ,7 ,10 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (86, 3, 2, 2, 13, 7, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (86, 9, 2,2 ,14 ,13 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (87, 5, 1,1 ,12 ,7 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (87, 1, 0, 0, 5, 11, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (88, 7, 0, 0, 8, 6, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (88, 2, 2,2 ,20 , 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (89, 8, 3, 3, 16, 10, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (89, 4, 3, 3, 13, 10, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (90, 12, 1,1 ,13 , 7, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (90, 10, 0, 0, 8, 13, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (91, 10,2, 2, 10, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (91, 8, 0, 0,10 ,9 ,1 , 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (92, 6, 1, 1, 18,5 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (92, 7, 2, 2, 7, 15, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (93, 11, 2, 2, 12, 12, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (93, 1, 2, 2, 13, 15,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (94, 2, 4, 4,10 ,8 ,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (94, 12, 2, 2, 8, 14, 5,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (95, 4, 1, 1, 13, 6, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (95, 9, 3,3 ,7 ,13 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (96, 3, 1, 1, 10, 13, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (96, 5, 0, 0, 9, 6, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (97, 7, 1, 1, 11,7 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (97, 8, 3, 3, 14, 2, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (98, 12, 2, 2, 11, 10, 4,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (98, 11, 1,1 ,3 ,14 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (99, 10, 1, 1, 10,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (99, 3, 0, 0, 9, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (100, 2, 2,2,9,9,1,0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (100, 6, 1,1 ,3 ,13 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (101, 9,1, 1, 10,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (101, 5, 0, 0, 9, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (102, 1, 1, 1, 9, 13, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (102, 4, 2, 2, 8, 12, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (103, 3, 3, 3, 9,8 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (103, 7, 1,1 ,17 ,17 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (104, 8, 5 , 5, 13, 11,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (104, 11, 1, 1, 13, 8, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (105, 4,1 ,1 ,13 ,8 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (105, 2, 1, 1, 11, 11,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (106, 1, 1, 1,5 ,14 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (106, 10, 2, 2, 15, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (107, 5, 1, 1, 9, 11, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (107, 12, 1,1 ,8 ,6 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (108, 6, 0, 0, 4,14 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (108, 9, 0, 0, 10, 11, 1, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (109, 6, 0,0 ,13 ,7 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (109, 5, 1, 1, 13,8 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (110, 11, 1, 1,10 ,14 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (110, 4, 1, 1,10 ,12 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (111, 2, 2, 2, 10, 5,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (111, 10, 0, 0, 6,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (112, 8, 3, 3, 13, 13,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (112, 3, 1, 1,7 ,15 ,1 ,1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (113, 9, 0, 0, 14,7 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (113, 12, 1,1 ,11 ,11 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (114, 7, 1, 1, 18, 11,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (114, 1, 1, 1, 16, 8, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (115, 10, 2, 2, 8,13 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (115, 11,0 ,0 ,17 ,4 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (116, 3, 1, 1, 13, 11,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (116, 6, 1, 1,9 ,21 , 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (117, 5, 0,0 ,12 ,6 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (117, 4, 0, 0, 1, 11,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (118, 2, 0, 0, 6, 13, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (118, 8, 1, 1, 6, 18, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (119, 12, 3, 3,16 , 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (119, 7, 1, 1, 6, 12, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (120, 9, 1, 1, 11,15 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (120, 1, 0, 0, 11, 10, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (121, 11, 1, 1,12 ,12 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (121, 3, 2, 2, 16, 10, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (122, 1, 1, 1, 10, 13, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (122, 2,1 , 1, 11, 12, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (123, 12, 0, 0,13 ,14 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (123, 8, 1, 1, 2, 10,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (124, 7, 2, 2, 16, 4, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (124, 9, 2, 2, 4, 15, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (125, 10, 2 ,2 ,12 ,10 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (125, 5, 1, 1, 14, 5, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (126, 4, 2, 2, 14, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (126, 6, 2, 2, 13, 8, 5, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (127, 3, 0, 0, 11,10 , 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (127, 1, 0, 0,9 ,11 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (128, 11, 0,0 ,12 ,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (128, 2, 0, 0, 8, 10, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (129, 8, 1, 1, 18, 4, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (129, 9, 2, 2, 10, 2, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (130, 6, 1, 1, 9, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (130, 12, 1, 1, 7, 7, 2, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (131, 4, 2, 2, 10, 6, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (131, 10, 2, 2, 15, 14, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (132, 5, 7, 7, 22, 10, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (132, 7, 2, 2, 10, 2, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (133, 6, 3, 3, 11, 8,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (133, 8, 1, 1, 10, 7, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (134, 1, 1, 1, 10, 6, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (134, 5, 1, 1, 14, 8, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (135, 2, 1, 1, 7, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (135, 3, 1, 1, 9, 13, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (136, 10, 1, 1, 13, 14, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (136, 7, 0,0 ,14 ,12 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (137, 12, 4, 4, 8, 9, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (137, 11, 2, 2, 8, 2, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (138, 9,2 ,2 ,7 ,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (138, 4, 0, 0, 7, 14, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (139, 8, 2, 2, 7, 11,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (139, 11, 1, 1, 14, 12, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (140, 12, 2, 2, 11, 12, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (140, 10, 1, 1, 9,14 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (141, 7, 0, 0,14 ,7 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (141, 2, 1, 1, 14, 14, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (142, 1, 1,1 , 12, 12, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (142, 6, 2, 2, 13, 6, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (143, 5, 0, 0, 11, 7, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (143, 9, 1, 1, 9, 4, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (144, 4, 1, 1, 11, 15, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (144, 3, 0, 0,6 ,14 ,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (145, 5, 2, 2, 11, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (145, 12, 2, 2, 8, 4, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (146, 2, 3, 3, 12, 16, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (146, 4, 0, 0, 8, 15, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (147, 6, 0, 0,9 ,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (147, 7, 2, 2, 9, 14, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (148, 3, 0, 0,9 ,7 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (148, 8, 0, 0, 15, 8, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (149, 10, 2, 2, 11, 7, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (149, 9, 0, 0, 12, 4,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (150, 11, 1, 1, 14, 8,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (150, 1, 1, 1, 6, 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (151, 10, 1, 1, 11, 16, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (151, 6, 1, 1, 4, 4, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (152, 1,2 ,2 ,19 ,8 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (152, 8, 0, 0, 7,10 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (153, 11, 3, 3, 15, 10, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (153, 7, 0, 0, 7, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (154, 4, 4, 4, 17, 11,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (154, 5, 3, 3, 15, 9, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (155, 9, 3, 3, 12, 10, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (155, 3, 1, 1, 8, 9,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (156, 12, 1, 1, 7, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (156, 2,1 ,1 ,4 ,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (157, 6, 1, 1, 8,8 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (157, 11,0 ,0 ,12 ,12 ,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (158, 9, 2, 2,6 ,7 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (158, 2, 2, 2, 14, 6, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (159, 8, 1, 1, 13, 8, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (159, 10, 0,0 ,15 ,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (160, 1, 1, 1, 11, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (160, 7, 2, 2, 11, 12, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (161, 5, 2, 2, 8, 9, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (161, 3, 2, 2, 10, 9, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (162, 12, 4, 4, 12, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (162, 4, 3, 3, 9, 7, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (163, 7, 1, 1, 14, 8, 1, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (163, 9, 2, 2, 9,13 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (164, 10, 1, 1, 10 , 9, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (164, 4, 1, 1, 7,7 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (165, 3, 1,1 , 13, 9, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (165, 11, 0, 0, 14, 8, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (166, 1, 1, 1, 8, 10,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (166, 12, 1, 1, 7, 6, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (167, 5, 2, 2, 16, 15, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (167, 8, 2, 2, 16, 4,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (168, 2, 4, 4,14 ,15 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (168, 6, 0, 0,6 ,12 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (169, 4, 0,0 ,10 ,14 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (169, 7, 1, 1, 10, 5, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (170, 3, 1,1 ,12 ,15 ,7 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (170, 1, 0, 0, 7, 9,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (171, 6, 0, 0, 16, 6, 2, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (171, 5, 1,1 ,13 ,15 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (172, 9, 0, 0,13 ,11 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (172, 12, 2, 2, 10, 6, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (173, 8, 0, 0, 17, 14, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (173, 2, 2, 2, 8, 13, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (174, 11, 0, 0,10 ,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (174, 10, 0, 0, 17, 12, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (175, 10, 1, 1, 12, 13, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (175, 1, 3, 3, 18, 13,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (176, 9, 2, 2, 8, 11,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (176, 11, 1, 1, 9,12 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (177, 12, 2,2 ,12 ,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (177, 7, 0, 0, 1, 14, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (178, 8, 1, 1, 10, 14, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (178, 4, 1, 1, 5, 9, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (179, 5, 0, 0, 18, 15, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (179, 2, 1, 1, 3, 11, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (180, 6, 0, 0,11 ,8 ,4 , 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (180, 3, 1, 1, 8, 12, 2, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (181, 4, 3, 3, 11, 14, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (181, 6, 1, 1, 12, 12, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (182, 11, 1, 1, 9, 19,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (182, 5, 3, 3, 11,14 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (183, 7, 2, 2, 5, 9, 1, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (183, 8, 3, 3, 10, 8, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (184, 2, 0, 0,15 ,14 ,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (184, 10, 1, 1, 5, 10, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (185, 1, 1,1 ,12 ,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (185, 9, 1, 1, 13, 9, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (186, 3, 0, 0, 9, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (186, 12, 0, 0, 7, 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (187, 12, 0, 0, 12, 11, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (187, 8, 0, 0, 1, 11,5 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (188, 7, 1, 1, 16, 12, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (188, 5, 1,1 ,11 ,10 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (189, 10, 1, 1, 16, 13, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (189, 3, 3, 3, 14, 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (190, 9, 2, 2, 10, 11,6 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (190, 6, 0, 0, 12, 6, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (191, 1, 1, 1, 11, 12, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (191, 4, 1, 1, 4, 9,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (192, 11, 1, 1, 10,8 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (192, 2, 2, 2, 7, 10, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (193, 8,0 ,0 ,9 ,7 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (193, 9, 0, 0, 6, 3, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (194, 3,2 ,2 ,12 ,14 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (194, 7, 2, 2, 9, 12, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (195, 5, 0, 0, 15, 5, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (195, 10, 2, 2,9 ,10 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (196, 6, 1, 1, 10, 13, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (196, 12, 0, 0, 15, 13, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (197, 2, 1,1 , 6, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (197, 1, 0, 0, 4, 14, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (198, 4, 1, 1, 12, 8, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (198, 11, 0, 0, 13, 6, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (199, 12, 1, 1, 8, 9, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (199, 9, 1, 1, 7,8 , 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (200, 1, 1,1, 11, 6, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (200, 8, 0, 0, 8, 16, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (201, 3, 1, 1,17 ,6 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (201, 10, 2, 2, 16, 10, 4, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (202, 5, 2,2 ,18 ,7 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (202, 1, 1, 1,5 ,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (203, 11, 2,2 ,12 ,10 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (203, 6, 0, 0, 9, 8, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (204, 4, 1, 1,16 ,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (204, 7, 1, 1, 12, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (205, 10, 1, 1, 12,16 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (205, 12, 1, 1, 11,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (206, 2, 0, 0,11 ,7 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (206, 9, 2, 2, 5, 9, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (207, 1, 1,1 ,10 ,16 ,4 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (207, 11, 1, 1, 9,4 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (208, 8, 2, 2, 10, 7, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (208, 3, 0, 0,6 ,7 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (209, 6, 2,2 ,7 ,8 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (209, 4, 2, 2, 9, 8,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (210, 7, 3,3 ,14 ,9 ,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (210, 5, 4, 4, 16, 9, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (211, 4, 0, 0, 5, 15, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (211, 1, 1, 1, 17, 9, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (212, 3, 1, 1, 9, 11,0 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (212, 2, 1, 1, 9, 8, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (213, 11, 0, 0, 11, 13, 1, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (213, 5, 0,0 ,14 ,8 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (214, 9, 1, 1, 14, 11, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (214, 10, 1, 1, 5,11 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (215, 7, 2,2 ,24 ,9 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (215, 6, 3, 3, 13, 6, 2, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (216, 8,3, 3, 12, 8,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (216, 12, 2, 2, 13, 9, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (217, 9, 3,3 ,14 ,9 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (217, 8, 1,1 ,13 ,5 ,1 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (218, 10, 2,2 , 11, 10, 1,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (218, 2, 0, 0, 10, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (219, 11, 0, 0, 13, 10, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (219, 4, 2, 2, 12, 14, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (220, 12,1 ,1 ,8 ,12 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (220, 3, 0, 0, 8, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (221, 5, 0, 0, 10, 12, 3, 1);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (221, 6, 1, 1, 14,8 ,2 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (222, 1, 2,2 ,7 ,16 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (222, 7, 0, 0, 12, 7, 0, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (223, 4, 2,2 ,17 ,15 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (223, 5, 2, 2, 14, 8, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (224, 7, 1, 1, 14, 9, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (224, 11, 1, 1, 9, 12, 2, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (225, 6, 0, 0, 7,12 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (225, 1, 0, 0, 9, 10, 3, 0);
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (226, 8, 1,1 ,16 ,15 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (226, 10, 0, 0, 12, 14, 2,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (227, 2, 0, 0, 17, 10, 3,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (227, 12, 0, 0,3 ,8 ,1 ,1 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (228, 3,2 ,2 ,9 ,12 ,3 ,0 );
INSERT INTO Game_Result (GameID, TeamID, Goals, Assists, Shots, Fouls, YellowCards, RedCards) VALUES (228, 9, 1, 1, 7, 11, 4,0 );

