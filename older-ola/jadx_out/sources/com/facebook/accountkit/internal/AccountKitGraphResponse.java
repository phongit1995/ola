package com.facebook.accountkit.internal;

import android.support.v7.widget.helper.ItemTouchHelper;
import com.facebook.accountkit.AccountKitError;
import com.facebook.accountkit.AccountKitException;
import com.facebook.accountkit.LoggingBehavior;
import java.io.IOException;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.util.Locale;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

/* JADX INFO: loaded from: classes.dex */
final class AccountKitGraphResponse {
    private static final IntegerRange HTTP_RANGE_SUCCESS = new IntegerRange(ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION, 299);
    private static final String TAG = "AccountKitGraphResponse";
    private final HttpURLConnection connection;
    private final AccountKitRequestError error;
    private final String rawResponse;
    private final AccountKitGraphRequest request;
    private final JSONArray responseArray;
    private final JSONObject responseObject;

    private static final class IntegerRange {
        private final int end;
        private final int start;

        private IntegerRange(int i, int i2) {
            this.start = i;
            this.end = i2;
        }

        public boolean contains(int i) {
            return this.start <= i && i <= this.end;
        }
    }

    public AccountKitGraphResponse(AccountKitGraphRequest accountKitGraphRequest, HttpURLConnection httpURLConnection, AccountKitRequestError accountKitRequestError) {
        this(accountKitGraphRequest, httpURLConnection, null, null, null, accountKitRequestError);
    }

    private AccountKitGraphResponse(AccountKitGraphRequest accountKitGraphRequest, HttpURLConnection httpURLConnection, String str, JSONObject jSONObject, JSONArray jSONArray, AccountKitRequestError accountKitRequestError) {
        this.request = accountKitGraphRequest;
        this.connection = httpURLConnection;
        this.rawResponse = str;
        this.responseObject = jSONObject;
        this.responseArray = jSONArray;
        this.error = accountKitRequestError;
    }

