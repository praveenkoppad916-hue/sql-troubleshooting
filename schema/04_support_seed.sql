-- All examples use a fixed 2026-01-10 UTC-like synthetic timeline.
INSERT INTO sla_targets VALUES ('P1', 5), ('P2', 15), ('P3', 60);
INSERT INTO support_cases VALUES
 (501,1002,'P1','2026-01-10 09:05:00','2026-01-10 09:08:00','2026-01-10 09:45:00','RESOLVED','Bank timeout spike'),
 (502,1006,'P2','2026-01-10 09:15:00','2026-01-10 09:37:00','2026-01-10 10:10:00','RESOLVED','Invalid authentication token'),
 (503,1008,'P2','2026-01-10 09:30:00','2026-01-10 09:40:00',NULL,'OPEN','Payment awaiting gateway callback'),
 (504,1009,'P1','2026-01-10 09:35:00','2026-01-10 09:43:00',NULL,'OPEN','Second upstream timeout'),
 (505,1003,'P3','2026-01-10 09:10:00','2026-01-10 09:30:00','2026-01-10 09:55:00','RESOLVED','Pending callback review');
