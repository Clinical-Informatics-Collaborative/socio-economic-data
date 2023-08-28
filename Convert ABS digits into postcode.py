#!/usr/bin/env python
# coding: utf-8

# In[7]:


import pandas as pd

# Read the CSV file into a DataFrame
df = pd.read_csv('/Users/linzizhuo/desktop/Socio-eco.csv')
df


# In[10]:


df1 = df.drop([0,1,2,3,4,5,55034,55035])
df1


# In[11]:


def extract_4_digit(number):
    return (number // 100) % 10000


# In[13]:


df1['Table 2-Table 1'] = df1['Table 2-Table 1'].astype(int)

df1['Table 2-Table 1'] = df1['Table 2-Table 1'].apply(extract_4_digit)
df1


# In[15]:


df1.to_csv('/Users/linzizhuo/desktop/output.csv', index=False)


# In[ ]:




