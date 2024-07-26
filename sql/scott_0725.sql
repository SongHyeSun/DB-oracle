SELECT COUNT(*) FROM board;

SELECT num, writer, subject, ref, re_step, re_level
FROM board
WHERE ref=30
ORDER BY ref DESC,re_step;

SELECT ROWNUM, num, writer, subject, ref, re_step, re_level
FROM board
WHERE ROWNUM BETWEEN 1 AND 10
AND ref>30
ORDER BY ref DESC,re_step;

--ROWNUM, num, writer, subject, ref, re_step, re_level
SELECT *
FROM (
--    a에서 선택된 모든 것
    SELECT ROWNUM rn, a.*
    FROM
        (
        SELECT *
        FROM board
        ORDER BY ref DESC, re_step
        ) a
    )
WHERE rn BETWEEN 20 AND 30;


    SELECT ROWNUM rn, a.*
    FROM
        (
        SELECT *
        FROM board
        ORDER BY ref DESC, re_step
        ) a
    WHERE rownum BETWEEN 10 AND 20;
