# PART 1: Snapshot - Which orders changed from week 3 to week 4? 

- Answer: These are the orders that changed:

0e9b8ee9-ad0a-42f4-a778-e1dd3e6f6c51
841074bf-571a-43a6-963c-ba7cbdb26c85
df91aa85-bfc7-4c31-93ef-4cee8d00a343


 - Method:     
 ```            
select order_id
from DEV_DB.DBT_CRISTINABLANCOAUDIBENEDE.SNAPSHOT_ORDERS
where dbt_valid_to::date = '2023-02-05'
```


# PART 2: Modelling Challenge
- Answer: I added in fct_user_sessions two metrics
1) CR1: Conversion from Page views to Adding to Cart = 52,69%
   CR2: Conversion from Adding to Cart to Checkout = 36,61%

2) Rates: Particular event over all 
   Page View Rate = 58,14%
   Add to Cart Rate = 30,64%
   Checkout Rate = 11,21%


# PART 3: Reflection: if your organization is using dbt, what are 1-2 things you might do differently / recommend to your organization based on learning from this course?
- Answer: 
1) Macros: we want to identify logic that is repeated unnecessariyl over several models and use macros.
2) Test: use the test to ensure we can enhance our observability on the models and flag bad quality data as early as possible
3) Overall modelling: one of our roadmap items is to refactor the current facts and dims existing in our instance. The knowledge and practice gathered in the course will for sure give us hands-on knowledge to apply best practices for us