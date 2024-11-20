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

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(1, '정민우', 73, 179, 23, 'FW', 1),
(2, '박경배', 70, 182, 22, 'FW', 1),
(3, '조윤성', 80, 185, 24, 'DF', 1),
(4, '김진호', 74, 178, 23, 'DF', 1),
(5, '김정호', 78, 185, 25, 'GK', 1),
(6, '조현태', 75, 184, 20, 'DF', 1),
(7, '우병철', 77, 182, 23, 'FW', 1),
(8, '김주형', 65, 175, 22, 'FW', 1),
(9, '김주성', 74, 177, 21, 'DF', 1),
(10, '박희근', 78, 183, 24, 'GK', 1),
(11, '강의찬', 76, 179, 22, 'FW', 1),
(12, '송준석', 68, 174, 22, 'DF', 1),
(13, '이지우', 68, 175, 21, 'DF', 1),
(14, '김현규', 70, 178, 22, 'MF', 1),
(15, '최인규', 80, 188, 21, 'DF', 1),
(16, '최성민', 75, 179, 21, 'FW', 1),
(17, '지의수', 72, 176, 23, 'MF', 1),
(18, '홍원진', 79, 183, 23, 'MF', 1),
(19, '김해승', 80, 185, 21, 'FW', 1),
(20, '이강한', 68, 176, 23, 'DF', 1),
(21, '권석주', 63, 178, 21, 'DF', 1),
(22, '권재범', 87, 191, 22, 'GK', 1),
(23, '박기현', 65, 173, 20, 'FW', 1),
(24, '김기환', 74, 178, 23, 'DF', 1),
(25, '박상혁', 75, 182, 22, 'FW', 1);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(26, '김경민', 76, 189, 25, 'GK', 2),
(27, '이준', 79, 190, 28, 'GK', 2),
(28, '노희동', 80, 188, 27, 'GK', 2),
(29, '김태준', 77, 185, 24, 'GK', 2),
(30, '엄지성', 65, 177, 21, 'FW', 2),
(31, '허 율', 72, 179, 24, 'FW', 2),
(32, '아사니', 80, 185, 30, 'FW', 2),
(33, '신창무', 75, 180, 26, 'FW', 2),
(34, '이건희', 73, 176, 28, 'FW', 2),
(35, '하승운', 69, 180, 25, 'FW', 2),
(36, '정지훈', 71, 178, 27, 'FW', 2),
(37, '토마스', 82, 188, 29, 'FW', 2),
(38, '주영재', 74, 183, 26, 'FW', 2),
(39, '베 카', 85, 190, 31, 'FW', 2),
(40, '정호연', 70, 182, 24, 'MF', 2),
(41, '이희균', 70, 172, 26, 'MF', 2),
(42, '최준혁', 73, 178, 27, 'MF', 2),
(43, '이강현', 75, 183, 25, 'MF', 2),
(44, '박한빈', 71, 179, 28, 'MF', 2),
(45, '이순민', 73, 180, 25, 'MF', 2),
(46, '오후성', 72, 176, 27, 'MF', 2),
(47, '이민기', 76, 185, 29, 'DF', 2),
(48, '김승우', 78, 183, 30, 'DF', 2),
(49, '티 모', 80, 188, 28, 'DF', 2),
(50, '안영규', 77, 186, 31, 'DF', 2),
(51, '이으뜸', 75, 180, 27, 'DF', 2),
(52, '김한길', 73, 181, 29, 'DF', 2),
(53, '두현석', 80, 185, 26, 'DF', 2),
(54, '김경재', 75, 187, 30, 'DF', 2),
(55, '이상기', 72, 180, 27, 'DF', 2),
(56, '김동국', 74, 182, 26, 'DF', 2),
(57, '아 론', 78, 187, 28, 'DF', 2);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(58, '최영은', 83, 188, 28, 'GK', 3),
(59, '황재원', 73, 184, 21, 'DF', 3),
(60, '안창민', 68, 176, 25, 'MF', 3),
(61, '장성원', 68, 175, 23, 'MF', 3),
(62, '홍정운', 84, 184, 26, 'DF', 3),
(63, '김진혁', 76, 188, 29, 'FW', 3),
(64, '세라토', 67, 172, 25, 'MF', 3),
(65, '에드가', 81, 190, 32, 'FW', 3),
(66, '세징야', 72, 173, 34, 'FW', 3),
(67, '그라지에', 74, 180, 28, 'MF', 3),
(68, '오승훈', 85, 186, 33, 'GK', 3),
(69, '이근호', 68, 176, 38, 'FW', 3),
(70, '박종진', 73, 175, 27, 'MF', 3),
(71, '서보민', 78, 178, 34, 'MF', 3),
(72, '이진용', 82, 184, 25, 'DF', 3),
(73, '김동현', 75, 182, 26, 'MF', 3),
(74, '최민기', 80, 185, 22, 'DF', 3),
(75, '박재현', 69, 177, 21, 'MF', 3),
(76, '박용희', 83, 190, 23, 'DF', 3),
(77, '한태희', 71, 179, 33, 'MF', 3),
(78, '홍철', 74, 176, 32, 'DF', 3),
(79, '손승우', 65, 172, 24, 'DF', 3),
(80, '윤태민', 76, 180, 24, 'DF', 3),
(81, '김희승', 69, 178, 24, 'MF', 3),
(82, '이종훈', 66, 174, 20, 'MF', 3),
(83, '배수민', 84, 185, 21, 'DF', 3),
(84, '박재혁', 73, 180, 22, 'FW', 3),
(85, '신한결', 78, 183, 23, 'DF', 3),
(86, '정윤성', 71, 175, 19, 'MF', 3),
(87, '유지호', 70, 177, 24, 'MF', 3),
(88, '김리찬', 72, 179, 19, 'MF', 3),
(89, '한지윤', 75, 183, 19, 'DF', 3),
(90, '조진우', 81, 190, 23, 'GK', 3),
(91, '페냐', 74, 176, 26, 'MF', 3),
(92, '이용래', 76, 183, 36, 'MF', 3),
(93, '바셀루스', 80, 187, 30, 'FW', 3);


