"""Execute the synthetic SQLite troubleshooting lab; no network connections."""
from pathlib import Path
import sqlite3
ROOT = Path(__file__).resolve().parents[1]
conn = sqlite3.connect(':memory:')
for file in ('schema/01_schema.sql','schema/02_seed.sql'):
    conn.executescript((ROOT/file).read_text(encoding='utf-8'))
for file in sorted((ROOT/'queries').glob('*.sql')):
    print(f'\n=== {file.name} ===')
    # sqlite3.complete_statement handles multiline statements and comments.
    buffer = ''
    for line in file.read_text(encoding='utf-8').splitlines(keepends=True):
        buffer += line
        if sqlite3.complete_statement(buffer):
            stmt = buffer.strip()
            if stmt and any(s.strip() and not s.lstrip().startswith('--') for s in stmt.splitlines()):
                cursor = conn.execute(stmt)
                rows = cursor.fetchall()
                print(f'{len(rows)} rows | {cursor.description[0][0] if cursor.description else "command"}')
                for row in rows[:5]: print('  ',row)
            buffer = ''
    if buffer.strip() and not buffer.strip().startswith('--'):
        raise ValueError(f'Incomplete SQL in {file}')
conn.close()
