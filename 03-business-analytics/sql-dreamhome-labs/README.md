# SQL — DreamHome Database Labs

**137 queries · aggregation, multi-table joins, set operations, subqueries, DDL**

Four progressive lab assignments against the DreamHome property-rental database (the standard
Connolly & Begg teaching schema: branches, staff, property owners, properties, clients, viewings,
and leases). Written for BAN-0301, Hult International Business School.

Each lab is my own `.sql` file, runnable top to bottom against a DreamHome SQLite database.

## Progression

| Lab | Statements | Focus | Techniques |
|---|---|---|---|
| [Lab 2](lab2_queries.sql) | 32 | Aggregation and grouping | `COUNT`, `SUM`, `AVG`, `MAX`, `MIN`, `GROUP BY`, `HAVING`, `ORDER BY` |
| [Lab 3](lab3_queries.sql) | 33 | Multi-table joins and set operations | `INNER JOIN`, `LEFT JOIN`, `UNION`, aggregation across joins |
| [Lab 4](lab4_queries.sql) | 43 | Complex retrieval and sorting | layered joins, multi-key `ORDER BY`, grouped aggregates |
| [Lab 5](lab5_queries.sql) | 29 | Subqueries and DDL | `IN`, `EXISTS`, correlated subqueries, `CREATE TABLE` |

## What the progression shows

The sequence moves deliberately from single-table aggregation to correlated subqueries and schema
definition. Two things are worth noting in the later labs:

**`HAVING` vs. `WHERE`.** Lab 2 uses `HAVING` seven times — filtering on an aggregate after
grouping, rather than filtering rows before it. Getting that distinction wrong is the most common
way an aggregate query returns a plausible but incorrect answer.

**`LEFT JOIN` where it matters.** Lab 3 uses `LEFT JOIN` twelve times. In a rental schema the
rows that *don't* match are usually the interesting ones — properties with no viewings, staff
with no assigned properties, owners with no active leases. An inner join silently drops exactly
the records a property manager would want to see.

## Skills
Aggregation and grouping · inner/outer joins across 5+ tables · set operations · correlated and
uncorrelated subqueries · DDL · relational schema comprehension
