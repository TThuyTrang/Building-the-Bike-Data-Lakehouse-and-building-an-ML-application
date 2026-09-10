import streamlit as st
import pandas as pd
import numpy as np
import mlflow.pyfunc

# 1. Page Configuration
st.set_page_config(
    page_title="Customer Churn Prediction Engine",
    page_icon="🔮",
    layout="wide"
)

# 2. Embedded Custom CSS Styling (Pastel UI Theme)
custom_css = """
<style>
/* Main App Background */
.stApp {
    background-color: #f7f9fc;
}

/* Sidebar - Pastel Blue */
section[data-testid="stSidebar"] {
    background-color: #e3f2fd !important;
    border-right: 2px solid #bbdefb;
}

/* Card / Container Wrappers - Pastel Pink */
div[data-testid="stVerticalBlockBorderWrapper"],
div[data-testid="stColumn"] > div {
    background-color: #fff0f5;
    border-radius: 15px;
    padding: 15px;
    border: 1px solid #ffc0cb;
}

/* Title (st.title) */
h1 {
    color: #d81b60 !important;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
    font-weight: 700;
}

/* Subheaders (st.subheader) */
h2, h3 {
    color: #0288d1 !important;
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

/* Button Base Style */
div.stButton > button {
    background-color: #ffb6c1 !important;
    color: #4a4a4a !important;
    font-weight: bold !important;
    border-radius: 20px !important;
    border: 2px solid #ff8da1 !important;
    padding: 10px 24px !important;
    transition: all 0.3s ease !important;
}

/* Button Hover State */
div.stButton > button:hover {
    background-color: #ff8da1 !important;
    color: #ffffff !important;
    transform: scale(1.03);
}

/* Progress Bar Customization */
div[data-testid="stProgress"] > div > div > div {
    background-color: #ffb6c1 !important;
}
</style>
"""

# Apply CSS directly to the Streamlit app
st.markdown(custom_css, unsafe_allow_html=True)

# Title & Description
st.title("Customer Churn Risk Prediction Engine")
st.markdown("""
Predict customer churn risk based on a **Random Forest Machine Learning model** 
trained and managed via **Databricks Unity Catalog & MLflow**.
""")

st.divider()

# 3. Sidebar - Interactive Customer Inputs
st.sidebar.header("Customer Inputs")

def user_input_features():
    """Collects feature inputs from the sidebar controls."""
    recency = st.sidebar.slider("Recency (Days since last purchase)", min_value=1, max_value=365, value=30)
    frequency = st.sidebar.slider("Frequency (Total order count)", min_value=1, max_value=50, value=5)
    monetary = st.sidebar.number_input("Monetary (Total spend $)", min_value=10.0, max_value=10000.0, value=500.0)
    avg_order_value = monetary / frequency if frequency > 0 else 0
    
    country = st.sidebar.selectbox("Country", ["Australia", "United States", "United Kingdom", "Germany", "France"])
    gender = st.sidebar.radio("Gender", ["Male", "Female"])

    data = {
        'recency': recency,
        'frequency': frequency,
        'monetary': monetary,
        'avg_order_value': avg_order_value,
        'country': country,
        'gender': gender
    }
    return pd.DataFrame(data, index=[0])

input_df = user_input_features()

# 4. Display Selected Customer Parameters
col1, col2 = st.columns([1, 2])

with col1:
    st.subheader("Input Parameters")
    st.dataframe(input_df.T.rename(columns={0: 'Value'}))

# 5. Model Loading & Real-time Inference
with col2:
    st.subheader("Risk Prediction Result")
    
    @st.cache_resource
    def load_churn_model():
        """Loads the registered production model from Databricks Unity Catalog via MLflow."""
        model_uri = "models:/main.gold.churn_model/Production" 
        try:
            return mlflow.pyfunc.load_model(model_uri)
        except Exception:
            return None # Fallback to mock logic if Databricks model registry is unreachable

    model = load_churn_model()

    if st.button("Predict Churn Risk", type="primary"):
        if model is not None:
            # Inference using loaded MLflow model
            prediction_proba = model.predict(input_df)[0]
            churn_risk = float(prediction_proba)
        else:
            # Fallback mock prediction logic for local/cloud environments without Databricks API access
            churn_risk = min(1.0, max(0.0, (input_df['recency'][0] * 0.002) - (input_df['frequency'][0] * 0.05) + 0.3))

        # Output Visualization
        st.write("### Churn Probability:")
        st.progress(churn_risk)
        st.metric(label="Predicted Churn Rate", value=f"{churn_risk * 100:.1f}%")

        # Risk Threshold Alerts
        if churn_risk >= 0.7:
            st.error("⚠️ **HIGH RISK:** Customer has a critical churn probability! Trigger retention campaign immediately.")
        elif churn_risk >= 0.4:
            st.warning("⚡ **MEDIUM RISK:** Send promotional offers/check-in emails to maintain engagement.")
        else:
            st.success("✅ **LOW RISK:** Customer is loyal and actively engaged.")