INSERT INTO Player(PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(94, '이창근', 75, 186, 30, 'GK', 4),
(95, '서영재', 71, 182, 28, 'DF', 4),
(96, '김민덕', 78, 183, 27, 'DF', 4),
(97, '김현우', 74, 183, 25, 'DF', 4),
(98, '임덕근', 77, 183, 23, 'DF', 4),
(99, '임은수', 70, 181, 27, 'MF', 4),
(100, '마사', 68, 180, 28, 'FW', 4),
(101, '주세종', 67, 174, 33, 'MF', 4),
(102, '유강현', 75, 186, 27, 'FW', 4),
(103, '김인균', 66, 173, 26, 'MF', 4),
(104, '전병관', 72, 178, 22, 'FW', 4),
(105, '김영욱', 70, 177, 32, 'MF', 4),
(106, '변준수', 82, 190, 23, 'DF', 4),
(107, '김경환', 73, 180, 20, 'MF', 4),
(108, '이현식', 66, 175, 28, 'MF', 4),
(109, '신상은', 72, 185, 25, 'FW', 4),
(110, '조유민', 79, 182, 27, 'DF', 4),
(111, '오재석', 74, 178, 34, 'DF', 4),
(112, '정산', 86, 191, 35, 'GK', 4),
(113, '배서준', 67, 173, 20, 'DF', 4),
(114, '이준서', 82, 185, 26, 'GK', 4),
(115, '김지훈', 60, 175, 24, 'DF', 4),
(116, '이종현', 71, 176, 27, 'DF', 4),
(117, '티아고', 75, 188, 30, 'FW', 4),
(118, '김도윤', 66, 176, 22, 'MF', 4),
(119, '이은재', 71, 178, 21, 'MF', 4),
(120, '임유석', 83, 190, 23, 'DF', 4),
(121, '김태현', 74, 182, 21, 'DF', 4),
(122, '최재현', 80, 184, 30, 'DF', 4),
(123, '정강민', 67, 175, 19, 'MF', 4),
(124, '안태윤', 78, 186, 23, 'GK', 4),
(125, '정진우', 80, 188, 19, 'MF', 4),
(126, '유선우', 67, 180, 20, 'FW', 4),
(127, '이동원', 66, 180, 22, 'FW', 4),
(128, '정원식', 82, 185, 22, 'DF', 4),
(129, '배상필', 84, 189, 22, 'GK', 4),
(130, '이한빈', 82, 186, 21, 'DF', 4),
(131, '정우빈', 66, 175, 23, 'FW', 4),
(132, '이선호', 68, 175, 21, 'DF', 4),
(133, '레안드로', 65, 178, 29, 'FW', 4),
(134, '강윤성', 65, 172, 27, 'DF', 4),
(135, '이선유', 70, 175, 23, 'FW', 4),
(136, '이진현', 69, 170, 27, 'MF', 4),
(137, '안톤', 76, 186, 26, 'DF', 4),
(138, '구텍', 78, 187, 29, 'FW', 4);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(139, '백종범', 85, 190, 22, 'GK', 5),
(140, '황현수', 80, 183, 28, 'DF', 5),
(141, '권완규', 80, 183, 32, 'DF', 5),
(142, '오스마르', 86, 192, 35, 'MF', 5),
(143, '기성용', 75, 189, 34, 'MF', 5),
(144, '나상호', 70, 173, 27, 'FW', 5),
(145, '이승모', 70, 185, 25, 'MF', 5),
(146, '김신진', 82, 186, 22, 'FW', 5),
(147, '지동원', 81, 188, 32, 'FW', 5),
(148, '강성진', 76, 178, 20, 'FW', 5),
(149, '고요한', 65, 170, 35, 'MF', 5),
(150, '임상협', 74, 180, 35, 'MF', 5),
(151, '김진야', 68, 177, 25, 'DF', 5),
(152, '황성민', 83, 188, 32, 'GK', 5),
(153, '김경민', 81, 186, 26, 'FW', 5),
(154, '김현덕', 75, 183, 19, 'DF', 5),
(155, '최철원', 87, 194, 29, 'GK', 5),
(156, '이시영', 65, 173, 26, 'DF', 5),
(157, '서주환', 79, 190, 24, 'GK', 5),
(158, '정현철', 72, 187, 30, 'MF', 5),
(159, '비욘 존슨', 82, 196, 32, 'FW', 5),
(160, '팔로세비치', 70, 180, 30, 'MF', 5),
(161, '김윤겸', 66, 172, 19, 'MF', 5),
(162, '김주성', 76, 186, 22, 'DF', 5),
(163, '서재민', 73, 178, 20, 'MF', 5),
(164, '조영광', 67, 173, 19, 'DF', 5),
(165, '백상훈', 62, 173, 21, 'MF', 5),
(166, '안재민', 67, 176, 20, 'DF', 5),
(167, '손승범', 65, 180, 19, 'FW', 5),
(168, '이지석', 67, 182, 19, 'DF', 5),
(169, '박성훈', 72, 183, 20, 'DF', 5),
(170, '박장한결', 64, 176, 19, 'MF', 5),
(171, '한승규', 63, 173, 27, 'MF', 5),
(172, '이승준', 61, 170, 19, 'MF', 5),
(173, '김성민', 73, 180, 22, 'MF', 5),
(174, '황도윤', 73, 176, 20, 'MF', 5),
(175, '이태석', 61, 174, 21, 'DF', 5),
(176, '일류첸코', 82, 189, 33, 'FW', 5),
(177, '강상희', 73, 180, 25, 'DF', 5),
(178, '윌리안', 62, 170, 29, 'FW', 5),
(179, '박수일', 68, 178, 27, 'DF', 5),
(180, '아이에쉬', 72, 180, 28, 'FW', 5),
(181, '조영욱', 73, 181, 24, 'FW', 5);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(182, '장호익', 62, 173, 30, 'DF', 6),
(183, '불투이스', 78, 192, 33, 'DF', 6),
(184, '한호강', 80, 186, 30, 'DF', 6),
(185, '한석종', 72, 184, 31, 'MF', 6),
(186, '고승범', 70, 173, 29, 'MF', 6),
(187, '최성근', 73, 183, 32, 'MF', 6),
(188, '안병준', 75, 183, 33, 'FW', 6),
(189, '정승원', 68, 173, 26, 'MF', 6),
(190, '김태환', 74, 174, 23, 'DF', 6),
(191, '김보경', 72, 176, 34, 'MF', 6),
(192, '전진우', 74, 181, 24, 'FW', 6),
(193, '고명석', 90, 189, 28, 'DF', 6),
(194, '이종성', 72, 187, 31, 'MF', 6),
(195, '김경중', 69, 179, 32, 'FW', 6),
(196, '아코스티', 76, 178, 33, 'FW', 6),
(197, '강태원', 68, 175, 23, 'MF', 6),
(198, '박희준', 80, 191, 22, 'FW', 6),
(199, '양형모', 84, 185, 32, 'GK', 6),
(200, '권창훈', 66, 174, 29, 'MF', 6),
(201, '이기제', 68, 175, 32, 'DF', 6),
(202, '허동호', 75, 181, 23, 'MF', 6),
(203, '장석환', 70, 178, 19, 'DF', 6),
(204, '염기훈', 80, 182, 40, 'MF', 6),
(205, '이규석', 77, 182, 22, 'DF', 6),
(206, '이상민', 73, 175, 19, 'FW', 6),
(207, '진현태', 70, 178, 22, 'MF', 6),
(208, '이성주', 85, 192, 25, 'GK', 6),
(209, '서동한', 66, 172, 22, 'FW', 6),
(210, '박대원', 76, 178, 25, 'DF', 6),
(211, '박지민', 88, 189, 24, 'GK', 6),
(212, '명준재', 68, 178, 29, 'MF', 6),
(213, '김주찬', 71, 174, 19, 'FW', 6),
(214, '뮬리치', 84, 203, 29, 'FW', 6),
(215, '웨릭 포포', 88, 190, 22, 'FW', 6),
(216, '김주원', 78, 185, 32, 'DF', 6),
(217, '손호준', 65, 175, 21, 'DF', 6),
(218, '카즈키', 65, 173, 29, 'MF', 6),
(219, '유제호', 72, 178, 23, 'MF', 6),
(220, '바사니', 80, 187, 26, 'FW', 6),
(221, '안찬기', 80, 187, 26, 'GK', 6),
(222, '고무열', 75, 187, 33, 'FW', 6),
(223, '윤서호', 72, 176, 25, 'DF', 6),
(224, '고종현', 88, 191, 18, 'DF', 6),
(225, '곽성훈', 84, 190, 18, 'DF', 6),
(226, '김성주', 63, 168, 17, 'MF', 6),
(227, '박승수', 71, 182, 17, 'MF', 6),
(228, '임현섭', 73, 184, 18, 'MF', 6);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(229, '박배종', 78, 185, 34, 'GK', 7),
(230, '정동호', 68, 174, 33, 'DF', 7),
(231, '박철우', 65, 176, 26, 'MF', 7),
(232, '잭슨', 83, 196, 28, 'DF', 7),
(233, '김현', 87, 190, 30, 'FW', 7),
(234, '정재용', 80, 188, 33, 'MF', 7),
(235, '로페즈', 78, 185, 33, 'FW', 7),
(236, '이승우', 60, 170, 26, 'FW', 7),
(237, '오인표', 63, 177, 26, 'DF', 7),
(238, '윤빛가람', 71, 178, 33, 'MF', 7),
(239, '정재윤', 75, 180, 21, 'MF', 7),
(240, '노동건', 88, 190, 32, 'GK', 7),
(241, '김규형', 63, 168, 24, 'MF', 7),
(242, '황순민', 65, 177, 33, 'MF', 7),
(243, '최보경', 86, 184, 32, 'DF', 7),
(244, '이광혁', 65, 167, 28, 'MF', 7),
(245, '김주엽', 76, 180, 23, 'DF', 7),
(246, '우고 고메스', 80, 187, 28, 'DF', 7),
(247, '이태섭', 70, 177, 23, 'DF', 7),
(248, '이영재', 60, 172, 29, 'MF', 7),
(249, '장재웅', 70, 176, 22, 'FW', 7),
(250, '신세계', 73, 178, 33, 'DF', 7),
(25, '이범영', 93, 197, 34, 'GK', 7),
(252, '곽동준', 68, 176, 23, 'DF', 7),
(253, '김예성', 70, 177, 22, 'MF', 7),
(254, '서승우', 80, 188, 21, 'MF', 7),
(255, '바우테르손', 80, 186, 26, 'FW', 7),
(256, '김선민', 65, 167, 32, 'MF', 7),
(257, '이재훈', 85, 190, 19, 'GK', 7),
(258, '박병현', 65, 176, 30, 'DF', 7),
(259, '김도윤', 62, 171, 19, 'MF', 7),
(260, '정은우', 65, 172, 20, 'FW', 7),
(261, '이용', 76, 180, 37, 'DF', 7),
(262, '안치우', 72, 180, 19, 'MF', 7),
(263, '김재현', 73, 179, 20, 'FW', 7),
(264, '강민성', 73, 180, 19, 'FW', 7);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(265, '조수혁', 83, 188, 36, 'GK', 8),
(266, '장시영', 69, 174, 21, 'DF', 8),
(267, '임종은', 88, 192, 33, 'DF', 8),
(268, '보야니치', 74, 182, 29, 'MF', 8),
(269, '마틴 아담', 87, 190, 29, 'FW', 8),
(270, '바코', 74, 174, 30, 'MF', 8),
(271, '엄원상', 63, 171, 24, 'MF', 8),
(272, '이명재', 68, 182, 30, 'DF', 8),
(273, '이동경', 72, 176, 26, 'MF', 8),
(274, '정승현', 82, 188, 29, 'DF', 8),
(275, '김성준', 68, 174, 35, 'MF', 8),
(276, '루빅손', 75, 182, 30, 'FW', 8),
(277, '주민규', 83, 183, 33, 'FW', 8),
(278, '김영권', 78, 185, 33, 'DF', 8),
(279, '조현우', 75, 189, 32, 'GK', 8),
(280, '김민혁', 71, 183, 31, 'MF', 8),
(281, '김태환', 72, 177, 34, 'DF', 8),
(282, '이규성', 68, 174, 29, 'MF', 8),
(283, '조현택', 65, 182, 22, 'DF', 8),
(284, '이청용', 70, 180, 35, 'MF', 8),
(285, '설현빈', 78, 190, 22, 'GK', 8),
(286, '황재환', 60, 170, 22, 'MF', 8),
(287, '강윤구', 73, 175, 21, 'MF', 8),
(288, '아타루', 68, 175, 31, 'MF', 8),
(289, '이재욱', 65, 170, 22, 'DF', 8),
(290, '김기희', 80, 188, 34, 'DF', 8),
(291, '설영우', 72, 180, 25, 'DF', 8),
(292, '민동환', 78, 187, 22, 'GK', 8),
(293, '박주영', 75, 182, 38, 'FW', 8),
(294, '김지현', 79, 185, 27, 'FW', 8);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(295, '김동헌', 80, 190, 27, 'GK', 9),
(296, '이태희', 85, 192, 29, 'GK', 9),
(297, '민성준', 79, 187, 24, 'GK', 9),
(298, '김유성', 83, 188, 20, 'GK', 9),
(299, '김연수', 75, 180, 23, 'DF', 9),
(300, '오반석', 81, 187, 35, 'DF', 9),
(301, '정동윤', 78, 182, 33, 'DF', 9),
(302, '임종진', 74, 176, 26, 'DF', 9),
(303, '김준엽', 73, 178, 24, 'DF', 9),
(304, '델브리지', 84, 193, 31, 'DF', 9),
(305, '김건희', 76, 181, 25, 'DF', 9),
(306, '김동민', 75, 180, 26, 'DF', 9),
(307, '권한진', 78, 187, 33, 'DF', 9),
(308, '이명주', 70, 175, 33, 'MF', 9),
(309, '문지환', 74, 178, 25, 'MF', 9),
(310, '김도혁', 73, 177, 28, 'MF', 9),
(311, '신진호', 75, 180, 34, 'MF', 9),
(312, '이동수', 68, 173, 22, 'MF', 9),
(313, '여름', 70, 175, 31, 'MF', 9),
(314, '지언학', 70, 175, 25, 'MF', 9),
(315, '박현빈', 72, 178, 22, 'MF', 9),
(316, '민경현', 65, 168, 21, 'MF', 9),
(317, '최준기', 74, 179, 23, 'MF', 9),
(318, '김현석', 68, 172, 23, 'MF', 9),
(319, '홍시후', 72, 175, 22, 'MF', 9),
(320, '박진홍', 77, 180, 25, 'MF', 9),
(321, '김세훈', 70, 175, 24, 'MF', 9),
(322, '에르난데스', 76, 179, 28, 'FW', 9),
(323, '제로소', 81, 184, 26, 'FW', 9),
(324, '송시우', 70, 175, 30, 'FW', 9),
(325, '김민석', 68, 173, 23, 'FW', 9),
(326, '김보섭', 70, 176, 25, 'FW', 9),
(327, '하동호', 78, 185, 22, 'FW', 9),
(328, '음포쿠', 75, 178, 31, 'FW', 9),
(329, '박승호', 73, 177, 26, 'FW', 9),
(330, '천성훈', 72, 175, 23, 'FW', 9);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(331, '이범수', 85, 190, 34, 'GK', 10),
(332, '노윤상', 79, 190, 22, 'DF', 10),
(333, '박진섭', 75, 182, 28, 'MF', 10),
(334, '윤영선', 78, 185, 36, 'DF', 10),
(335, '최보경', 79, 184, 36, 'DF', 10),
(336, '한교원', 73, 182, 34, 'MF', 10),
(337, '백승호', 78, 180, 27, 'MF', 10),
(338, '구스타보', 76, 189, 30, 'FW', 10),
(339, '조규성', 82, 188, 26, 'FW', 10),
(340, '바로우', 60, 177, 32, 'MF', 10),
(341, '김보경', 73, 178, 35, 'MF', 10),
(342, '이승기', 67, 177, 36, 'MF', 10),
(343, '구자룡', 75, 186, 32, 'DF', 10),
(344, '이근호', 85, 185, 28, 'FW', 10),
(345, '송민규', 72, 179, 25, 'FW', 10),
(346, '홍장우', 70, 175, 22, 'MF', 10),
(347, '김진수', 69, 177, 32, 'DF', 10),
(348, '최철순', 70, 173, 37, 'DF', 10),
(349, '홍정호', 82, 187, 35, 'DF', 10),
(350, '문선민', 70, 172, 32, 'FW', 10),
(351, '맹성웅', 72, 180, 26, 'MF', 10),
(352, '류재문', 72, 184, 30, 'MF', 10),
(353, '김준홍', 88, 190, 21, 'GK', 10),
(354, '송범근', 88, 194, 26, 'GK', 10),
(355, '배재익', 70, 175, 23, 'FW', 10),
(356, '박진성', 76, 178, 23, 'DF', 10),
(357, '장윤호', 68, 178, 28, 'MF', 10),
(358, '강영석', 70, 172, 22, 'MF', 10),
(359, '강상윤', 66, 170, 20, 'MF', 10),
(360, '박준범', 78, 183, 23, 'FW', 10),
(361, '박성현', 72, 182, 23, 'DF', 10),
(362, '이우연', 83, 188, 21, 'DF', 10),
(363, '명세진', 72, 176, 23, 'MF', 10),
(364, '김태현', 75, 180, 23, 'MF', 10),
(365, '이준호', 84, 186, 22, 'FW', 10),
(366, '이성민', 83, 187, 24, 'DF', 10),
(367, '박채준', 66, 170, 21, 'FW', 10),
(368, '최현웅', 76, 188, 21, 'DF', 10),
(369, '전지완', 85, 189, 20, 'GK', 10),
(370, '박창우', 69, 178, 21, 'DF', 10),
(371, '이윤권', 68, 174, 24, 'MF', 10),
(372, '박규민', 71, 180, 23, 'FW', 10),
(373, '김문환', 67, 172, 29, 'DF', 10),
(374, '김진규', 68, 177, 27, 'MF', 10);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(375, '김동준', 88, 187, 29, 'GK', 11),
(376, '안태현', 67, 176, 30, 'MF', 11),
(377, '연제운', 78, 185, 29, 'DF', 11),
(378, '송주훈', 83, 190, 30, 'DF', 11),
(379, '최영준', 76, 181, 33, 'MF', 11),
(380, '구자철', 78, 183, 35, 'MF', 11),
(381, '김건웅', 81, 185, 26, 'MF', 11),
(382, '유리 조나탄', 78, 185, 26, 'FW', 11),
(383, '헤이스', 73, 173, 31, 'FW', 11),
(384, '김승섭', 67, 177, 28, 'FW', 11),
(385, '정운', 73, 180, 35, 'DF', 11),
(386, '서진수', 71, 183, 24, 'MF', 11),
(387, '조나탄 링', 72, 183, 33, 'MF', 11),
(388, '임동혁', 86, 190, 31, 'FW', 11),
(389, '김주공', 73, 180, 28, 'FW', 11),
(390, '김오규', 77, 183, 35, 'DF', 11),
(391, '김형근', 78, 188, 30, 'GK', 11),
(392, '임준섭', 80, 194, 21, 'GK', 11),
(393, '이기혁', 76, 184, 24, 'MF', 11),
(394, '한종무', 70, 179, 21, 'MF', 11),
(395, '임채민', 82, 188, 34, 'DF', 11),
(396, '전성진', 66, 176, 23, 'MF', 11),
(397, '임창우', 72, 184, 32, 'DF', 11),
(398, '김대환', 67, 172, 20, 'DF', 11),
(399, '김봉수', 78, 183, 25, 'MF', 11),
(400, '이주용', 78, 180, 32, 'DF', 11),
(401, '권순호', 72, 178, 21, 'MF', 11),
(402, '곽승민', 80, 186, 20, 'DF', 11),
(403, '김근배', 80, 187, 38, 'GK', 11),
(404, '박원재', 66, 176, 30, 'DF', 11),
(405, '홍준호', 77, 190, 31, 'DF', 11);

INSERT INTO Player (PlayerId, Name, Weight, Height, Age, Position, TeamId) VALUES
(406, '윤평국', 88, 189, 32, 'GK', 12),
(407, '심상민', 78, 172, 31, 'DF', 12),
(408, '김용환', 67, 175, 31, 'DF', 12),
(409, '그랜트', 82, 191, 30, 'DF', 12),
(410, '김종우', 70, 181, 30, 'MF', 12),
(411, '김인성', 74, 180, 35, 'FW', 12),
(412, '오베르단', 70, 175, 28, 'MF', 12),
(413, '제카', 83, 192, 26, 'FW', 12),
(414, '백성동', 66, 167, 32, 'MF', 12),
(415, '고영준', 69, 168, 23, 'MF', 12),
(416, '김승대', 64, 175, 33, 'FW', 12),
(417, '신원철', 70, 175, 23, 'DF', 12),
(418, '박승욱', 78, 184, 27, 'DF', 12),
(419, '한찬희', 75, 185, 26, 'MF', 12),
(420, '신광훈', 73, 178, 37, 'DF', 12),
(421, '강현제', 75, 183, 21, 'FW', 12),
(422, '윤민호', 64, 170, 25, 'MF', 12),
(423, '박찬용', 81, 186, 28, 'DF', 12),
(424, '황인재', 80, 188, 30, 'GK', 12),
(425, '박건우', 70, 171, 23, 'DF', 12),
(426, '조재훈', 71, 180, 22, 'MF', 12),
(427, '정재희', 70, 174, 31, 'FW', 12),
(428, '김정현', 73, 183, 20, 'MF', 12),
(429, '박형우', 68, 173, 21, 'FW', 12),
(430, '윤재운', 77, 177, 21, 'FW', 12),
(431, '이승환', 78, 186, 21, 'GK', 12),
(432, '이호재', 84, 192, 23, 'FW', 12),
(433, '이규백', 83, 185, 20, 'DF', 12),
(434, '홍윤상', 68, 178, 21, 'MF', 12),
(435, '조성훈', 85, 189, 26, 'GK', 12),
(436, '송한록', 76, 182, 21, 'MF', 12),
(437, '하창래', 82, 188, 30, 'DF', 12),
(438, '최현웅', 76, 188, 21, 'DF', 12),
(439, '김준호', 70, 182, 22, 'MF', 12),
(440, '완델손', 60, 172, 34, 'FW', 12),
(441, '김규표', 70, 176, 25, 'MF', 12),
(442, '양태렬', 73, 179, 29, 'MF', 12);

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




