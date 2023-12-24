with dim_date__generate as (
  select 
   *
  from 
    unnest(generate_date_array('2010-01-01','2030-12-31', interval 1 day)) as date
)
select 
 *
 , format_date('%A', date) as day_of_week
 , format_date('%a', date) as day_of_week_short
 , format_date('%B', date) as month
 , extract(year from date) as year_number
from dim_date__generate