    /* JADX WARN: Removed duplicated region for block: B:23:0x0088 A[Catch: JSONException -> 0x00a6, TryCatch #0 {JSONException -> 0x00a6, blocks: (B:3:0x0001, B:5:0x0009, B:7:0x0017, B:9:0x001b, B:11:0x0028, B:23:0x0088, B:12:0x0052, B:14:0x005a, B:16:0x0062, B:20:0x0071, B:25:0x0091, B:27:0x0099), top: B:31:0x0001 }] */
    /*
        Code decompiled incorrectly, please refer to instructions dump.
        To view partially-correct add '--show-bad-code' argument
    */
    private static com.facebook.accountkit.internal.AccountKitRequestError checkResponseAndCreateError(org.json.JSONObject r10) {
        /*
            r0 = 0
            java.lang.String r1 = "code"
            boolean r1 = r10.has(r1)     // Catch: org.json.JSONException -> La6
            if (r1 == 0) goto La6
            java.lang.String r1 = "code"
            int r3 = r10.getInt(r1)     // Catch: org.json.JSONException -> La6
            java.lang.String r1 = "body"
            java.lang.Object r10 = com.facebook.accountkit.internal.Utility.getStringPropertyAsJSON(r10, r1)     // Catch: org.json.JSONException -> La6
            if (r10 == 0) goto L91
            boolean r1 = r10 instanceof org.json.JSONObject     // Catch: org.json.JSONException -> La6
            if (r1 == 0) goto L91
            org.json.JSONObject r10 = (org.json.JSONObject) r10     // Catch: org.json.JSONException -> La6
            r1 = 0
            java.lang.String r2 = "error"
            boolean r2 = r10.has(r2)     // Catch: org.json.JSONException -> La6
            r4 = 1
            r5 = -1
            if (r2 == 0) goto L52
            java.lang.String r1 = "error"
            java.lang.Object r10 = com.facebook.accountkit.internal.Utility.getStringPropertyAsJSON(r10, r1)     // Catch: org.json.JSONException -> La6
            org.json.JSONObject r10 = (org.json.JSONObject) r10     // Catch: org.json.JSONException -> La6
            java.lang.String r1 = "type"
            java.lang.String r1 = r10.optString(r1, r0)     // Catch: org.json.JSONException -> La6
            java.lang.String r2 = "message"
            java.lang.String r2 = r10.optString(r2, r0)     // Catch: org.json.JSONException -> La6
            java.lang.String r6 = "error_user_msg"
            java.lang.String r6 = r10.optString(r6)     // Catch: org.json.JSONException -> La6
            java.lang.String r7 = "code"
            int r7 = r10.optInt(r7, r5)     // Catch: org.json.JSONException -> La6
            java.lang.String r8 = "error_subcode"
            int r10 = r10.optInt(r8, r5)     // Catch: org.json.JSONException -> La6
            r5 = r10
            r8 = r6
            r10 = r7
            goto L84
        L52:
            java.lang.String r2 = "error_code"
            boolean r2 = r10.has(r2)     // Catch: org.json.JSONException -> La6
            if (r2 != 0) goto L71
            java.lang.String r2 = "error_msg"
            boolean r2 = r10.has(r2)     // Catch: org.json.JSONException -> La6
            if (r2 != 0) goto L71
            java.lang.String r2 = "error_reason"
            boolean r2 = r10.has(r2)     // Catch: org.json.JSONException -> La6
            if (r2 == 0) goto L6b
            goto L71
        L6b:
            r6 = r0
            r7 = r6
            r8 = r7
            r10 = -1
            r4 = 0
            goto L86
        L71:
            java.lang.String r1 = "error_reason"
            java.lang.String r1 = r10.optString(r1, r0)     // Catch: org.json.JSONException -> La6
            java.lang.String r2 = "error_msg"
            java.lang.String r2 = r10.optString(r2, r0)     // Catch: org.json.JSONException -> La6
            java.lang.String r6 = "error_code"
            int r10 = r10.optInt(r6, r5)     // Catch: org.json.JSONException -> La6
            r8 = r0
        L84:
            r6 = r1
            r7 = r2
        L86:
            if (r4 == 0) goto L91
            com.facebook.accountkit.internal.AccountKitRequestError r1 = new com.facebook.accountkit.internal.AccountKitRequestError     // Catch: org.json.JSONException -> La6
            r9 = 0
            r2 = r1
            r4 = r10
            r2.<init>(r3, r4, r5, r6, r7, r8, r9)     // Catch: org.json.JSONException -> La6
            return r1
        L91:
            com.facebook.accountkit.internal.AccountKitGraphResponse$IntegerRange r10 = com.facebook.accountkit.internal.AccountKitGraphResponse.HTTP_RANGE_SUCCESS     // Catch: org.json.JSONException -> La6
            boolean r10 = r10.contains(r3)     // Catch: org.json.JSONException -> La6
            if (r10 != 0) goto La6
            com.facebook.accountkit.internal.AccountKitRequestError r10 = new com.facebook.accountkit.internal.AccountKitRequestError     // Catch: org.json.JSONException -> La6
            r4 = -1
            r5 = -1
            r6 = 0
            r7 = 0
            r8 = 0
            r9 = 0
            r2 = r10
            r2.<init>(r3, r4, r5, r6, r7, r8, r9)     // Catch: org.json.JSONException -> La6
            return r10
        La6:
            return r0
        */
        throw new UnsupportedOperationException("Method not decompiled: com.facebook.accountkit.internal.AccountKitGraphResponse.checkResponseAndCreateError(org.json.JSONObject):com.facebook.accountkit.internal.AccountKitRequestError");
    }

