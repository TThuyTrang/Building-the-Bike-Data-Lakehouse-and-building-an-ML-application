{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 0,
   "metadata": {
    "application/vnd.databricks.v1+cell": {
     "cellMetadata": {},
     "inputWidgets": {},
     "nuid": "6a5661f1-c3a2-4831-8f7e-76343459a62a",
     "showTitle": false,
     "tableResultSettingsMap": {},
     "title": ""
    }
   },
   "outputs": [],
   "source": [
    "%sql\n",
    "\n",
    "SELECT \n",
    "  DATE_TRUNC('month', `order_date`) AS order_month,\n",
    "  SUM(`sales_amount`) AS total_revenue,\n",
    "  SUM(`sales_amount`) AS total_profit\n",
    "FROM `workspace`.`gold`.`fact_sales`\n",
    "WHERE `order_date` IS NOT NULL\n",
    "GROUP BY DATE_TRUNC('month', `order_date`)\n",
    "ORDER BY order_month\n"
   ]
  }
 ],
 "metadata": {
  "application/vnd.databricks.v1+notebook": {
   "computePreferences": null,
   "dashboards": [],
   "environmentMetadata": {
    "base_environment": "",
    "environment_version": "5"
   },
   "inputWidgetPreferences": null,
   "language": "python",
   "notebookMetadata": {
    "pythonIndentUnit": 4
   },
   "notebookName": "monthly_revenue&profit.sql",
   "widgets": {}
  },
  "language_info": {
   "name": "python"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 0
}
