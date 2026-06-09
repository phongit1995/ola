.class public Lchat/ola/vn/network/a/a/q;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Lchat/ola/vn/entity/e;",
        ">;"
    }
.end annotation


# instance fields
.field public c:Lchat/ola/vn/p/b;

.field d:I

.field private e:Ljava/lang/String;

.field private f:Ljava/lang/String;


# direct methods
.method public constructor <init>(J)V
    .locals 0

    invoke-direct {p0, p1, p2}, Lchat/ola/vn/entity/m;-><init>(J)V

    const/4 p1, 0x0

    iput p1, p0, Lchat/ola/vn/network/a/a/q;->d:I

    return-void
.end method

.method public constructor <init>(Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/entity/m;-><init>(J)V

    const/4 p2, 0x0

    iput p2, p0, Lchat/ola/vn/network/a/a/q;->d:I

    iput-object p1, p0, Lchat/ola/vn/network/a/a/q;->e:Ljava/lang/String;

    return-void
.end method

.method private a(Lorg/json/JSONObject;)Lchat/ola/vn/entity/e;
    .locals 1

    :try_start_0
    const-string v0, "code"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_0

    const-string v0, "code"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    invoke-static {v0}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v0

    iput v0, p0, Lchat/ola/vn/network/a/a/q;->d:I

    :cond_0
    const-string v0, "payload"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    const-string v0, "payload"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object p1

    :cond_1
    invoke-direct {p0, p1}, Lchat/ola/vn/network/a/a/q;->b(Lorg/json/JSONObject;)Lchat/ola/vn/entity/e;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method private a(Lorg/json/JSONArray;)Ljava/util/List;
    .locals 5
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lorg/json/JSONArray;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/e;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    const/4 v1, 0x0

    :try_start_0
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v2
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    :goto_0
    if-ge v0, v2, :cond_1

    :try_start_1
    invoke-virtual {p1, v0}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    if-nez v1, :cond_0

    new-instance v4, Ljava/util/ArrayList;

    invoke-direct {v4}, Ljava/util/ArrayList;-><init>()V

    move-object v1, v4

    :cond_0
    invoke-direct {p0, v3}, Lchat/ola/vn/network/a/a/q;->b(Lorg/json/JSONObject;)Lchat/ola/vn/entity/e;

    move-result-object v3

    invoke-interface {v1, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    goto :goto_1

    :catch_0
    move-exception v3

    :try_start_2
    invoke-virtual {v3}, Ljava/lang/Throwable;->printStackTrace()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_1

    :goto_1
    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :catch_1
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :cond_1
    return-object v1
.end method

.method private b(Lorg/json/JSONObject;)Lchat/ola/vn/entity/e;
    .locals 7

    :try_start_0
    new-instance v0, Lchat/ola/vn/entity/e;

    invoke-direct {v0}, Lchat/ola/vn/entity/e;-><init>()V

    const-string v1, "url"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "url"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->f(Ljava/lang/String;)V

    :cond_0
    const-string v1, "title"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "title"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_0
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->h(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    const-string v1, "name"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v1, "name"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_2
    :goto_1
    const-string v1, "id"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    const-string v1, "id"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->g(Ljava/lang/String;)V

    :cond_3
    const-string v1, "originalCode"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    const-string v1, "originalCode"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->i(Ljava/lang/String;)V

    :cond_4
    const-string v1, "hqThumbnailUrl"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    const-string v1, "hqThumbnailUrl"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_2
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->c(Ljava/lang/String;)V

    goto :goto_3

    :cond_5
    const-string v1, "hqThumb"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_6

    const-string v1, "hqThumb"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_2

    :cond_6
    :goto_3
    const-string v1, "mqThumbnailUrl"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_7

    const-string v1, "mqThumbnailUrl"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_4
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->d(Ljava/lang/String;)V

    goto :goto_5

    :cond_7
    const-string v1, "mqThumb"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_8

    const-string v1, "mqThumb"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_4

    :cond_8
    :goto_5
    const-string v1, "sqThumbnailUrl"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_9

    const-string v1, "sqThumbnailUrl"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    :goto_6
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->e(Ljava/lang/String;)V

    goto :goto_7

    :cond_9
    const-string v1, "sqThumb"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_a

    const-string v1, "sqThumb"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    goto :goto_6

    :cond_a
    :goto_7
    const-string v1, "icon"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_b

    const-string v1, "icon"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->a(Ljava/lang/String;)V

    :cond_b
    const-string v1, "hitUrl"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_c

    const-string v1, "hitUrl"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->j(Ljava/lang/String;)V

    :cond_c
    const-string v1, "duration"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_2

    if-eqz v1, :cond_d

    :try_start_1
    const-string v1, "duration"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Integer;->parseInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->d(I)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_d
    :try_start_2
    const-string v1, "nextUrl"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_e

    const-string v1, "nextUrl"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Ljava/lang/String;)V

    :cond_e
    const-string v1, "desc"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_f

    const-string v1, "desc"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->k(Ljava/lang/String;)V

    :cond_f
    const-string v1, "resultNo"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_10

    const-string v1, "resultNo"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->h(I)V

    :cond_10
    const-string v1, "outlayMillis"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_11

    const-string v1, "outlayMillis"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->i(I)V

    :cond_11
    const-string v1, "searching"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_12

    const-string v1, "searching"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    invoke-direct {p0, v1}, Lchat/ola/vn/network/a/a/q;->b(Lorg/json/JSONObject;)Lchat/ola/vn/entity/e;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->g(Lchat/ola/vn/entity/e;)V

    :cond_12
    const-string v1, "replacing"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_13

    const-string v1, "replacing"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    invoke-direct {p0, v1}, Lchat/ola/vn/network/a/a/q;->b(Lorg/json/JSONObject;)Lchat/ola/vn/entity/e;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->h(Lchat/ola/vn/entity/e;)V

    :cond_13
    const-string v1, "meId"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_14

    const-string v1, "meId"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v1

    invoke-virtual {v0, v1, v2}, Lchat/ola/vn/entity/e;->b(J)V

    :cond_14
    const-string v1, "createTime"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_15

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v1

    const-string v3, "createTime"

    invoke-virtual {p1, v3}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Ljava/lang/Long;->parseLong(Ljava/lang/String;)J

    move-result-wide v3

    const/4 v5, 0x0

    sub-long v5, v1, v3

    invoke-virtual {v0, v5, v6}, Lchat/ola/vn/entity/e;->c(J)V

    :cond_15
    const-string v1, "hit"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_16

    const-string v1, "hit"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->e(I)V

    :cond_16
    const-string v1, "type"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_17

    const-string v1, "type"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    int-to-short v1, v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->f(I)V

    :cond_17
    const-string v1, "tags"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_18

    const-string v1, "tags"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v1

    invoke-direct {p0, v1}, Lchat/ola/vn/network/a/a/q;->a(Lorg/json/JSONArray;)Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->c(Ljava/util/List;)V

    :cond_18
    const-string v1, "provider"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1d

    const-string v1, "provider"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "DA"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->d(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_19

    const/4 v1, 0x4

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->a(S)V

    goto :goto_8

    :cond_19
    const-string v2, "PA"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->d(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1a

    const/4 v1, 0x5

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->a(S)V

    goto :goto_8

    :cond_1a
    const-string v2, "IMG"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->d(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1b

    const/4 v1, 0x3

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->a(S)V

    goto :goto_8

    :cond_1b
    const-string v2, "OM"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->d(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1c

    const/4 v1, 0x2

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->a(S)V

    goto :goto_8

    :cond_1c
    const-string v2, "TY"

    invoke-static {v1, v2}, Lchat/ola/vn/util/m;->d(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1d

    const/4 v1, 0x1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->a(S)V

    :cond_1d
    :goto_8
    const-string v1, "quantity"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1f

    const-string v1, "quantity"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->c(I)V

    const-string v1, "thumbnails"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1f

    new-instance v1, Ljava/util/ArrayList;

    invoke-direct {v1}, Ljava/util/ArrayList;-><init>()V

    const-string v2, "thumbnails"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    const/4 v3, 0x0

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v4

    :goto_9
    if-ge v3, v4, :cond_1e

    invoke-virtual {v2, v3}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v5

    invoke-interface {v1, v5}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v3, v3, 0x1

    goto :goto_9

    :cond_1e
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->d(Ljava/util/List;)V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_2

    :cond_1f
    :try_start_3
    const-string v1, "like"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_20

    const-string v1, "like"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->a(Z)V
    :try_end_3
    .catch Ljava/lang/Exception; {:try_start_3 .. :try_end_3} :catch_1
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_2

    goto :goto_a

    :catch_1
    move-exception v1

    :try_start_4
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    :cond_20
    :goto_a
    const-string v1, "favoriteNo"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_21

    const-string v1, "favoriteNo"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->a(I)V

    :cond_21
    const-string v1, "commentNo"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_22

    const-string v1, "commentNo"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(I)V

    :cond_22
    const-string v1, "content"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_24

    const-string v1, "content"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/network/a/a/q;->a(Lorg/json/JSONArray;)Ljava/util/List;

    move-result-object p1

    if-eqz p1, :cond_24

    invoke-interface {p1}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object p1

    :goto_b
    invoke-interface {p1}, Ljava/util/Iterator;->hasNext()Z

    move-result v1

    if-eqz v1, :cond_24

    invoke-interface {p1}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lchat/ola/vn/entity/e;

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->E()I

    move-result v2

    packed-switch v2, :pswitch_data_0

    packed-switch v2, :pswitch_data_1

    goto :goto_b

    :pswitch_0
    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->E()I

    move-result v2

    const/4 v3, -0x4

    if-ne v2, v3, :cond_23

    :goto_c
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->a(Lchat/ola/vn/entity/e;)V

    goto :goto_b

    :cond_23
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->e(Lchat/ola/vn/entity/e;)V

    goto :goto_b

    :pswitch_1
    invoke-virtual {v0}, Lchat/ola/vn/entity/e;->E()I

    move-result v2

    const/4 v3, -0x3

    if-ne v2, v3, :cond_23

    goto :goto_c

    :pswitch_2
    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->w()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->l(Ljava/util/List;)V

    goto :goto_b

    :pswitch_3
    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->w()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/entity/e;->k(Ljava/util/List;)V

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->L()I

    move-result v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/entity/e;->h(I)V

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->N()Lchat/ola/vn/entity/e;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/entity/e;->g(Lchat/ola/vn/entity/e;)V

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->O()Lchat/ola/vn/entity/e;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/entity/e;->h(Lchat/ola/vn/entity/e;)V

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->M()I

    move-result v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->i(I)V

    goto :goto_b

    :pswitch_4
    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->w()Ljava/util/List;

    move-result-object v2

    invoke-virtual {v0, v2}, Lchat/ola/vn/entity/e;->g(Ljava/util/List;)V

    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->h()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->b(Ljava/lang/String;)V

    goto :goto_b

    :pswitch_5
    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->w()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->f(Ljava/util/List;)V

    goto :goto_b

    :pswitch_6
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->f(Lchat/ola/vn/entity/e;)V

    goto :goto_b

    :pswitch_7
    invoke-virtual {v1}, Lchat/ola/vn/entity/e;->m()Ljava/util/List;

    move-result-object v1

    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->e(Ljava/util/List;)V

    goto :goto_b

    :pswitch_8
    invoke-virtual {v0, v1}, Lchat/ola/vn/entity/e;->d(Lchat/ola/vn/entity/e;)V
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_2

    goto/16 :goto_b

    :cond_24
    return-object v0

    :catch_2
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    const/4 p1, 0x0

    return-object p1

    nop

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_8
        :pswitch_7
        :pswitch_6
        :pswitch_5
        :pswitch_4
        :pswitch_3
        :pswitch_2
    .end packed-switch

    :pswitch_data_1
    .packed-switch 0x64
        :pswitch_1
        :pswitch_0
        :pswitch_1
    .end packed-switch
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/q;->b([B)Lchat/ola/vn/entity/e;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 4

    iget-object v0, p0, Lchat/ola/vn/network/a/a/q;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-nez v0, :cond_0

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "mall/getTow?towId="

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v3, p0, Lchat/ola/vn/network/a/a/q;->e:Ljava/lang/String;

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_0
    invoke-static {v2, v0, v2, v1}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/q;->f:Ljava/lang/String;

    if-eqz v0, :cond_2

    iget-object v0, p0, Lchat/ola/vn/network/a/a/q;->f:Ljava/lang/String;

    const-string v3, "/"

    invoke-virtual {v0, v3}, Ljava/lang/String;->equalsIgnoreCase(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_1

    goto :goto_1

    :cond_1
    iget-object v0, p0, Lchat/ola/vn/network/a/a/q;->f:Ljava/lang/String;

    goto :goto_0

    :cond_2
    :goto_1
    const-string v0, "mall/"

    goto :goto_0
.end method

.method public a(Lchat/ola/vn/entity/e;)V
    .locals 3

    if-eqz p1, :cond_0

    :try_start_0
    iget v0, p0, Lchat/ola/vn/network/a/a/q;->d:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    if-nez v0, :cond_0

    :try_start_1
    iget-object v0, p0, Lchat/ola/vn/network/a/a/q;->c:Lchat/ola/vn/p/b;

    iget-object v1, p0, Lchat/ola/vn/network/a/a/q;->e:Ljava/lang/String;

    iget-object v2, p0, Lchat/ola/vn/network/a/a/q;->f:Ljava/lang/String;

    invoke-interface {v0, v1, v2, p1}, Lchat/ola/vn/p/b;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entity/e;)V
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    return-void

    :catch_1
    :cond_0
    const/4 p1, 0x0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/q;->b(Ljava/lang/String;)V

    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/e;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/q;->a(Lchat/ola/vn/entity/e;)V

    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/e;
    .locals 0

    :try_start_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    invoke-direct {p0, p1}, Lchat/ola/vn/network/a/a/q;->a(Lorg/json/JSONObject;)Lchat/ola/vn/entity/e;

    move-result-object p1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p1

    :catch_0
    const/4 p1, 0x0

    return-object p1
.end method

.method public b(Ljava/lang/String;)V
    .locals 2

    :try_start_0
    iget-object p1, p0, Lchat/ola/vn/network/a/a/q;->c:Lchat/ola/vn/p/b;

    iget-object v0, p0, Lchat/ola/vn/network/a/a/q;->e:Ljava/lang/String;

    iget-object v1, p0, Lchat/ola/vn/network/a/a/q;->f:Ljava/lang/String;

    invoke-interface {p1, v0, v1}, Lchat/ola/vn/p/b;->a(Ljava/lang/String;Ljava/lang/String;)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/q;->f:Ljava/lang/String;

    return-void
.end method
