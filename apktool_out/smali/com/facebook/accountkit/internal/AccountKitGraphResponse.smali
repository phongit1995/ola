.class final Lcom/facebook/accountkit/internal/AccountKitGraphResponse;
.super Ljava/lang/Object;


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/facebook/accountkit/internal/AccountKitGraphResponse$IntegerRange;
    }
.end annotation


# static fields
.field private static final HTTP_RANGE_SUCCESS:Lcom/facebook/accountkit/internal/AccountKitGraphResponse$IntegerRange;

.field private static final TAG:Ljava/lang/String; = "AccountKitGraphResponse"


# instance fields
.field private final connection:Ljava/net/HttpURLConnection;

.field private final error:Lcom/facebook/accountkit/internal/AccountKitRequestError;

.field private final rawResponse:Ljava/lang/String;

.field private final request:Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

.field private final responseArray:Lorg/json/JSONArray;

.field private final responseObject:Lorg/json/JSONObject;


# direct methods
.method static constructor <clinit>()V
    .locals 4

    new-instance v0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse$IntegerRange;

    const/16 v1, 0xc8

    const/16 v2, 0x12b

    const/4 v3, 0x0

    invoke-direct {v0, v1, v2, v3}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse$IntegerRange;-><init>(IILcom/facebook/accountkit/internal/AccountKitGraphResponse$1;)V

    sput-object v0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->HTTP_RANGE_SUCCESS:Lcom/facebook/accountkit/internal/AccountKitGraphResponse$IntegerRange;

    return-void
.end method

.method public constructor <init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Lcom/facebook/accountkit/internal/AccountKitRequestError;)V
    .locals 7

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v6, p3

    invoke-direct/range {v0 .. v6}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;-><init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Ljava/lang/String;Lorg/json/JSONObject;Lorg/json/JSONArray;Lcom/facebook/accountkit/internal/AccountKitRequestError;)V

    return-void
.end method

.method private constructor <init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Ljava/lang/String;Lorg/json/JSONObject;Lorg/json/JSONArray;Lcom/facebook/accountkit/internal/AccountKitRequestError;)V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->request:Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    iput-object p2, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->connection:Ljava/net/HttpURLConnection;

    iput-object p3, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->rawResponse:Ljava/lang/String;

    iput-object p4, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->responseObject:Lorg/json/JSONObject;

    iput-object p5, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->responseArray:Lorg/json/JSONArray;

    iput-object p6, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->error:Lcom/facebook/accountkit/internal/AccountKitRequestError;

    return-void
.end method

