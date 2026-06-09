.class public Lchat/ola/vn/me/a;
.super Ljava/lang/Object;


# instance fields
.field protected a:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ab;",
            ">;"
        }
    .end annotation
.end field

.field protected b:Lchat/ola/vn/entity/w;

.field protected c:Ljava/lang/String;

.field protected d:Ljava/lang/String;

.field protected e:Ljava/lang/String;

.field protected f:Ljava/lang/String;

.field protected g:Ljava/lang/String;

.field protected h:J

.field protected i:J

.field protected j:S

.field protected k:B

.field protected l:Z

.field protected m:Z

.field protected n:Z

.field private o:J

.field private p:I

.field private q:I

.field private r:I


# direct methods
.method public constructor <init>()V
    .locals 2

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    const/4 v0, 0x0

    iput-object v0, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/me/a;->d:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/me/a;->e:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/me/a;->f:Ljava/lang/String;

    iput-object v0, p0, Lchat/ola/vn/me/a;->g:Ljava/lang/String;

    const-wide/16 v0, 0x0

    iput-wide v0, p0, Lchat/ola/vn/me/a;->h:J

    iput-wide v0, p0, Lchat/ola/vn/me/a;->i:J

    iput-wide v0, p0, Lchat/ola/vn/me/a;->o:J

    const/4 v0, 0x0

    iput v0, p0, Lchat/ola/vn/me/a;->p:I

    iput v0, p0, Lchat/ola/vn/me/a;->q:I

    iput v0, p0, Lchat/ola/vn/me/a;->r:I

    const/4 v1, 0x2

    iput-short v1, p0, Lchat/ola/vn/me/a;->j:S

    iput-byte v0, p0, Lchat/ola/vn/me/a;->k:B

    iput-boolean v0, p0, Lchat/ola/vn/me/a;->l:Z

    const/4 v1, 0x1

    iput-boolean v1, p0, Lchat/ola/vn/me/a;->m:Z

    iput-boolean v0, p0, Lchat/ola/vn/me/a;->n:Z

    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v0

    iput-wide v0, p0, Lchat/ola/vn/me/a;->o:J

    return-void
.end method

.method static synthetic a(Lchat/ola/vn/me/a;)I
    .locals 1

    iget v0, p0, Lchat/ola/vn/me/a;->q:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lchat/ola/vn/me/a;->q:I

    return v0
.end method

.method public static a(Ljava/lang/String;)Lchat/ola/vn/me/a;
    .locals 1

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0, p0}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    invoke-static {v0}, Lchat/ola/vn/me/a;->a(Lorg/json/JSONObject;)Lchat/ola/vn/me/a;

    move-result-object p0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object p0

    :catch_0
    const/4 p0, 0x0

    return-object p0
.end method