    private static AccountKitGraphResponse createResponseFromObject(AccountKitGraphRequest accountKitGraphRequest, HttpURLConnection httpURLConnection, Object obj) {
        try {
            if (obj instanceof JSONObject) {
                JSONObject jSONObject = (JSONObject) obj;
                AccountKitRequestError accountKitRequestErrorCheckResponseAndCreateError = checkResponseAndCreateError(jSONObject);
                if (accountKitRequestErrorCheckResponseAndCreateError != null) {
                    return new AccountKitGraphResponse(accountKitGraphRequest, httpURLConnection, accountKitRequestErrorCheckResponseAndCreateError);
                }
                Object stringPropertyAsJSON = Utility.getStringPropertyAsJSON(jSONObject, AccountKitGraphConstants.BODY_KEY);
                if (stringPropertyAsJSON instanceof JSONObject) {
                    return new AccountKitGraphResponse(accountKitGraphRequest, httpURLConnection, stringPropertyAsJSON.toString(), (JSONObject) stringPropertyAsJSON, null, null);
                }
                if (stringPropertyAsJSON instanceof JSONArray) {
                    return new AccountKitGraphResponse(accountKitGraphRequest, httpURLConnection, stringPropertyAsJSON.toString(), null, (JSONArray) stringPropertyAsJSON, null);
                }
                obj = JSONObject.NULL;
            }
            if (obj == JSONObject.NULL) {
                return new AccountKitGraphResponse(accountKitGraphRequest, httpURLConnection, obj.toString(), null, null, null);
            }
            throw new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, InternalAccountKitError.UNEXPECTED_OBJECT_TYPE_RESPONSE, obj.getClass().getSimpleName());
        } catch (JSONException e) {
            return new AccountKitGraphResponse(accountKitGraphRequest, httpURLConnection, new AccountKitRequestError(new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, InternalAccountKitError.INVALID_GRAPH_RESPONSE, e)));
        }
    }

    private static AccountKitGraphResponse createResponseFromStream(InputStream inputStream, HttpURLConnection httpURLConnection, AccountKitGraphRequest accountKitGraphRequest) throws Throwable {
        String streamToString = Utility.readStreamToString(inputStream);
        ConsoleLogger.log(LoggingBehavior.REQUESTS, TAG, "Response:\n%s\n", streamToString);
        Object objNextValue = new JSONTokener(streamToString).nextValue();
        try {
            JSONObject jSONObject = new JSONObject();
            jSONObject.put(AccountKitGraphConstants.BODY_KEY, objNextValue);
            jSONObject.put("code", httpURLConnection != null ? httpURLConnection.getResponseCode() : ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION);
            return createResponseFromObject(accountKitGraphRequest, httpURLConnection, jSONObject);
        } catch (IOException | JSONException e) {
            return new AccountKitGraphResponse(accountKitGraphRequest, httpURLConnection, new AccountKitRequestError(new AccountKitException(AccountKitError.Type.INTERNAL_ERROR, InternalAccountKitError.INVALID_GRAPH_RESPONSE, e)));
        }
    }

    static AccountKitGraphResponse fromHttpConnection(HttpURLConnection httpURLConnection, AccountKitGraphRequest accountKitGraphRequest) {
        InputStream errorStream = null;
        try {
            errorStream = httpURLConnection.getResponseCode() >= 400 ? httpURLConnection.getErrorStream() : httpURLConnection.getInputStream();
            return createResponseFromStream(errorStream, httpURLConnection, accountKitGraphRequest);
        } catch (AccountKitException e) {
            ConsoleLogger.log(LoggingBehavior.REQUESTS, TAG, "Response <ERROR>: %s", e);
            return new AccountKitGraphResponse(accountKitGraphRequest, httpURLConnection, new AccountKitRequestError(e));
        } catch (IOException | SecurityException | JSONException e2) {
            ConsoleLogger.log(LoggingBehavior.REQUESTS, TAG, "Response <ERROR>: %s", e2);
            return new AccountKitGraphResponse(accountKitGraphRequest, httpURLConnection, new AccountKitRequestError(new AccountKitException(AccountKitError.Type.SERVER_ERROR, e2)));
        } finally {
            Utility.closeQuietly(errorStream);
        }
    }

    public HttpURLConnection getConnection() {
        return this.connection;
    }

    public AccountKitRequestError getError() {
        return this.error;
    }

    public String getRawResponse() {
        return this.rawResponse;
    }

    public AccountKitGraphRequest getRequest() {
        return this.request;
    }

    public JSONArray getResponseArray() {
        return this.responseArray;
    }

    public JSONObject getResponseObject() {
        return this.responseObject;
    }

    public String toString() {
        String str;
        try {
            Locale locale = Locale.US;
            Object[] objArr = new Object[1];
            objArr[0] = Integer.valueOf(this.connection != null ? this.connection.getResponseCode() : ItemTouchHelper.Callback.DEFAULT_DRAG_ANIMATION_DURATION);
            str = String.format(locale, "%d", objArr);
        } catch (IOException unused) {
            str = "unknown";
        }
        return "{Response:  responseCode: " + str + ", responseObject: " + this.responseObject + ", error: " + this.error + "}";
    }
}
