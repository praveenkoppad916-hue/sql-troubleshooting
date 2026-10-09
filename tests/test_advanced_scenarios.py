"""Deterministic checks against synthetic SQLite lab data."""
import sqlite3
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]

class AdvancedScenariosTests(unittest.TestCase):
    def setUp(self):
        self.db = sqlite3.connect(':memory:')
        for name in ('01_schema.sql','02_seed.sql','03_support_cases.sql','04_support_seed.sql'):
            self.db.executescript((ROOT/'schema'/name).read_text(encoding='utf-8'))

    def tearDown(self):
        self.db.close()

    def query(self, name):
        return self.db.execute((ROOT/'queries'/name).read_text(encoding='utf-8')).fetchall()

    def test_failed_payments(self):
        rows = self.query('04_failed_payment_investigation.sql')
        self.assertEqual([r[0] for r in rows], [1002,1006,1009])

    def test_duplicate_candidates(self):
        rows = self.query('05_duplicate_detection.sql')
        self.assertEqual(len(rows), 1)
        self.assertEqual(rows[0][1], 'ORD-103')
        self.assertEqual(rows[0][4], 2)

    def test_priority_incidents(self):
        rows = self.query('06_p1_p2_incident_analysis.sql')
        self.assertEqual(len(rows), 4)
        self.assertEqual(sum(r[1]=='P1' for r in rows), 2)

    def test_sla_breaches(self):
        rows = self.query('08_sla_breach_analysis.sql')
        breached = [r[0] for r in rows if r[-1]=='BREACHED']
        self.assertEqual(breached, [502,504])

    def test_index_is_available(self):
        indexes = [r[1] for r in self.db.execute('PRAGMA index_list(payments)')]
        self.assertIn('idx_payments_status_created', indexes)

    def test_all_sql_files_execute(self):
        for name in sorted((ROOT/'queries').glob('*.sql')):
            with self.subTest(name=name.name):
                self.db.executescript(name.read_text(encoding='utf-8'))

if __name__ == '__main__':
    unittest.main()
