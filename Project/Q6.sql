SELECT name
FROM scoop 
WHERE costinCents = (SELECT MAX(costinCents)
from scoop);