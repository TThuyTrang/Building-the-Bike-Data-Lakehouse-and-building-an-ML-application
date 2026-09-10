{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 0,
   "metadata": {
    "application/vnd.databricks.v1+cell": {
     "cellMetadata": {},
     "inputWidgets": {},
     "nuid": "c9717d40-310a-496b-95d2-4784258cd874",
     "showTitle": false,
     "tableResultSettingsMap": {},
     "title": ""
    }
   },
   "outputs": [],
   "source": [
    "%sql\n",
    "\n",
    "-- Card 3: Total Orders\n",
    "WITH kpi_data AS (\n",
    "  SELECT \n",
    "    cy.total_orders AS current_value,\n",
    "    py.total_orders AS prior_value,\n",
    "    ROUND(((cy.total_orders - py.total_orders) / CAST(py.total_orders AS DOUBLE)) * 100, 2) AS yoy_pct\n",
    "  FROM (\n",
    "    SELECT COUNT(DISTINCT `order_number`) AS total_orders\n",
    "    FROM `workspace`.`gold`.`fact_sales`\n",
    "    WHERE YEAR(`order_date`) = 2013\n",
    "  ) cy\n",
    "  CROSS JOIN (\n",
    "    SELECT COUNT(DISTINCT `order_number`) AS total_orders\n",
    "    FROM `workspace`.`gold`.`fact_sales`\n",
    "    WHERE YEAR(`order_date`) = 2012\n",
    "  ) py\n",
    ")\n",
    "SELECT \n",
    "  'Total Orders' AS metric_name,\n",
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
   "notebookName": "total_orders.sql",
   "widgets": {}
  },
  "language_info": {
   "name": "python"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 0
}