.method private static checkResponseAndCreateError(Lorg/json/JSONObject;)Lcom/facebook/accountkit/internal/AccountKitRequestError;
    .locals 10

    const/4 v0, 0x0

    :try_start_0
    const-string v1, "code"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    const-string v1, "code"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v3

    const-string v1, "body"

    invoke-static {p0, v1}, Lcom/facebook/accountkit/internal/Utility;->getStringPropertyAsJSON(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    if-eqz p0, :cond_3

    instance-of v1, p0, Lorg/json/JSONObject;

    if-eqz v1, :cond_3

    check-cast p0, Lorg/json/JSONObject;

    const/4 v1, 0x0

    const-string v2, "error"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    const/4 v4, 0x1

    const/4 v5, -0x1

    if-eqz v2, :cond_0

    const-string v1, "error"

    invoke-static {p0, v1}, Lcom/facebook/accountkit/internal/Utility;->getStringPropertyAsJSON(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p0

    check-cast p0, Lorg/json/JSONObject;

    const-string v1, "type"

    invoke-virtual {p0, v1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "message"

    invoke-virtual {p0, v2, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v6, "error_user_msg"

    invoke-virtual {p0, v6}, Lorg/json/JSONObject;->optString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v6

    const-string v7, "code"

    invoke-virtual {p0, v7, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result v7

    const-string v8, "error_subcode"

    invoke-virtual {p0, v8, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result p0

    move v5, p0

    move-object v8, v6

    move p0, v7

    goto :goto_1

    :cond_0
    const-string v2, "error_code"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "error_msg"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_2

    const-string v2, "error_reason"

    invoke-virtual {p0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1

    goto :goto_0

    :cond_1
    move-object v6, v0

    move-object v7, v6

    move-object v8, v7

    const/4 p0, -0x1

    const/4 v4, 0x0

    goto :goto_2

    :cond_2
    :goto_0
    const-string v1, "error_reason"

    invoke-virtual {p0, v1, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "error_msg"

    invoke-virtual {p0, v2, v0}, Lorg/json/JSONObject;->optString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    const-string v6, "error_code"

    invoke-virtual {p0, v6, v5}, Lorg/json/JSONObject;->optInt(Ljava/lang/String;I)I

    move-result p0

    move-object v8, v0

    :goto_1
    move-object v6, v1

    move-object v7, v2

    :goto_2
    if-eqz v4, :cond_3

    new-instance v1, Lcom/facebook/accountkit/internal/AccountKitRequestError;

    const/4 v9, 0x0

    move-object v2, v1

    move v4, p0

    invoke-direct/range {v2 .. v9}, Lcom/facebook/accountkit/internal/AccountKitRequestError;-><init>(IIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/facebook/accountkit/AccountKitException;)V

    return-object v1

    :cond_3
    sget-object p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->HTTP_RANGE_SUCCESS:Lcom/facebook/accountkit/internal/AccountKitGraphResponse$IntegerRange;

    invoke-virtual {p0, v3}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse$IntegerRange;->contains(I)Z

    move-result p0

    if-nez p0, :cond_4

    new-instance p0, Lcom/facebook/accountkit/internal/AccountKitRequestError;

    const/4 v4, -0x1

    const/4 v5, -0x1

    const/4 v6, 0x0

    const/4 v7, 0x0

    const/4 v8, 0x0

    const/4 v9, 0x0

    move-object v2, p0

    invoke-direct/range {v2 .. v9}, Lcom/facebook/accountkit/internal/AccountKitRequestError;-><init>(IIILjava/lang/String;Ljava/lang/String;Ljava/lang/String;Lcom/facebook/accountkit/AccountKitException;)V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    :cond_4
    return-object v0
.end method

.method private static createResponseFromObject(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Ljava/lang/Object;)Lcom/facebook/accountkit/internal/AccountKitGraphResponse;
    .locals 8

    :try_start_0
    instance-of v0, p2, Lorg/json/JSONObject;

    if-eqz v0, :cond_3

    check-cast p2, Lorg/json/JSONObject;

    invoke-static {p2}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->checkResponseAndCreateError(Lorg/json/JSONObject;)Lcom/facebook/accountkit/internal/AccountKitRequestError;

    move-result-object v0

    if-eqz v0, :cond_0

    new-instance p2, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;

    invoke-direct {p2, p0, p1, v0}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;-><init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Lcom/facebook/accountkit/internal/AccountKitRequestError;)V

    return-object p2

    :cond_0
    const-string v0, "body"

    invoke-static {p2, v0}, Lcom/facebook/accountkit/internal/Utility;->getStringPropertyAsJSON(Lorg/json/JSONObject;Ljava/lang/String;)Ljava/lang/Object;

    move-result-object p2

    instance-of v0, p2, Lorg/json/JSONObject;

    if-eqz v0, :cond_1

    new-instance v0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    move-object v5, p2

    check-cast v5, Lorg/json/JSONObject;

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v1, v0

    move-object v2, p0

    move-object v3, p1

    invoke-direct/range {v1 .. v7}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;-><init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Ljava/lang/String;Lorg/json/JSONObject;Lorg/json/JSONArray;Lcom/facebook/accountkit/internal/AccountKitRequestError;)V

    return-object v0

    :cond_1
    instance-of v0, p2, Lorg/json/JSONArray;

    if-eqz v0, :cond_2

    new-instance v0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    move-object v6, p2

    check-cast v6, Lorg/json/JSONArray;

    const/4 v7, 0x0

    move-object v1, v0

    move-object v2, p0

    move-object v3, p1

    invoke-direct/range {v1 .. v7}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;-><init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Ljava/lang/String;Lorg/json/JSONObject;Lorg/json/JSONArray;Lcom/facebook/accountkit/internal/AccountKitRequestError;)V

    return-object v0

    :cond_2
    sget-object p2, Lorg/json/JSONObject;->NULL:Ljava/lang/Object;

    :cond_3
    sget-object v0, Lorg/json/JSONObject;->NULL:Ljava/lang/Object;

    if-ne p2, v0, :cond_4

    new-instance v0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;

    invoke-virtual {p2}, Ljava/lang/Object;->toString()Ljava/lang/String;

    move-result-object v4

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v1, v0

    move-object v2, p0

    move-object v3, p1

    invoke-direct/range {v1 .. v7}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;-><init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Ljava/lang/String;Lorg/json/JSONObject;Lorg/json/JSONArray;Lcom/facebook/accountkit/internal/AccountKitRequestError;)V

    return-object v0

    :cond_4
    new-instance v0, Lcom/facebook/accountkit/AccountKitException;

    sget-object v1, Lcom/facebook/accountkit/AccountKitError$Type;->INTERNAL_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v2, Lcom/facebook/accountkit/internal/InternalAccountKitError;->UNEXPECTED_OBJECT_TYPE_RESPONSE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-virtual {p2}, Ljava/lang/Object;->getClass()Ljava/lang/Class;

    move-result-object p2

    invoke-virtual {p2}, Ljava/lang/Class;->getSimpleName()Ljava/lang/String;

    move-result-object p2

    invoke-direct {v0, v1, v2, p2}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;Ljava/lang/String;)V

    throw v0
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    move-exception p2

    new-instance v0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;

    new-instance v1, Lcom/facebook/accountkit/internal/AccountKitRequestError;

    new-instance v2, Lcom/facebook/accountkit/AccountKitException;

    sget-object v3, Lcom/facebook/accountkit/AccountKitError$Type;->INTERNAL_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v4, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_GRAPH_RESPONSE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {v2, v3, v4, p2}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;Ljava/lang/Throwable;)V

    invoke-direct {v1, v2}, Lcom/facebook/accountkit/internal/AccountKitRequestError;-><init>(Lcom/facebook/accountkit/AccountKitException;)V

    invoke-direct {v0, p0, p1, v1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;-><init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Lcom/facebook/accountkit/internal/AccountKitRequestError;)V

    return-object v0
.end method

.method private static createResponseFromStream(Ljava/io/InputStream;Ljava/net/HttpURLConnection;Lcom/facebook/accountkit/internal/AccountKitGraphRequest;)Lcom/facebook/accountkit/internal/AccountKitGraphResponse;
    .locals 5

    invoke-static {p0}, Lcom/facebook/accountkit/internal/Utility;->readStreamToString(Ljava/io/InputStream;)Ljava/lang/String;

    move-result-object p0

    sget-object v0, Lcom/facebook/accountkit/LoggingBehavior;->REQUESTS:Lcom/facebook/accountkit/LoggingBehavior;

    const-string v1, "AccountKitGraphResponse"

    const-string v2, "Response:\n%s\n"

    const/4 v3, 0x1

    new-array v3, v3, [Ljava/lang/Object;

    const/4 v4, 0x0

    aput-object p0, v3, v4

    invoke-static {v0, v1, v2, v3}, Lcom/facebook/accountkit/internal/ConsoleLogger;->log(Lcom/facebook/accountkit/LoggingBehavior;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    new-instance v0, Lorg/json/JSONTokener;

    invoke-direct {v0, p0}, Lorg/json/JSONTokener;-><init>(Ljava/lang/String;)V

    invoke-virtual {v0}, Lorg/json/JSONTokener;->nextValue()Ljava/lang/Object;

    move-result-object p0

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "body"

    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    if-eqz p1, :cond_0

    invoke-virtual {p1}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result p0

    goto :goto_0

    :cond_0
    const/16 p0, 0xc8

    :goto_0
    const-string v1, "code"

    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    invoke-static {p2, p1, v0}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->createResponseFromObject(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Ljava/lang/Object;)Lcom/facebook/accountkit/internal/AccountKitGraphResponse;

    move-result-object p0

    return-object p0

    :catch_0
    move-exception p0

    new-instance v0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;

    new-instance v1, Lcom/facebook/accountkit/internal/AccountKitRequestError;

    new-instance v2, Lcom/facebook/accountkit/AccountKitException;

    sget-object v3, Lcom/facebook/accountkit/AccountKitError$Type;->INTERNAL_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v4, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_GRAPH_RESPONSE:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {v2, v3, v4, p0}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;Ljava/lang/Throwable;)V

    invoke-direct {v1, v2}, Lcom/facebook/accountkit/internal/AccountKitRequestError;-><init>(Lcom/facebook/accountkit/AccountKitException;)V

    invoke-direct {v0, p2, p1, v1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;-><init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Lcom/facebook/accountkit/internal/AccountKitRequestError;)V

    return-object v0
.end method

.method static fromHttpConnection(Ljava/net/HttpURLConnection;Lcom/facebook/accountkit/internal/AccountKitGraphRequest;)Lcom/facebook/accountkit/internal/AccountKitGraphResponse;
    .locals 7

    const/4 v0, 0x0

    const/4 v1, 0x1

    const/4 v2, 0x0

    :try_start_0
    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v3

    const/16 v4, 0x190

    if-lt v3, v4, :cond_0

    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getErrorStream()Ljava/io/InputStream;

    move-result-object v3

    :goto_0
    move-object v2, v3

    goto :goto_1

    :cond_0
    invoke-virtual {p0}, Ljava/net/HttpURLConnection;->getInputStream()Ljava/io/InputStream;

    move-result-object v3

    goto :goto_0

    :goto_1
    invoke-static {v2, p0, p1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->createResponseFromStream(Ljava/io/InputStream;Ljava/net/HttpURLConnection;Lcom/facebook/accountkit/internal/AccountKitGraphRequest;)Lcom/facebook/accountkit/internal/AccountKitGraphResponse;

    move-result-object v3
    :try_end_0
    .catch Lcom/facebook/accountkit/AccountKitException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0
    .catch Ljava/lang/SecurityException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    invoke-static {v2}, Lcom/facebook/accountkit/internal/Utility;->closeQuietly(Ljava/io/Closeable;)V

    return-object v3

    :catchall_0
    move-exception p0

    goto :goto_2

    :catch_0
    move-exception v3

    :try_start_1
    sget-object v4, Lcom/facebook/accountkit/LoggingBehavior;->REQUESTS:Lcom/facebook/accountkit/LoggingBehavior;

    const-string v5, "AccountKitGraphResponse"

    const-string v6, "Response <ERROR>: %s"

    new-array v1, v1, [Ljava/lang/Object;

    aput-object v3, v1, v0

    invoke-static {v4, v5, v6, v1}, Lcom/facebook/accountkit/internal/ConsoleLogger;->log(Lcom/facebook/accountkit/LoggingBehavior;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    new-instance v0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;

    new-instance v1, Lcom/facebook/accountkit/internal/AccountKitRequestError;

    new-instance v4, Lcom/facebook/accountkit/AccountKitException;

    sget-object v5, Lcom/facebook/accountkit/AccountKitError$Type;->SERVER_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    invoke-direct {v4, v5, v3}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Ljava/lang/Throwable;)V

    invoke-direct {v1, v4}, Lcom/facebook/accountkit/internal/AccountKitRequestError;-><init>(Lcom/facebook/accountkit/AccountKitException;)V

    invoke-direct {v0, p1, p0, v1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;-><init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Lcom/facebook/accountkit/internal/AccountKitRequestError;)V
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    invoke-static {v2}, Lcom/facebook/accountkit/internal/Utility;->closeQuietly(Ljava/io/Closeable;)V

    return-object v0

    :catch_1
    move-exception v3

    :try_start_2
    sget-object v4, Lcom/facebook/accountkit/LoggingBehavior;->REQUESTS:Lcom/facebook/accountkit/LoggingBehavior;

    const-string v5, "AccountKitGraphResponse"

    const-string v6, "Response <ERROR>: %s"

    new-array v1, v1, [Ljava/lang/Object;

    aput-object v3, v1, v0

    invoke-static {v4, v5, v6, v1}, Lcom/facebook/accountkit/internal/ConsoleLogger;->log(Lcom/facebook/accountkit/LoggingBehavior;Ljava/lang/String;Ljava/lang/String;[Ljava/lang/Object;)V

    new-instance v0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;

    new-instance v1, Lcom/facebook/accountkit/internal/AccountKitRequestError;

    invoke-direct {v1, v3}, Lcom/facebook/accountkit/internal/AccountKitRequestError;-><init>(Lcom/facebook/accountkit/AccountKitException;)V

    invoke-direct {v0, p1, p0, v1}, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;-><init>(Lcom/facebook/accountkit/internal/AccountKitGraphRequest;Ljava/net/HttpURLConnection;Lcom/facebook/accountkit/internal/AccountKitRequestError;)V
    :try_end_2
    .catchall {:try_start_2 .. :try_end_2} :catchall_0

    invoke-static {v2}, Lcom/facebook/accountkit/internal/Utility;->closeQuietly(Ljava/io/Closeable;)V

    return-object v0

    :goto_2
    invoke-static {v2}, Lcom/facebook/accountkit/internal/Utility;->closeQuietly(Ljava/io/Closeable;)V

    throw p0
.end method


# virtual methods
.method public getConnection()Ljava/net/HttpURLConnection;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->connection:Ljava/net/HttpURLConnection;

    return-object v0
.end method

.method public getError()Lcom/facebook/accountkit/internal/AccountKitRequestError;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->error:Lcom/facebook/accountkit/internal/AccountKitRequestError;

    return-object v0
.end method

.method public getRawResponse()Ljava/lang/String;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->rawResponse:Ljava/lang/String;

    return-object v0
.end method

.method public getRequest()Lcom/facebook/accountkit/internal/AccountKitGraphRequest;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->request:Lcom/facebook/accountkit/internal/AccountKitGraphRequest;

    return-object v0
.end method

.method public getResponseArray()Lorg/json/JSONArray;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->responseArray:Lorg/json/JSONArray;

    return-object v0
.end method

.method public getResponseObject()Lorg/json/JSONObject;
    .locals 1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->responseObject:Lorg/json/JSONObject;

    return-object v0
.end method

.method public toString()Ljava/lang/String;
    .locals 5

    :try_start_0
    sget-object v0, Ljava/util/Locale;->US:Ljava/util/Locale;

    const-string v1, "%d"

    const/4 v2, 0x1

    new-array v2, v2, [Ljava/lang/Object;

    const/4 v3, 0x0

    iget-object v4, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->connection:Ljava/net/HttpURLConnection;

    if-eqz v4, :cond_0

    iget-object v4, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->connection:Ljava/net/HttpURLConnection;

    invoke-virtual {v4}, Ljava/net/HttpURLConnection;->getResponseCode()I

    move-result v4

    goto :goto_0

    :cond_0
    const/16 v4, 0xc8

    :goto_0
    invoke-static {v4}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    aput-object v4, v2, v3

    invoke-static {v0, v1, v2}, Ljava/lang/String;->format(Ljava/util/Locale;Ljava/lang/String;[Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/io/IOException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_1

    :catch_0
    const-string v0, "unknown"

    :goto_1
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "{Response:  responseCode: "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, ", responseObject: "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->responseObject:Lorg/json/JSONObject;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v0, ", error: "

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitGraphResponse;->error:Lcom/facebook/accountkit/internal/AccountKitRequestError;

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    const-string v0, "}"

    invoke-virtual {v1, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method
