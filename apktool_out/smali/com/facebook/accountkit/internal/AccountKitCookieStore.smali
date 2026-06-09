.class final Lcom/facebook/accountkit/internal/AccountKitCookieStore;
.super Ljava/lang/Object;

# interfaces
.implements Ljava/net/CookieStore;


# static fields
.field private static final ALLOW_PERSIST_COOKIE_NAMES:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final ALLOW_PERSIST_DOMAINS:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private static final SP_COOKIE_STORE:Ljava/lang/String; = "cookieStore"

.field private static final SP_KEY_DELIMITER:Ljava/lang/String; = "|"

.field private static final SP_KEY_DELIMITER_REGEX:Ljava/lang/String; = "\\|"


# instance fields
.field private final map:Ljava/util/Map;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/Map<",
            "Ljava/net/URI;",
            "Ljava/util/List<",
            "Ljava/net/HttpCookie;",
            ">;>;"
        }
    .end annotation
.end field

.field private final sharedPreferences:Landroid/content/SharedPreferences;


# direct methods
.method static constructor <clinit>()V
    .locals 2

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->ALLOW_PERSIST_DOMAINS:Ljava/util/List;

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    sput-object v0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->ALLOW_PERSIST_COOKIE_NAMES:Ljava/util/List;

    sget-object v0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->ALLOW_PERSIST_DOMAINS:Ljava/util/List;

    const-string v1, ".accountkit.com"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    sget-object v0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->ALLOW_PERSIST_COOKIE_NAMES:Ljava/util/List;

    const-string v1, "aksb"

    invoke-interface {v0, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    return-void
.end method

.method public constructor <init>(Landroid/content/Context;)V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iput-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    const-string v0, "cookieStore"

    const/4 v1, 0x0

    invoke-virtual {p1, v0, v1}, Landroid/content/Context;->getSharedPreferences(Ljava/lang/String;I)Landroid/content/SharedPreferences;

    move-result-object p1

    iput-object p1, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-direct {p0}, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->loadFromSharedPreferences()V

    return-void
.end method

.method private cookiesUri(Ljava/net/URI;)Ljava/net/URI;
    .locals 4

    const/4 v0, 0x0

    if-nez p1, :cond_0

    return-object v0

    :cond_0
    :try_start_0
    new-instance v1, Ljava/net/URI;

    const-string v2, "http"

    invoke-virtual {p1}, Ljava/net/URI;->getHost()Ljava/lang/String;

    move-result-object v3

    invoke-direct {v1, v2, v3, v0, v0}, Ljava/net/URI;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_0

    return-object v1

    :catch_0
    return-object p1
.end method

.method private loadFromSharedPreferences()V
    .locals 5

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->getAll()Ljava/util/Map;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v0

    invoke-interface {v0}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :catch_0
    :cond_0
    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_2

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/Map$Entry;

    invoke-interface {v1}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/lang/String;

    const-string v3, "\\|"

    const/4 v4, 0x2

    invoke-virtual {v2, v3, v4}, Ljava/lang/String;->split(Ljava/lang/String;I)[Ljava/lang/String;

    move-result-object v2

    :try_start_0
    new-instance v3, Ljava/net/URI;

    const/4 v4, 0x0

    aget-object v2, v2, v4

    invoke-direct {v3, v2}, Ljava/net/URI;-><init>(Ljava/lang/String;)V

    invoke-interface {v1}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    new-instance v2, Lcom/facebook/accountkit/internal/SerializableHttpCookie;

    invoke-direct {v2}, Lcom/facebook/accountkit/internal/SerializableHttpCookie;-><init>()V

    invoke-virtual {v2, v1}, Lcom/facebook/accountkit/internal/SerializableHttpCookie;->decode(Ljava/lang/String;)Ljava/net/HttpCookie;

    move-result-object v1

    if-eqz v1, :cond_0

    iget-object v2, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    invoke-interface {v2, v3}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    if-nez v2, :cond_1

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2}, Ljava/util/ArrayList;-><init>()V

    iget-object v4, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    invoke-interface {v4, v3, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_1
    invoke-interface {v2, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/net/URISyntaxException; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :cond_2
    return-void
.end method

.method private saveToSharedPreferences(Ljava/net/URI;Ljava/net/HttpCookie;)V
    .locals 2

    sget-object v0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->ALLOW_PERSIST_DOMAINS:Ljava/util/List;

    invoke-virtual {p2}, Ljava/net/HttpCookie;->getDomain()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    sget-object v0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->ALLOW_PERSIST_COOKIE_NAMES:Ljava/util/List;

    invoke-virtual {p2}, Ljava/net/HttpCookie;->getName()Ljava/lang/String;

    move-result-object v1

    invoke-interface {v0, v1}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->sharedPreferences:Landroid/content/SharedPreferences;

    invoke-interface {v0}, Landroid/content/SharedPreferences;->edit()Landroid/content/SharedPreferences$Editor;

    move-result-object v0

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {p1}, Ljava/net/URI;->toString()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string p1, "|"

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {p2}, Ljava/net/HttpCookie;->getName()Ljava/lang/String;

    move-result-object p1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object p1

    new-instance v1, Lcom/facebook/accountkit/internal/SerializableHttpCookie;

    invoke-direct {v1}, Lcom/facebook/accountkit/internal/SerializableHttpCookie;-><init>()V

    invoke-virtual {v1, p2}, Lcom/facebook/accountkit/internal/SerializableHttpCookie;->encode(Ljava/net/HttpCookie;)Ljava/lang/String;

    move-result-object p2

    invoke-interface {v0, p1, p2}, Landroid/content/SharedPreferences$Editor;->putString(Ljava/lang/String;Ljava/lang/String;)Landroid/content/SharedPreferences$Editor;

    invoke-interface {v0}, Landroid/content/SharedPreferences$Editor;->apply()V

    :cond_0
    return-void
.end method


# virtual methods
.method public declared-synchronized add(Ljava/net/URI;Ljava/net/HttpCookie;)V
    .locals 2

    monitor-enter p0

    if-nez p2, :cond_0

    :try_start_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "cookie == null"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    :catchall_0
    move-exception p1

    goto :goto_1

    :cond_0
    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->cookiesUri(Ljava/net/URI;)Ljava/net/URI;

    move-result-object p1

    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    invoke-interface {v1, p1, v0}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_0

    :cond_1
    invoke-interface {v0, p2}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    :goto_0
    invoke-interface {v0, p2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    invoke-direct {p0, p1, p2}, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->saveToSharedPreferences(Ljava/net/URI;Ljava/net/HttpCookie;)V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-void

    :goto_1
    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized get(Ljava/net/URI;)Ljava/util/List;
    .locals 6
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/net/URI;",
            ")",
            "Ljava/util/List<",
            "Ljava/net/HttpCookie;",
            ">;"
        }
    .end annotation

    monitor-enter p0

    if-nez p1, :cond_0

    :try_start_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string v0, "uri == null"

    invoke-direct {p1, v0}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    :catchall_0
    move-exception p1

    goto/16 :goto_3

    :cond_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    invoke-interface {v1, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/util/List;

    if-eqz v1, :cond_2

    invoke-interface {v1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :goto_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_2

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/net/HttpCookie;

    invoke-virtual {v2}, Ljava/net/HttpCookie;->hasExpired()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v1}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    :cond_1
    invoke-interface {v0, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_2
    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->entrySet()Ljava/util/Set;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Set;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_3
    :goto_1
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_8

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/Map$Entry;

    invoke-interface {v2}, Ljava/util/Map$Entry;->getKey()Ljava/lang/Object;

    move-result-object v3

    invoke-virtual {p1, v3}, Ljava/net/URI;->equals(Ljava/lang/Object;)Z

    move-result v3

    if-eqz v3, :cond_4

    goto :goto_1

    :cond_4
    invoke-interface {v2}, Ljava/util/Map$Entry;->getValue()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_5
    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/net/HttpCookie;

    invoke-virtual {v3}, Ljava/net/HttpCookie;->getDomain()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {p1}, Ljava/net/URI;->getHost()Ljava/lang/String;

    move-result-object v5

    invoke-static {v4, v5}, Ljava/net/HttpCookie;->domainMatches(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_6

    goto :goto_2

    :cond_6
    invoke-virtual {v3}, Ljava/net/HttpCookie;->hasExpired()Z

    move-result v4

    if-eqz v4, :cond_7

    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    goto :goto_2

    :cond_7
    invoke-interface {v0, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_5

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_2

    :cond_8
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object p1

    :goto_3
    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized getCookies()Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/net/HttpCookie;",
            ">;"
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    invoke-direct {v0}, Ljava/util/ArrayList;-><init>()V

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->values()Ljava/util/Collection;

    move-result-object v1

    invoke-interface {v1}, Ljava/util/Collection;->iterator()Ljava/util/Iterator;

    move-result-object v1

    :cond_0
    invoke-interface {v1}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_3

    invoke-interface {v1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Ljava/util/List;

    invoke-interface {v2}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :cond_1
    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Ljava/net/HttpCookie;

    invoke-virtual {v3}, Ljava/net/HttpCookie;->hasExpired()Z

    move-result v4

    if-eqz v4, :cond_2

    invoke-interface {v2}, Ljava/util/Iterator;->remove()V

    goto :goto_0

    :cond_2
    invoke-interface {v0, v3}, Ljava/util/List;->contains(Ljava/lang/Object;)Z

    move-result v4

    if-nez v4, :cond_1

    invoke-interface {v0, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    goto :goto_0

    :cond_3
    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized getURIs()Ljava/util/List;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()",
            "Ljava/util/List<",
            "Ljava/net/URI;",
            ">;"
        }
    .end annotation

    monitor-enter p0

    :try_start_0
    new-instance v0, Ljava/util/ArrayList;

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->keySet()Ljava/util/Set;

    move-result-object v1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(Ljava/util/Collection;)V

    const/4 v1, 0x0

    invoke-interface {v0, v1}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    invoke-static {v0}, Ljava/util/Collections;->unmodifiableList(Ljava/util/List;)Ljava/util/List;

    move-result-object v0
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return-object v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method

.method public declared-synchronized remove(Ljava/net/URI;Ljava/net/HttpCookie;)Z
    .locals 1

    monitor-enter p0

    if-nez p2, :cond_0

    :try_start_0
    new-instance p1, Ljava/lang/NullPointerException;

    const-string p2, "cookie == null"

    invoke-direct {p1, p2}, Ljava/lang/NullPointerException;-><init>(Ljava/lang/String;)V

    throw p1

    :catchall_0
    move-exception p1

    goto :goto_0

    :cond_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    invoke-direct {p0, p1}, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->cookiesUri(Ljava/net/URI;)Ljava/net/URI;

    move-result-object p1

    invoke-interface {v0, p1}, Ljava/util/Map;->get(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object p1

    check-cast p1, Ljava/util/List;

    if-eqz p1, :cond_1

    invoke-interface {p1, p2}, Ljava/util/List;->remove(Ljava/lang/Object;)Z

    move-result p1
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return p1

    :cond_1
    const/4 p1, 0x0

    monitor-exit p0

    return p1

    :goto_0
    monitor-exit p0

    throw p1
.end method

.method public declared-synchronized removeAll()Z
    .locals 2

    monitor-enter p0

    :try_start_0
    iget-object v0, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    invoke-interface {v0}, Ljava/util/Map;->isEmpty()Z

    move-result v0

    xor-int/lit8 v0, v0, 0x1

    iget-object v1, p0, Lcom/facebook/accountkit/internal/AccountKitCookieStore;->map:Ljava/util/Map;

    invoke-interface {v1}, Ljava/util/Map;->clear()V
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    monitor-exit p0

    return v0

    :catchall_0
    move-exception v0

    monitor-exit p0

    throw v0
.end method
