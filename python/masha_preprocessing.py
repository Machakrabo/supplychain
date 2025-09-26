#!/usr/bin/env python
# coding: utf-8

# In[69]:


# pour faire un lien entre le serveur SQL et python voici les étapes suivantes--
# installer les packages concernant ce projet
#importer des bibliothèques
#donner des détails de BD
                              


# In[70]:


get_ipython().system('pip install pyodbc')


# In[71]:


import pyodbc
import pandas as pd
print("Coucou toute le mondes--")
print ("Les bibliothèques sont chargées avec succès.")


# In[72]:


print(f"Les drivers: {pyodbc.drivers()}")


# In[73]:


import pyodbc
import pandas as pd

conn_str = (
    r'DRIVER={ODBC Driver 17 for SQL Server};'
    r'SERVER=(localdb)\Mashalocaldb;'
    r'DATABASE=MashaDB;'
    r'Trusted_Connection=yes;'
)
conn = pyodbc.connect(conn_str)
query = "SELECT * FROM mashagold.actuals_qty"
df_actuals_qty = pd.read_sql(query, conn)
print(df_actuals_qty)


# In[74]:


# pour terminer le login il faudra se connecter à votre serveur SQL


# In[75]:


df_actuals_qty.head()


# In[76]:


df_actuals_qty.info()


# In[77]:


#changement du type de les colonnes sales_forecast,algo_error,algo_error_absolute,algo_error_squared, prd_price, currency_id


# In[78]:


df_actuals_qty['sales_forecast'] = df_actuals_qty['sales_forecast'].astype("float")
print(df_actuals_qty['sales_forecast'].dtype)


# In[79]:


df_actuals_qty['algo_error'] = df_actuals_qty['algo_error'].astype("float")
print(df_actuals_qty['algo_error'].dtype)


# In[80]:


df_actuals_qty['algo_error_absolute'] = df_actuals_qty['algo_error_absolute'].astype("float")
print(df_actuals_qty['algo_error_absolute'].dtype)


# In[81]:


df_actuals_qty['algo_error_squared']=df_actuals_qty['algo_error_squared'].astype("float")
print(df_actuals_qty['algo_error_squared'].dtype)


# In[82]:


df_actuals_qty['prd_price']= df_actuals_qty['prd_price'].astype("float")
print(df_actuals_qty['prd_price'].dtype)


# In[83]:


df_actuals_qty.info()


# In[84]:


#label encoding


# In[85]:


df_actuals_info = df_actuals_qty
print(df_actuals_info)


# In[86]:


from sklearn.preprocessing import LabelEncoder
print(" Le Label Encoder est chargé")


# In[87]:


df_actuals_info['prd_seasons'].unique()


# In[88]:


df_actuals_info['prd_seasons_grp']= LabelEncoder().fit_transform(df_actuals_info['prd_seasons'])


# In[89]:


df_actuals_info['prd_seasons_grp'].value_counts()


# In[90]:


df_actuals_info.head()


# In[ ]:


# les valeurs NULL


# In[93]:


df_actuals_info[['dates','loc_id','prd_id', 'currency_desc']].isnull().sum()

