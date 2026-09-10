{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 0,
   "metadata": {
    "application/vnd.databricks.v1+cell": {
     "cellMetadata": {},
     "inputWidgets": {},
     "nuid": "0cd138bc-2a61-4bf5-ae2b-e9c5929cff9a",
     "showTitle": false,
     "tableResultSettingsMap": {},
     "title": ""
    }
   },
   "outputs": [],
   "source": [
    "%sql\n",
    "\n",
    "-- Card 2: Total Profit\n",
    "WITH kpi_data AS (\n",
    "  SELECT \n",
    "    cy.total_profit AS current_value,\n",
    "    py.total_profit AS prior_value,\n",
    "    ROUND(((cy.total_profit - py.total_profit) / py.total_profit) * 100, 2) AS yoy_pct\n",
    "  FROM (\n",
    "    SELECT SUM(`sales_amount`) AS total_profit\n",
    "    FROM `workspace`.`gold`.`fact_sales`\n",
    "    WHERE YEAR(`order_date`) = 2013\n",
    "  ) cy\n",
    "  CROSS JOIN (\n",
    "    SELECT SUM(`sales_amount`) AS total_profit\n",
    "    FROM `workspace`.`gold`.`fact_sales`\n",
    "    WHERE YEAR(`order_date`) = 2012\n",
    "  ) py\n",
    ")\n",
    "SELECT \n",
    "  'Total Profit' AS metric_name,\n",
    "  current_value,\n",
    "  yoy_pct,\n",
    "  CONCAT(CASE WHEN yoy_pct > 0 THEN '↑ +' ELSE '↓ ' END, FORMAT_NUMBER(yoy_pct, '#,##0.0'), '% vs 2012') AS yoy_label\n",
    "FROM kpi_data\n"
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
   "notebookName": "total_profit.sql",
   "widgets": {}
  },
  "language_info": {
   "name": "python"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 0
}
