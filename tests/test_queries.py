import sqlite3
import unittest
from pathlib import Path
ROOT = Path(__file__).resolve().parents[1]
class PaymentLabTests(unittest.TestCase):
    def setUp(self):
        self.db=sqlite3.connect(':memory:')
        for f in ('schema/01_schema.sql','schema/02_seed.sql','schema/03_support_cases.sql','schema/04_support_seed.sql'):
            self.db.executescript((ROOT/f).read_text(encoding='utf-8'))
    def tearDown(self): self.db.close()
    def test_seed_count(self):
        self.assertEqual(self.db.execute('SELECT COUNT(*) FROM payments').fetchone()[0],10)
    def test_failed_payments(self):
        self.assertEqual(self.db.execute("SELECT COUNT(*) FROM payments WHERE status='FAILED'").fetchone()[0],3)
    def test_possible_duplicate_reference(self):
        result=self.db.execute('SELECT external_reference FROM payments GROUP BY merchant_id,external_reference,currency,amount_cents HAVING COUNT(*)>1').fetchall()
        self.assertEqual(result,[('ORD-103',)])
    def test_foreign_keys(self):
        self.assertEqual(self.db.execute('PRAGMA foreign_key_check').fetchall(),[])
    def test_investigation_queries(self):
        sql=(ROOT/'queries/02_incident_investigations.sql').read_text(encoding='utf-8')
        self.db.executescript(sql)
if __name__=='__main__': unittest.main()
