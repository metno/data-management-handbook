#!/usr/bin/env python
from datetime import datetime, timezone
import sys
import netCDF4
from uuid import uuid4


with netCDF4.Dataset(sys.argv[1], "a") as f:
    f.id = str(uuid4())
    f.naming_authority = "no.met"

    f.creator_institution = "Norwegian Meteorological Institute"
    f.delncattr("creator_url")  # not needed, replaced by publisher_url

    f.institution = "Norwegian Meteorological Institute"
    f.institution_short_name = 'MET Norway'

    f.title = "U component of wind speed at ten meter height (example)"
    f.title_no = "U-komponent av vindhastighet i ti meters høyde (eksempel)"
    f.summary = (
        "Test dataset to demonstrate how to document a netcdf-cf file"
        " containing wind speed at 10 meter height from a MEPS 2.5km "
        "dataset with ACDD attributes.")
    f.summary_no = (
        "Test datasett for å demonstrere hvordan du dokumenterer en "
        "netcdf-cf-fil som inneholder vindhastighet i 10 meters "
        "høyde fra et MEPS 2,5 km datasett med ACDD-attributter.")
    f.references = "https://github.com/metno/NWPdocs/wiki (Users guide)"

    f.keywords = (
        "GCMDSK:Earth Science > Atmosphere > Atmospheric winds, "
        "GEMET:Meteorological geographical features, "
        "GEMET:Atmospheric conditions, "
        "GEMET:Oceanographic geographical features, "
        "NORTHEMES:Weather and climate")
    f.keywords_vocabulary = (
        "GCMDSK:GCMD Science Keywords:https://gcmd.earthdata.nasa.gov"
        "/kms/concepts/concept_scheme/sciencekeywords, "
        "GEMET:INSPIRE themes:https://inspire.ec.europa.eu/theme, "
        "NORTHEMES:GeoNorge Themes:https://register.geonorge.no/"
        "subregister/metadata-kodelister/kartverket/nasjonal-"
        "temainndeling")

    # Set ISO topic category
    f.iso_topic_category = "climatologyMeteorologyAtmosphere"

    # Specify the type of discrete sampling geometry 
    # https://metno.github.io/data-management-handbook/#_climate_and_forecast_conventions_cf
    # https://cfconventions.org/Data/cf-conventions/cf-conventions-1.10/cf-conventions.html#_features_and_feature_types
    f.featureType = 'timeSeries'

    # Set the correct license
    f.license = "http://spdx.org/licenses/CC-BY-4.0(CC-BY-4.0)"

    f.publisher_name = "Norwegian Meteorological Institute"
    f.publisher_type = "institution"
    f.publisher_email = "csw-services@met.no"
    f.publisher_url = "https://www.met.no/"

    # Extract time_coverage_start from the time variable
    tstart = f.variables['time'][0]  # masked array
    tstart = int(tstart[~tstart.mask].data[0])
    tstart = datetime.fromtimestamp(tstart)
    # The time zone is utc (this can be seen from the metadata of the
    # time variable) and the time in isoformat is
    # 2023-02-01T10:00:00+00:00
    f.time_coverage_start = tstart.replace(tzinfo=timezone.utc).isoformat()

    # Extract time_coverage_end from the time variable
    tend = f.variables['time'][-1]  # masked array
    tend = int(tend[~tend.mask].data[0])
    tend = datetime.fromtimestamp(tend)
    # The time in isoformat is 2023-02-03T23:00:00+00:00
    f.time_coverage_end = tend.replace(tzinfo=timezone.utc).isoformat()

    # The date_created is in this case recorded in the history attribute
    # We have hardcoded it here for simplicity
    f.date_created = datetime.strptime("2023-02-01T11:30:05", "%Y-%m-%dT%H:%M:%S").replace(
        tzinfo=timezone.utc).isoformat()

    # Set the spatial representation (a MET ACDD extension)
    f.spatial_representation = 'grid'

    # Update the conventions attribute to the correct ones
    f.Conventions = 'CF-1.10, ACDD-1.3'
