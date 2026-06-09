.class final Lcom/facebook/accountkit/internal/AccessTokenCache;
.super Ljava/lang/Object;


# static fields
.field private static final ACCESS_TOKEN_ACCOUNT_ID_KEY:Ljava/lang/String; = "account_id"

.field private static final ACCESS_TOKEN_APPLICATION_ID_KEY:Ljava/lang/String; = "application_id"

.field private static final ACCESS_TOKEN_LAST_REFRESH_KEY:Ljava/lang/String; = "last_refresh"

.field private static final ACCESS_TOKEN_REFRESH_INTERVAL_KEY:Ljava/lang/String; = "tokenRefreshIntervalInSeconds"

.field private static final ACCESS_TOKEN_TOKEN_KEY:Ljava/lang/String; = "token"

.field private static final ACCESS_TOKEN_VERSION_KEY:Ljava/lang/String; = "version"

.field private static final ACCESS_TOKEN_VERSION_VALUE:I = 0x1

.field static final CACHED_ACCESS_TOKEN_KEY:Ljava/lang/String; = "com.facebook.accountkit.AccessTokenManager.CachedAccessToken"


# instance fields
.field private final sharedPreferences:Landroid/content/SharedPreferences;


# direct methods
.method constructor <init>(Landroid/content/Context;)V
    .locals 2

    const-string v0, "com.facebook.accountkit.AccessTokenManager.SharedPreferences"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/AccessTokenCache;-><init>(Landroid/content/SharedPreferences;)V

    return-void
.end method

.method constructor <init>(Landroid/content/SharedPreferences;)V
    .locals 0
    .annotation build Landroid/support/annotation/VisibleForTesting;
    .end annotation

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AccessTokenCache;->sharedPreferences:Landroid/content/SharedPreferences;

    return-void
.end method

.method static deserializeAccessToken(Lorg/json/JSONObject;)Lcom/facebook/accountkit/AccessToken;
    .locals 9
    .annotation build Landroid/support/annotation/VisibleForTesting;
    .end annotation

    const-string v0, "version"

    invoke-virtual {p0, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    const/4 v1, 0x1

    if-le v0, v1, :cond_0

    new-instance p0, Lcom/facebook/accountkit/AccountKitException;

    sget-object v0, Lcom/facebook/accountkit/AccountKitError$Type;->INTERNAL_ERROR:Lcom/facebook/accountkit/AccountKitError$Type;

    sget-object v1, Lcom/facebook/accountkit/internal/InternalAccountKitError;->INVALID_ACCESS_TOKEN_FORMAT:Lcom/facebook/accountkit/internal/InternalAccountKitError;

    invoke-direct {p0, v0, v1}, Lcom/facebook/accountkit/AccountKitException;-><init>(Lcom/facebook/accountkit/AccountKitError$Type;Lcom/facebook/accountkit/internal/InternalAccountKitError;)V

    throw p0

    :cond_0
    new-instance v0, Lcom/facebook/accountkit/AccessToken;

    const-string v1, "token"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    const-string v1, "account_id"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v4

    const-string v1, "application_id"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    const-string v1, "tokenRefreshIntervalInSeconds"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v6

    new-instance v8, Ljava/util/Date;

    const-string v1, "last_refresh"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v1

    invoke-direct {v8, v1, v2}, Ljava/util/Date;-><init>(J)V

    move-object v2, v0

    invoke-direct/range {v2 .. v8}, Lcom/facebook/accountkit/AccessToken;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;JLjava/util/Date;)V

    return-object v0
.end method

.method static serializeAccessToken(Lcom/facebook/accountkit/AccessToken;)Lorg/json/JSONObject;
    .locals 4
    .annotation build Landroid/support/annotation/VisibleForTesting;
    .end annotation

    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "version"

    const/4 v2, 0x1

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "account_id"

    invoke-virtual {p0}, Lcom/facebook/accountkit/AccessToken;->getAccountId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "application_id"

    invoke-virtual {p0}, Lcom/facebook/accountkit/AccessToken;->getApplicationId()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    const-string v1, "tokenRefreshIntervalInSeconds"

    invoke-virtual {p0}, Lcom/facebook/accountkit/AccessToken;->getTokenRefreshIntervalSeconds()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v1, "last_refresh"

    invoke-virtual {p0}, Lcom/facebook/accountkit/AccessToken;->getLastRefresh()Ljava/util/Date;

    move-result-object v2

    invoke-virtual {v2}, Ljava/util/Date;->getTime()J

    move-result-wide v2

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v1, "token"

    invoke-virtual {p0}, Lcom/facebook/accountkit/AccessToken;->getToken()Ljava/lang/String;

    move-result-object p0

    invoke-virtual {v0, v1, p0}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    return-object v0
.end method


# virtual methods
.method public clear()V
    .locals 2

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccessTokenCache;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "com.facebook.accountkit.AccessTokenManager.CachedAccessToken"

    invoke-interface {v0, v1}, Landroid/content/SharedPreferences$Editor;->remove(Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    return-void
.end method

.method public load()Lcom/facebook/accountkit/AccessToken;
    .locals 3

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccessTokenCache;->sharedPreferences:Landroid/content/SharedPreferences;

    const-string v1, "com.facebook.accountkit.AccessTokenManager.CachedAccessToken"

    const/4 v2, 0x0

    invoke-interface {v0, v1, v2}, Landroid/content/SharedPreferences;->getString(Ljava/lang/String;Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    if-eqz v0, :cond_0

    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, v0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-static {v1}, Lcom/facebook/accountkit/internal/AccessTokenCache;->deserializeAccessToken(Lorg/json/JSONObject;)Lcom/facebook/accountkit/AccessToken;

    move-result-object v0
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    :cond_0
    return-object v2
.end method

.method public save(Lcom/facebook/accountkit/AccessToken;)V
    .locals 2
    .param p1    # Lcom/facebook/accountkit/AccessToken;
        .annotation build Landroid/support/annotation/NonNull;
        .end annotation
    .end param

    :try_start_0
    invoke-static {p1}, Lcom/facebook/accountkit/internal/AccessTokenCache;->serializeAccessToken(Lcom/facebook/accountkit/AccessToken;)Lorg/json/JSONObject;

    move-result-object p1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccessTokenCache;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    const-string v1, "com.facebook.accountkit.AccessTokenManager.CachedAccessToken"

    invoke-virtual {p1}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-interface {v0, v1, p1}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    move-result-object p1

    invoke-interface {p1}, Landroid/content/SharedPreferences$Editor;->apply()V
    :try_end_0
    .catch Lorg/json/JSONException; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
