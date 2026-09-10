{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 0,
   "metadata": {
    "application/vnd.databricks.v1+cell": {
     "cellMetadata": {},
     "inputWidgets": {},
     "nuid": "a2702efe-0fdf-41ac-8e87-4728fe625883",
     "showTitle": false,
     "tableResultSettingsMap": {},
     "title": ""
    }
   },
   "outputs": [],
   "source": [
    "%sql\n",
    "\n",
    "-- Card 4: Average Order Value\n",
    "WITH kpi_data AS (\n",
    "  SELECT \n",
    "    cy.avg_order_value AS current_value,\n",
    "    py.avg_order_value AS prior_value,\n",
    "    ROUND(((cy.avg_order_value - py.avg_order_value) / py.avg_order_value) * 100, 2) AS yoy_pct\n",
    "  FROM (\n",
    "    SELECT ROUND(SUM(`sales_amount`) / COUNT(DISTINCT `order_number`), 2) AS avg_order_value\n",
    "    FROM `workspace`.`gold`.`fact_sales`\n",
    "    WHERE YEAR(`order_date`) = 2013\n",
    "  ) cy\n",
    "  CROSS JOIN (\n",
    "    SELECT ROUND(SUM(`sales_amount`) / COUNT(DISTINCT `order_number`), 2) AS avg_order_value\n",
    "    FROM `workspace`.`gold`.`fact_sales`\n",
    "    WHERE YEAR(`order_date`) = 2012\n",
    "  ) py\n",
    ")\n",
    "SELECT \n",
    "  'Average Order Value' AS metric_name,\n",
    "  current_value,\n",
    "  yoy_pct,\n",
    "  CONCAT(CASE WHEN yoy_pct > 0 THEN '↑ +' ELSE '↓ ' END, FORMAT_NUMBER(ABS(yoy_pct), '#,##0.0'), '% vs 2012') AS yoy_label\n",
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
   "notebookName": "average_order_value.sql",
   "widgets": {}
  },
  "language_info": {
   "name": "python"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 0
}
