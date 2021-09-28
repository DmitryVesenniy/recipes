sudo apt install postgis postgresql-xx-postgis-x
# sudo apt install postgis postgresql-13-postgis-3

// опустить высоту из точки на Linestring
SELECT
    ST_ClosestPoint(segment_centerline.shape::geometry, ?::geography::geometry ) AS point
    FROM segment_centerline 
    WHERE segment_id = ?
		
		
// определение на какой стороне находится точка относительно Linestring
SELECT (ST_Azimuth(ST_StartPoint(h.vec), ST_EndPoint(h.vec)) - ST_Azimuth(ST_StartPoint(h.seg), ST_EndPoint(h.seg))) side
    FROM (
        SELECT 
            ST_MakeLine(cp.point, ?::geography::geometry) vec,
            ST_MakeLine(cp.point, 
                ST_LineInterpolatePoint(
                    cp.shape::geography::geometry, 
                    ST_LineLocatePoint(cp.shape::geometry, cp.point) * 1.01
                )
            ) seg
            FROM (
                SELECT
                    ST_ClosestPoint(segment_centerline.shape::geometry, ?::geography::geometry ) AS point,
                    shape
                    FROM segment_centerline 
                    WHERE segment_id = ?
                ) as cp
        ) as h
        

// получаем геометрию из квадрата
SELECT
	st_intersection( -- рассчитываем пересечение
	shape,
	'POLYGON((85.18798828125 55.441479359140686,90.46142578125001 55.441479359140686,90.46142578125001 53.88653517501989,85.18798828125 53.88653517501989,85.18798828125 55.441479359140686))'::geography::geometry
	) as geom

FROM segment_centerline09 -- WHERE st_intersects(shape, ST_GeomFromEWKT('POLYGON((85.18798828125 55.441479359140686,90.46142578125001 55.441479359140686,90.46142578125001 53.886535
