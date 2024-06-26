import pandas as pd

# MISC
pd.read_csv()
pd.to_csv()
pd.shape
pd.head()
pd.info()
pd.describe()
df.isnull().sum()

# SELECTING
df['someCol']
df['someColumn'][0] # row 1
df[3][2]

# CREATE DATAFRAME
df = pd.DataFrame(data=data, columns=columns)

# ADDING ROW
new_row = {"name":"brian", "id":1}
df.append(new_row, ignore_index=True)

# iloc
# loc and iloc are row-first, column-second. This is the opposite of python. 
# to get a column with all rows:
df.iloc[:, 0]
# get frist 3 rows of column 0:
df.iloc[:3, 0]
# It's also possible to pass a list:
df.iloc[[0, 1, 2], 0]
# last five elements of the dataset (all columns):
df.iloc[-5:]

# loc
# get first value:
df.loc[0, 'country']
# selecting random columns:
df.loc[:, ['taster_name', 'taster_twitter_handle', 'points']]

# iloc indexes exclusively
# loc indexes inclusively

# Give the dataset an index:
df.set_index("title")    (assigns that column as the index)

# Select a single cell:
df.at[1, 'PRICE']

# Select certain only in column
df[df['col1'].apply(lambda x: isinstance(x, str))]


# CONDITIONALS
df.loc[df['country'] == 'Italy']
df.loc[(df['country'] == 'Italy') & (df['points'] >= 90)]
df.loc[df['country'].isin(['Italy', 'France'])]
# also use 'isnull' 'notnull'
df.loc[df['PRICE'] < 70, ['FRUITS', 'PRICE']]


# QUERYING
data.query('some_col == "some string" and col_2 != "some other string" ')
# Read as "or" in the values:
data.query('col == ("string 1", "sting 2") '))
# need to use back ticks for columns with more than one word !!


# ASSIGNMENT
# Assign constant to all rows:
df['critic'] = 'everyone'
# Assign with iterable:
df['index_backwards'] = range(len(df), 0, -1)


# SUMMARY FNs & MAPS
mean()
unique()
value_counts()    unique values and how often they occur 


# TRANSFORM
# just one column
# find div from mean:
df.points.map(lambda p: p - review_points_mean)


# whole DF
# apply() is for transforming a whole DF
def remean_points(row):
    row.points = row.points - review_points_mean
    return row
df.apply(remean_points, axis='columns')
# can also do axis='index' (need fn to transform each column in this case)
# or axis=1


# SIMPLE PANDAS MATH
# faster remean:
df.points - review_points_mean
# aggr column:
df.country + " - " + df.region_1


# GROUPING
# grouping creates a sliced DF
# double grouping with max of each: 
   df.groupby(['country', 'province']).apply(lambda df: df.loc[df.points.idxmax()])

# agg let's you run basic stats on multi-columns:
df.groupby(['country']).price.agg([len, min, max])

# after grouping, you'll need to scrape off the new indices: reset_index()


# SORTING
df.sort_values(by='len', ascending=False)
# sort by index:
    .sort_values(by='len', ascending=False)
df.sort_values(by=['multiple', 'columns']


# TYPES
# convert type:
    df.points.astype('float64')


# MISSING DATA
# replace NaN:
    df.region_2.fillna("Unknown")

# REPLACE 
df.taster_twitter_handle.replace("@kerinokeefe", "@kerino")
DataFrame.replace(to_replace=None, value=_NoDefault.no_default, *, inplace=False, limit=None, regex=False, method=_NoDefault.no_default)
## can replace many values with a dict
some_dict = {"orig": "new", "orig2": "new2"}
df["some_col"].replace(some_dict)

# RENAMING
df.rename(columns={'old': 'new'})
df.rename(index={0: 'firstEntry', 1: 'secondEntry'})
# you can also rename the name of the rows and columns axis
df.rename_axis("wines", axis='rows').rename_axis("fields", axis='columns')


# COMBINING
concat() #- combining 2 different files that have all the same fields
join() #- takes an "on" argument too
merge()
pd.merge(df1, df2, how='left', on='Fruits')

left = canadian_youtube.set_index(['title', 'trending_date'])
right = british_youtube.set_index(['title', 'trending_date'])
left.join(right, lsuffix='_CAN', rsuffix='_UK')


 # CLEANING
# for removing rows with empty cells:
    dropna()
# replace empty cells:
    fillna()
drop_duplicates()
# remove col:
    df.drop('col_name', axis=0)

# cast new type:
    df[column].astype(int)   (must be all same type)
df = df.astype({"Fee": int, "Discount": float})
# otherwise use
df[column] = df[column].apply(lambda x: pd.to_numeric(x, errors = 'ignore'))

# check columns for certain type
df[column][df[column].apply(lambda x: isinstance(x, type))]

# Select certain only in column
df[df['col1'].apply(lambda x: isinstance(x, str))]


# PIVOT TABLE
df.pivot(index='foo', columns='bar', values='baz')
pivot() will error with a ValueError: Index contains duplicate entries, cannot reshape if the index/column pair is not unique. In this case, consider using pivot_table() which is a generalization of pivot that can handle duplicate values for one index/column pair.


# DATES
# Convert the string 'Date' column to datetime format
df['Date'] = pd.to_datetime(df['Date'])

# Reformat the 'Date' column to "MM/DD/YYYY" format
df['Date'] = df['Date'].dt.strftime('%m/%d/%Y')
