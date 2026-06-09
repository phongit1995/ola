package com.facebook.accountkit.internal;

import android.content.Context;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import com.facebook.accountkit.internal.AccountKitGraphRequest;
import java.util.HashMap;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

/* JADX INFO: loaded from: classes.dex */
final class ExperimentationConfigurator {
    private static final String FEATURE_PARAMETER_KEY = "key";
    private static final String FEATURE_PARAMETER_VALUE = "value";
    private static final String GRAPH_PATH_GET_CONFIGURATION = "experimentation_configuration";
    private static final String PARAMETER_UNIT_IDENTIFIER = "unit_id";
    private static final String RESPONSE_PARAMETER_CREATE_TIME = "create_time";
    private static final String RESPONSE_PARAMETER_DATA = "data";
    private static final String RESPONSE_PARAMETER_FEATURE_SET = "feature_set";
    private static final String RESPONSE_PARAMETER_TTL = "ttl";
    private static final String RESPONSE_PARAMETER_UNIT_ID = "unit_id";
    private Context applicationContext;

    ExperimentationConfigurator() {
    }

    /* JADX INFO: Access modifiers changed from: private */
    public AccountKitGraphRequest buildGraphRequest(String str, @Nullable String str2) {
        Bundle bundle = new Bundle();
        Utility.putNonNullString(bundle, "unit_id", str2);
        return new AccountKitGraphRequest(null, str, bundle, false, HttpMethod.GET);
    }

    /* JADX INFO: Access modifiers changed from: private */
    public void downloadExperimentationConfiguration(@Nullable final String str) {
        Utility.getThreadPoolExecutor().execute(new Runnable() { // from class: com.facebook.accountkit.internal.ExperimentationConfigurator.2
            @Override // java.lang.Runnable
            public void run() {
                AccountKitGraphRequest accountKitGraphRequestBuildGraphRequest = ExperimentationConfigurator.this.buildGraphRequest(ExperimentationConfigurator.GRAPH_PATH_GET_CONFIGURATION, str);
                AccountKitGraphRequestAsyncTask.cancelCurrentAsyncTask();
                AccountKitGraphRequestAsyncTask.setCurrentAsyncTask(AccountKitGraphRequest.executeAsync(accountKitGraphRequestBuildGraphRequest, new AccountKitGraphRequest.Callback() { // from class: com.facebook.accountkit.internal.ExperimentationConfigurator.2.1
                    @Override // com.facebook.accountkit.internal.AccountKitGraphRequest.Callback
                    public void onCompleted(AccountKitGraphResponse accountKitGraphResponse) {
                        if (accountKitGraphResponse == null || accountKitGraphResponse.getResponseObject() == null || accountKitGraphResponse.getError() != null) {
                            return;
                        }
                        try {
                            JSONObject jSONObject = accountKitGraphResponse.getResponseObject().getJSONArray("data").getJSONObject(0);
                            Long lValueOf = jSONObject.has(ExperimentationConfigurator.RESPONSE_PARAMETER_CREATE_TIME) ? Long.valueOf(jSONObject.getLong(ExperimentationConfigurator.RESPONSE_PARAMETER_CREATE_TIME)) : null;
                            String string = jSONObject.has("unit_id") ? jSONObject.getString("unit_id") : null;
                            Long lValueOf2 = jSONObject.has(ExperimentationConfigurator.RESPONSE_PARAMETER_TTL) ? Long.valueOf(jSONObject.getLong(ExperimentationConfigurator.RESPONSE_PARAMETER_TTL)) : null;
                            JSONArray jSONArray = jSONObject.getJSONArray(ExperimentationConfigurator.RESPONSE_PARAMETER_FEATURE_SET);
                            HashMap map = new HashMap(jSONArray.length());
                            for (int i = 0; i < jSONArray.length(); i++) {
                                JSONObject jSONObject2 = jSONArray.getJSONObject(i);
                                map.put(Integer.valueOf(jSONObject2.getInt(ExperimentationConfigurator.FEATURE_PARAMETER_KEY)), Integer.valueOf(jSONObject2.getInt("value")));
                            }
                            ExperimentationConfiguration.load(ExperimentationConfigurator.this.applicationContext, string, lValueOf, lValueOf2, map);
                        } catch (JSONException unused) {
                        }
                    }
                }));
            }
        });
    }

    ExperimentationConfiguration getExperimentationConfiguration() {
        return new ExperimentationConfiguration(this.applicationContext);
    }

    void initialize(@NonNull Context context) {
        Validate.checkInternetPermissionAndThrow(context);
        this.applicationContext = context.getApplicationContext();
        Utility.getThreadPoolExecutor().execute(new Runnable() { // from class: com.facebook.accountkit.internal.ExperimentationConfigurator.1
            @Override // java.lang.Runnable
            public void run() {
                ExperimentationConfiguration experimentationConfiguration = ExperimentationConfigurator.this.getExperimentationConfiguration();
                if (!experimentationConfiguration.exists() || experimentationConfiguration.isStale()) {
                    ExperimentationConfigurator.this.downloadExperimentationConfiguration(experimentationConfiguration.getUnitID());
                }
            }
        });
    }
}
