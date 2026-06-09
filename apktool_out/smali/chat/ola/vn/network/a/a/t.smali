.class public Lchat/ola/vn/network/a/a/t;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Lchat/ola/vn/entity/f;",
        ">;"
    }
.end annotation


# instance fields
.field public c:Lchat/ola/vn/p/c;

.field private d:J


# direct methods
.method public constructor <init>(JJ)V
    .locals 0

    invoke-direct {p0, p3, p4}, Lchat/ola/vn/entity/m;-><init>(J)V

    iput-wide p1, p0, Lchat/ola/vn/network/a/a/t;->d:J

    return-void
.end method

.method private a(Ljava/lang/String;Lorg/json/JSONObject;)Lchat/ola/vn/entity/f;
    .locals 5

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/f;

    invoke-direct {v0}, Lchat/ola/vn/entity/f;-><init>()V

    iput-object p1, v0, Lchat/ola/vn/entity/f;->k:Ljava/lang/String;

    iget-wide v1, p0, Lchat/ola/vn/network/a/a/t;->d:J

    iput-wide v1, v0, Lchat/ola/vn/entity/f;->c:J

    const-string v1, "url"

    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "url"

    invoke-virtual {p2, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "rss"

    invoke-static {p1, v2}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_0

    new-instance p1, Lchat/ola/vn/entity/d;

    const-string v2, "rss"

    invoke-direct {p1, v2}, Lchat/ola/vn/entity/d;-><init>(Ljava/lang/String;)V

    iput-object p1, v0, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    iget-object p1, v0, Lchat/ola/vn/entity/f;->b:Lchat/ola/vn/entity/d;

    invoke-virtual {p1, v1}, Lchat/ola/vn/entity/d;->b(Ljava/lang/String;)V

    :cond_0
    const-string p1, "title"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_1

    const-string p1, "title"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/entity/f;->l:Ljava/lang/String;

    :cond_1
    const-string p1, "intro"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_2

    const-string p1, "intro"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/entity/f;->m:Ljava/lang/String;

    :cond_2
    const-string p1, "media"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_3

    const-string p1, "media"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object p1

    iput-object p1, v0, Lchat/ola/vn/entity/f;->e:Ljava/lang/String;

    :cond_3
    const-string p1, "noLikes"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_4

    const-string p1, "noLikes"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result p1

    iput p1, v0, Lchat/ola/vn/entity/f;->r:I

    :cond_4
    const-string p1, "liked"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_5

    const-string p1, "liked"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result p1

    invoke-virtual {v0, p1}, Lchat/ola/vn/entity/f;->a(S)V

    :cond_5
    const-string p1, "likes"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-eqz p1, :cond_6

    :try_start_1
    const-string p1, "likes"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_6

    new-array v2, v1, [Ljava/lang/String;

    iput-object v2, v0, Lchat/ola/vn/entity/f;->i:[Ljava/lang/String;

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_6

    iget-object v3, v0, Lchat/ola/vn/entity/f;->i:[Ljava/lang/String;

    invoke-virtual {p1, v2}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v2
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :catch_0
    :cond_6
    :try_start_2
    const-string p1, "noComments"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result p1

    if-eqz p1, :cond_7

    const-string p1, "noComments"

    invoke-virtual {p2, p1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result p1

    iput p1, v0, Lchat/ola/vn/entity/f;->t:I
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :cond_7
    return-object v0

    :catch_1
    const/4 p1, 0x0

    return-object p1
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/t;->b([B)Lchat/ola/vn/entity/f;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 3

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v1, "me/attachs/"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-wide v1, p0, Lchat/ola/vn/network/a/a/t;->d:J

    invoke-virtual {v0, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    const/4 v1, 0x0

    const/4 v2, 0x1

    invoke-static {v1, v0, v1, v2}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(Lchat/ola/vn/entity/f;)V
    .locals 3

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p1, Lchat/ola/vn/entity/f;->k:Ljava/lang/String;

    const-string v1, "rss"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/network/a/a/t;->c:Lchat/ola/vn/p/c;

    iget-wide v1, p0, Lchat/ola/vn/network/a/a/t;->d:J

    invoke-interface {v0, v1, v2, p1}, Lchat/ola/vn/p/c;->a(JLchat/ola/vn/entity/f;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-void

    :cond_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/t;->b(Ljava/lang/String;)V

    :catch_0
    :cond_1
    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/f;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/t;->a(Lchat/ola/vn/entity/f;)V

    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/f;
    .locals 2

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const-string v0, "type"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "type"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    const-string v1, "rss"

    invoke-static {v0, v1}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    invoke-direct {p0, v0, p1}, Lchat/ola/vn/network/a/a/t;->a(Ljava/lang/String;Lorg/json/JSONObject;)Lchat/ola/vn/entity/f;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    :cond_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public b(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/network/a/a/t;->c:Lchat/ola/vn/p/c;

    iget-wide v0, p0, Lchat/ola/vn/network/a/a/t;->d:J

    invoke-interface {p1, v0, v1}, Lchat/ola/vn/p/c;->a(J)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method
