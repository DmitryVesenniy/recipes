 
sudo pacman -S postgis

-- Enable PostGIS (as of 3.0 contains just geometry/geography)
CREATE EXTENSION postgis;
-- enable raster support (for 3+)
CREATE EXTENSION postgis_raster;
-- Enable Topology
CREATE EXTENSION postgis_topology;
-- Enable PostGIS Advanced 3D
-- and other geoprocessing algorithms
-- sfcgal not available with all distributions
CREATE EXTENSION postgis_sfcgal;
-- fuzzy matching needed for Tiger
CREATE EXTENSION fuzzystrmatch;
-- rule based standardizer
CREATE EXTENSION address_standardizer;
-- example rule data set
CREATE EXTENSION address_standardizer_data_us;
-- Enable US Tiger Geocoder
CREATE EXTENSION postgis_tiger_geocoder;

# создать таблицу
CREATE TABLE IF NOT EXISTS object_on_road (
    Id SERIAL PRIMARY KEY,
    oor_type_id INTEGER,
    property_id INTEGER,
    FOREIGN KEY (oor_type_id) REFERENCES oor_type (Id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE,
    FOREIGN KEY (property_id) REFERENCES item (Id) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE CASCADE
);
# добавить колонку point
SELECT AddGeometryColumn('', 'object_on_road', 'point', 4326, 'MULTIPOINT', 2);

# !!создать таблицу добавить геоиндексы
CREATE TABLE IF NOT EXISTS <tablename> (
    id SERIAL PRIMARY KEY,
    geo_type VARCHAR(50),
    description VARCHAR(500),
    sort_order INTEGER,
    color_code VARCHAR(10),
    geo_column geography
);

CREATE INDEX <tablename>_gix ON <tablename> USING GIST ( geo_column ); 
CREATE INDEX <tablename>_oid_idx ON <tablename> (id);

# пример вставки
INSERT INTO public.object_on_road(
	oor_type_id, point)
	VALUES (1, 'SRID=4326;MULTIPOINT(86.01656094 55.450927 83, 86.016561 55.45093 83.5)');
	
# пример запроса
SELECT id, oor_type_id, property_id, point, ST_AsGeoJSON(point)::json
	FROM public.object_on_road;