.method public static a(Lorg/json/JSONObject;)Lchat/ola/vn/me/a;
    .locals 5

    :try_start_0
    new-instance v0, Lchat/ola/vn/me/a;

    invoke-direct {v0}, Lchat/ola/vn/me/a;-><init>()V

    const-string v1, "meDraftId"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/me/a;->o:J

    const-string v1, "lastModifiedTime"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/me/a;->i:J

    const-string v1, "state"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    int-to-byte v1, v1

    iput-byte v1, v0, Lchat/ola/vn/me/a;->k:B

    const-string v1, "editPrivacy"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    int-to-short v1, v1

    iput-short v1, v0, Lchat/ola/vn/me/a;->j:S

    const-string v1, "commentMeId"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v1

    iput-wide v1, v0, Lchat/ola/vn/me/a;->h:J

    const-string v1, "updateStatus"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_0

    const-string v1, "updateStatus"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, v0, Lchat/ola/vn/me/a;->l:Z

    :cond_0
    const-string v1, "commentRss"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    const-string v1, "commentRss"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, v0, Lchat/ola/vn/me/a;->n:Z

    :cond_1
    const-string v1, "postStatusToMePage"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_2

    const-string v1, "postStatusToMePage"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v1

    iput-boolean v1, v0, Lchat/ola/vn/me/a;->m:Z

    :cond_2
    const-string v1, "text"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_3

    const-string v1, "text"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    :cond_3
    const-string v1, "sticker"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_4

    const-string v1, "sticker"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v1

    invoke-static {v1}, Lchat/ola/vn/entity/w;->a(Lorg/json/JSONObject;)Lchat/ola/vn/entity/w;

    move-result-object v1

    iput-object v1, v0, Lchat/ola/vn/me/a;->b:Lchat/ola/vn/entity/w;

    :cond_4
    const-string v1, "attachedPhotoList"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_5

    const-string v1, "attachedPhotoList"

    invoke-virtual {p0, v1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p0

    invoke-virtual {p0}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_5

    new-instance v2, Ljava/util/ArrayList;

    invoke-direct {v2, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v2, v0, Lchat/ola/vn/me/a;->a:Ljava/util/List;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_1

    const/4 v2, 0x0

    :goto_0
    if-ge v2, v1, :cond_5

    :try_start_1
    invoke-virtual {p0, v2}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/entity/ab;->a(Lorg/json/JSONObject;)Lchat/ola/vn/entity/ab;

    move-result-object v3

    iget-object v4, v0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    invoke-interface {v4, v3}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_5
    return-object v0

    :catch_1
    const/4 p0, 0x0

    return-object p0
.end method

.method static synthetic b(Lchat/ola/vn/me/a;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/me/a;->p:I

    return p0
.end method

.method static synthetic c(Lchat/ola/vn/me/a;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/me/a;->q:I

    return p0
.end method

.method private c()V
    .locals 12

    const-string v0, ""

    iget-object v1, p0, Lchat/ola/vn/me/a;->b:Lchat/ola/vn/entity/w;

    const/4 v2, 0x0

    if-eqz v1, :cond_0

    iget-object v1, p0, Lchat/ola/vn/me/a;->b:Lchat/ola/vn/entity/w;

    invoke-virtual {v1}, Lchat/ola/vn/entity/w;->a()Ljava/lang/String;

    move-result-object v1

    goto :goto_0

    :cond_0
    move-object v1, v2

    :goto_0
    iget-object v3, p0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    if-eqz v3, :cond_3

    const/4 v3, 0x0

    iget-object v4, p0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    invoke-interface {v4}, Ljava/util/List;->size()I

    move-result v4

    :goto_1
    if-ge v3, v4, :cond_3

    iget-object v5, p0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    invoke-interface {v5, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v5

    check-cast v5, Lchat/ola/vn/entity/ab;

    if-nez v1, :cond_1

    iget-object v1, v5, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    goto :goto_2

    :cond_1
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v6

    if-eqz v6, :cond_2

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v6, "##"

    invoke-virtual {v0, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v5, v5, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v5, "#"

    invoke-virtual {v0, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_2

    :cond_2
    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " ##"

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, v5, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, "#"

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v6}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :goto_2
    add-int/lit8 v3, v3, 0x1

    goto :goto_1

    :cond_3
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_5

    iget-object v3, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_4

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v0, " "

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v0, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    invoke-virtual {v3, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    :cond_4
    iput-object v0, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    :cond_5
    iget-object v0, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_6

    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "##"

    invoke-virtual {v0, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v1, "#"

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    iput-object v0, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    move-object v1, v2

    :cond_6
    iget-object v0, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_10

    :cond_7
    new-instance v0, Lchat/ola/vn/me/a$2;

    invoke-direct {v0, p0}, Lchat/ola/vn/me/a$2;-><init>(Lchat/ola/vn/me/a;)V

    iget-boolean v3, p0, Lchat/ola/vn/me/a;->l:Z

    if-eqz v3, :cond_a

    iget-object v3, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_9

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-eqz v4, :cond_8

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    const-string v4, "##"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, "#"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    goto :goto_3

    :cond_8
    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, " ##"

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, "#"

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    :cond_9
    :goto_3
    sget-object v4, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    invoke-virtual {v4, v3}, Lchat/ola/vn/network/OlaNetworkService;->h(Ljava/lang/String;)V

    iget-boolean v3, p0, Lchat/ola/vn/me/a;->m:Z

    if-nez v3, :cond_a

    return-void

    :cond_a
    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_b

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v3

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_b

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v3, ":"

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v3

    invoke-virtual {v3}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v3

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    :cond_b
    iget-wide v3, p0, Lchat/ola/vn/me/a;->h:J

    const-wide/16 v5, 0x0

    cmp-long v7, v3, v5

    if-lez v7, :cond_d

    iget-boolean v3, p0, Lchat/ola/vn/me/a;->n:Z

    if-eqz v3, :cond_c

    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    iget-wide v5, p0, Lchat/ola/vn/me/a;->h:J

    const/4 v8, 0x0

    iget-short v9, p0, Lchat/ola/vn/me/a;->j:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v11

    move-object v7, v1

    move-object v10, v2

    invoke-virtual/range {v3 .. v11}, Lchat/ola/vn/network/OlaNetworkService;->b(Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;S)V

    return-void

    :cond_c
    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    iget-wide v5, p0, Lchat/ola/vn/me/a;->h:J

    const/4 v8, 0x0

    iget-short v9, p0, Lchat/ola/vn/me/a;->j:S

    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v11

    move-object v7, v1

    move-object v10, v2

    invoke-virtual/range {v3 .. v11}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;JLjava/lang/String;SSLjava/lang/String;S)V

    return-void

    :cond_d
    iget-object v3, p0, Lchat/ola/vn/me/a;->e:Ljava/lang/String;

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_e

    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    const/4 v6, 0x0

    iget-short v7, p0, Lchat/ola/vn/me/a;->j:S

    iget-object v9, p0, Lchat/ola/vn/me/a;->e:Ljava/lang/String;

    :goto_4
    invoke-static {v0}, Lchat/ola/vn/entry/c/f;->a(Lchat/ola/vn/entry/c/e;)S

    move-result v10

    move-object v5, v1

    move-object v8, v2

    invoke-virtual/range {v3 .. v10}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;SSLjava/lang/String;Ljava/lang/String;S)V

    return-void

    :cond_e
    iget-object v3, p0, Lchat/ola/vn/me/a;->d:Ljava/lang/String;

    invoke-static {v3}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_f

    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/me/a;->f:Ljava/lang/String;

    iget-object v5, p0, Lchat/ola/vn/me/a;->d:Ljava/lang/String;

    iget-object v6, p0, Lchat/ola/vn/me/a;->g:Ljava/lang/String;

    new-instance v7, Lchat/ola/vn/me/a$3;

    invoke-direct {v7, p0, v1, v2, v0}, Lchat/ola/vn/me/a$3;-><init>(Lchat/ola/vn/me/a;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/entry/c/e;)V

    invoke-virtual {v3, v4, v5, v6, v7}, Lchat/ola/vn/network/OlaNetworkService;->a(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/p/a;)V

    return-void

    :cond_f
    sget-object v3, Lchat/ola/vn/OlaApplication;->b:Lchat/ola/vn/network/OlaNetworkService;

    iget-object v4, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    const/4 v6, 0x0

    iget-short v7, p0, Lchat/ola/vn/me/a;->j:S

    const/4 v9, 0x0

    goto :goto_4

    :cond_10
    return-void
.end method

.method static synthetic d(Lchat/ola/vn/me/a;)I
    .locals 0

    iget p0, p0, Lchat/ola/vn/me/a;->r:I

    return p0
.end method

.method private d()V
    .locals 2

    invoke-static {}, Lchat/ola/vn/OlaApplication;->a()Landroid/content/Context;

    move-result-object v0

    const v1, 0x7f0f025a

    invoke-static {v1}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v1

    invoke-static {v0, v1}, Lchat/ola/vn/util/c/c;->a(Landroid/content/Context;Ljava/lang/String;)V

    return-void
.end method

.method static synthetic e(Lchat/ola/vn/me/a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/a;->d()V

    return-void
.end method

.method static synthetic f(Lchat/ola/vn/me/a;)V
    .locals 0

    invoke-direct {p0}, Lchat/ola/vn/me/a;->c()V

    return-void
.end method

.method static synthetic g(Lchat/ola/vn/me/a;)I
    .locals 1

    iget v0, p0, Lchat/ola/vn/me/a;->p:I

    add-int/lit8 v0, v0, 0x1

    iput v0, p0, Lchat/ola/vn/me/a;->p:I

    return v0
.end method


# virtual methods
.method public a()Lorg/json/JSONObject;
    .locals 5

    :try_start_0
    new-instance v0, Lorg/json/JSONObject;

    invoke-direct {v0}, Lorg/json/JSONObject;-><init>()V

    const-string v1, "meDraftId"

    iget-wide v2, p0, Lchat/ola/vn/me/a;->o:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v1, "lastModifiedTime"

    iget-wide v2, p0, Lchat/ola/vn/me/a;->i:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v1, "state"

    iget-byte v2, p0, Lchat/ola/vn/me/a;->k:B

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "editPrivacy"

    iget-short v2, p0, Lchat/ola/vn/me/a;->j:S

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;I)Lorg/json/JSONObject;

    const-string v1, "commentMeId"

    iget-wide v2, p0, Lchat/ola/vn/me/a;->h:J

    invoke-virtual {v0, v1, v2, v3}, Lorg/json/JSONObject;->put(Ljava/lang/String;J)Lorg/json/JSONObject;

    const-string v1, "updateStatus"

    iget-boolean v2, p0, Lchat/ola/vn/me/a;->l:Z

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v1, "postStatusToMePage"

    iget-boolean v2, p0, Lchat/ola/vn/me/a;->m:Z

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    const-string v1, "commentRss"

    iget-boolean v2, p0, Lchat/ola/vn/me/a;->n:Z

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Z)Lorg/json/JSONObject;

    iget-object v1, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_0

    const-string v1, "text"

    iget-object v2, p0, Lchat/ola/vn/me/a;->c:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_0
    iget-object v1, p0, Lchat/ola/vn/me/a;->b:Lchat/ola/vn/entity/w;

    if-eqz v1, :cond_1

    iget-object v1, p0, Lchat/ola/vn/me/a;->b:Lchat/ola/vn/entity/w;

    invoke-virtual {v1}, Lchat/ola/vn/entity/w;->b()Lorg/json/JSONObject;

    move-result-object v1

    if-eqz v1, :cond_1

    const-string v2, "sticker"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;

    :cond_1
    iget-object v1, p0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    if-eqz v1, :cond_4

    iget-object v1, p0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_4

    new-instance v1, Lorg/json/JSONArray;

    invoke-direct {v1}, Lorg/json/JSONArray;-><init>()V

    const/4 v2, 0x0

    iget-object v3, p0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    :goto_0
    if-ge v2, v3, :cond_3

    iget-object v4, p0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    invoke-interface {v4, v2}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Lchat/ola/vn/entity/ab;

    invoke-virtual {v4}, Lchat/ola/vn/entity/ab;->a()Lorg/json/JSONObject;

    move-result-object v4

    if-eqz v4, :cond_2

    invoke-virtual {v1, v4}, Lorg/json/JSONArray;->put(Ljava/lang/Object;)Lorg/json/JSONArray;

    :cond_2
    add-int/lit8 v2, v2, 0x1

    goto :goto_0

    :cond_3
    const-string v2, "attachedPhotoList"

    invoke-virtual {v0, v2, v1}, Lorg/json/JSONObject;->put(Ljava/lang/String;Ljava/lang/Object;)Lorg/json/JSONObject;
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :cond_4
    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method

.method public b()V
    .locals 7

    iget-object v0, p0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    const/4 v1, 0x1

    const/4 v2, 0x0

    if-eqz v0, :cond_1

    :try_start_0
    iput v2, p0, Lchat/ola/vn/me/a;->q:I

    iput v2, p0, Lchat/ola/vn/me/a;->p:I

    iget-object v0, p0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->size()I

    move-result v0

    iput v0, p0, Lchat/ola/vn/me/a;->r:I

    iget-object v0, p0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :goto_0
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    check-cast v3, Lchat/ola/vn/entity/ab;

    iget-byte v3, v3, Lchat/ola/vn/entity/ab;->b:B

    if-nez v3, :cond_0

    iget v3, p0, Lchat/ola/vn/me/a;->q:I

    add-int/2addr v3, v1

    iput v3, p0, Lchat/ola/vn/me/a;->q:I
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_0

    :cond_0
    const/4 v2, 0x1

    goto :goto_0

    :catch_0
    :cond_1
    if-eqz v2, :cond_4

    iget-object v0, p0, Lchat/ola/vn/me/a;->a:Ljava/util/List;

    invoke-interface {v0}, Ljava/util/List;->iterator()Ljava/util/Iterator;

    move-result-object v0

    :cond_2
    :goto_1
    invoke-interface {v0}, Ljava/util/Iterator;->hasNext()Z

    move-result v2

    if-eqz v2, :cond_5

    invoke-interface {v0}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v2

    check-cast v2, Lchat/ola/vn/entity/ab;

    iget-byte v3, v2, Lchat/ola/vn/entity/ab;->b:B

    if-ne v3, v1, :cond_2

    const/4 v3, 0x0

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_3

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v4

    invoke-static {v4}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v4

    if-nez v4, :cond_3

    new-instance v3, Ljava/lang/StringBuilder;

    invoke-direct {v3}, Ljava/lang/StringBuilder;-><init>()V

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/n/c;->b()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ":"

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-static {}, Lchat/ola/vn/n/c;->a()Lchat/ola/vn/n/c;

    move-result-object v4

    invoke-virtual {v4}, Lchat/ola/vn/n/c;->c()Ljava/lang/String;

    move-result-object v4

    invoke-virtual {v3, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v3

    :cond_3
    invoke-static {}, Lchat/ola/vn/u/b;->a()Lchat/ola/vn/u/b;

    move-result-object v4

    iget-object v5, v2, Lchat/ola/vn/entity/ab;->c:Ljava/lang/String;

    new-instance v6, Lchat/ola/vn/me/a$1;

    invoke-direct {v6, p0, v2}, Lchat/ola/vn/me/a$1;-><init>(Lchat/ola/vn/me/a;Lchat/ola/vn/entity/ab;)V

    invoke-virtual {v4, v5, v3, v6}, Lchat/ola/vn/u/b;->a(Ljava/lang/String;Ljava/lang/String;Lchat/ola/vn/u/o;)Lchat/ola/vn/u/p;

    goto :goto_1

    :cond_4
    invoke-direct {p0}, Lchat/ola/vn/me/a;->c()V

    :cond_5
    return-void
.end method

.method public equals(Ljava/lang/Object;)Z
    .locals 5

    :try_start_0
    iget-wide v0, p0, Lchat/ola/vn/me/a;->o:J

    move-object v2, p1

    check-cast v2, Lchat/ola/vn/me/a;

    iget-wide v2, v2, Lchat/ola/vn/me/a;->o:J
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    cmp-long v4, v0, v2

    if-nez v4, :cond_0

    const/4 p1, 0x1

    return p1

    :catch_0
    :cond_0
    invoke-super {p0, p1}, Ljava/lang/Object;->equals(Ljava/lang/Object;)Z

    move-result p1

    return p1
.end method

.method public toString()Ljava/lang/String;
    .locals 1

    :try_start_0
    invoke-virtual {p0}, Lchat/ola/vn/me/a;->a()Lorg/json/JSONObject;

    move-result-object v0

    invoke-virtual {v0}, Lorg/json/JSONObject;->toString()Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    return-object v0

    :catch_0
    const/4 v0, 0x0

    return-object v0
.end method
