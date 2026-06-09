.class public Lchat/ola/vn/network/a/a/w;
.super Lchat/ola/vn/entity/m;


# annotations
.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lchat/ola/vn/entity/m<",
        "Lchat/ola/vn/entity/ag;",
        ">;"
    }
.end annotation


# instance fields
.field public c:Lchat/ola/vn/p/g;

.field public d:Lchat/ola/vn/p/d;

.field public e:S

.field private f:Ljava/lang/String;

.field private g:Ljava/util/List;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Ljava/util/List<",
            "Ljava/lang/String;",
            ">;"
        }
    .end annotation
.end field

.field private h:I

.field private i:Z


# direct methods
.method public constructor <init>(Ljava/lang/String;J)V
    .locals 0

    invoke-direct {p0, p2, p3}, Lchat/ola/vn/entity/m;-><init>(J)V

    const/4 p2, 0x0

    iput-object p2, p0, Lchat/ola/vn/network/a/a/w;->g:Ljava/util/List;

    const/16 p2, 0x24

    iput p2, p0, Lchat/ola/vn/network/a/a/w;->h:I

    const/4 p2, 0x0

    iput-short p2, p0, Lchat/ola/vn/network/a/a/w;->e:S

    iput-boolean p2, p0, Lchat/ola/vn/network/a/a/w;->i:Z

    iput-object p1, p0, Lchat/ola/vn/network/a/a/w;->f:Ljava/lang/String;

    iput-boolean p2, p0, Lchat/ola/vn/network/a/a/w;->i:Z

    return-void
.end method

.method private a(Lchat/ola/vn/entity/ag;Ljava/lang/String;)V
    .locals 3

    new-instance v0, Lchat/ola/vn/message/f;

    iget-object v1, p1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    const/4 v2, 0x0

    invoke-direct {v0, v1, v2}, Lchat/ola/vn/message/f;-><init>(Ljava/lang/String;S)V

    invoke-virtual {v0, p2}, Lchat/ola/vn/message/f;->c(Ljava/lang/String;)V

    invoke-virtual {v0}, Lchat/ola/vn/message/f;->L()Ljava/lang/CharSequence;

    move-result-object p2

    iput-object p2, p1, Lchat/ola/vn/entity/ag;->a:Ljava/lang/CharSequence;

    return-void
.end method


# virtual methods
.method public synthetic a([B)Ljava/lang/Object;
    .locals 0

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/w;->b([B)Lchat/ola/vn/entity/ag;

    move-result-object p1

    return-object p1
.end method

.method public a()Ljava/lang/String;
    .locals 6

    new-instance v0, Ljava/util/HashMap;

    invoke-direct {v0}, Ljava/util/HashMap;-><init>()V

    iget-object v1, p0, Lchat/ola/vn/network/a/a/w;->f:Ljava/lang/String;

    invoke-static {v1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v1

    if-nez v1, :cond_1

    iget-boolean v1, p0, Lchat/ola/vn/network/a/a/w;->i:Z

    if-eqz v1, :cond_0

    const-string v1, "phone"

    :goto_0
    iget-object v2, p0, Lchat/ola/vn/network/a/a/w;->f:Ljava/lang/String;

    invoke-interface {v0, v1, v2}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    goto :goto_1

    :cond_0
    const-string v1, "un"

    goto :goto_0

    :cond_1
    :goto_1
    iget-object v1, p0, Lchat/ola/vn/network/a/a/w;->g:Ljava/util/List;

    const/4 v2, 0x1

    if-eqz v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/network/a/a/w;->g:Ljava/util/List;

    invoke-interface {v1}, Ljava/util/List;->size()I

    move-result v1

    if-lez v1, :cond_3

    iget-object v1, p0, Lchat/ola/vn/network/a/a/w;->g:Ljava/util/List;

    const/4 v3, 0x0

    invoke-interface {v1, v3}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Ljava/lang/String;

    iget-object v3, p0, Lchat/ola/vn/network/a/a/w;->g:Ljava/util/List;

    invoke-interface {v3}, Ljava/util/List;->size()I

    move-result v3

    move-object v4, v1

    const/4 v1, 0x1

    :goto_2
    if-ge v1, v3, :cond_2

    new-instance v5, Ljava/lang/StringBuilder;

    invoke-direct {v5}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    const-string v4, ","

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    iget-object v4, p0, Lchat/ola/vn/network/a/a/w;->g:Ljava/util/List;

    invoke-interface {v4, v1}, Ljava/util/List;->get(I)Ljava/lang/Object;

    move-result-object v4

    check-cast v4, Ljava/lang/String;

    invoke-virtual {v5, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v5}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    add-int/lit8 v1, v1, 0x1

    goto :goto_2

    :cond_2
    const-string v1, "fields"

    invoke-interface {v0, v1, v4}, Ljava/util/Map;->put(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    :cond_3
    invoke-static {}, Lchat/ola/vn/h;->f()Ljava/lang/String;

    move-result-object v1

    const-string v3, "id/profile"

    invoke-static {v1, v3, v0, v2}, Lchat/ola/vn/util/http/a;->a(Ljava/lang/String;Ljava/lang/String;Ljava/util/Map;Z)Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public a(Lchat/ola/vn/entity/ag;)V
    .locals 1

    if-eqz p1, :cond_0

    :try_start_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/w;->d:Lchat/ola/vn/p/d;

    if-eqz v0, :cond_1

    iget-object v0, p0, Lchat/ola/vn/network/a/a/w;->d:Lchat/ola/vn/p/d;

    invoke-interface {v0, p1}, Lchat/ola/vn/p/d;->a(Lchat/ola/vn/entity/ag;)V

    return-void

    :cond_0
    iget-object p1, p0, Lchat/ola/vn/network/a/a/w;->d:Lchat/ola/vn/p/d;

    if-eqz p1, :cond_1

    iget-object p1, p0, Lchat/ola/vn/network/a/a/w;->d:Lchat/ola/vn/p/d;

    iget v0, p0, Lchat/ola/vn/network/a/a/w;->h:I

    invoke-interface {p1, v0}, Lchat/ola/vn/p/d;->a(I)V
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    :catch_0
    :cond_1
    return-void
.end method

.method public bridge synthetic a(Ljava/lang/Object;)V
    .locals 0

    check-cast p1, Lchat/ola/vn/entity/ag;

    invoke-virtual {p0, p1}, Lchat/ola/vn/network/a/a/w;->a(Lchat/ola/vn/entity/ag;)V

    return-void
.end method

.method public varargs a([Ljava/lang/String;)V
    .locals 3

    if-eqz p1, :cond_2

    array-length v0, p1

    if-nez v0, :cond_0

    return-void

    :cond_0
    iget-object v0, p0, Lchat/ola/vn/network/a/a/w;->g:Ljava/util/List;

    if-nez v0, :cond_1

    new-instance v0, Ljava/util/ArrayList;

    array-length v1, p1

    invoke-direct {v0, v1}, Ljava/util/ArrayList;-><init>(I)V

    iput-object v0, p0, Lchat/ola/vn/network/a/a/w;->g:Ljava/util/List;

    :cond_1
    const/4 v0, 0x0

    :goto_0
    array-length v1, p1

    if-ge v0, v1, :cond_2

    iget-object v1, p0, Lchat/ola/vn/network/a/a/w;->g:Ljava/util/List;

    aget-object v2, p1, v0

    invoke-interface {v1, v2}, Ljava/util/List;->add(Ljava/lang/Object;)Z

    add-int/lit8 v0, v0, 0x1

    goto :goto_0

    :cond_2
    return-void
.end method

.method public b([B)Lchat/ola/vn/entity/ag;
    .locals 9

    const/4 v0, 0x0

    if-eqz p1, :cond_1d

    :try_start_0
    array-length v1, p1

    if-nez v1, :cond_0

    goto/16 :goto_4

    :cond_0
    invoke-static {p1}, Lchat/ola/vn/util/http/c;->a([B)Lorg/json/JSONObject;

    move-result-object p1

    const-string v1, "apiError"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1

    return-object v0

    :cond_1
    const-string v1, "errorCode"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_4

    if-eqz v1, :cond_2

    :try_start_1
    const-string v1, "errorCode"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v1

    iput v1, p0, Lchat/ola/vn/network/a/a/w;->h:I
    :try_end_1
    .catch Ljava/lang/Throwable; {:try_start_1 .. :try_end_1} :catch_0

    :catch_0
    :cond_2
    :try_start_2
    const-string v1, "nick"

    invoke-virtual {p1, v1}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v1

    if-eqz v1, :cond_1d

    new-instance v1, Lchat/ola/vn/entity/ag;

    invoke-direct {v1}, Lchat/ola/vn/entity/ag;-><init>()V
    :try_end_2
    .catch Ljava/lang/Throwable; {:try_start_2 .. :try_end_2} :catch_4

    :try_start_3
    const-string v0, "nick"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    const-string v0, "name"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_5

    const-string v0, "name"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/entity/ag;->k:Ljava/lang/String;

    iget-object v2, v1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    const-string v3, "rss"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_3

    const v0, 0x7f0f00f8

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    :cond_3
    iget-object v2, v1, Lchat/ola/vn/entity/ag;->c:Ljava/lang/String;

    const-string v3, "kho"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_4

    const v0, 0x7f0f00f2

    invoke-static {v0}, Lchat/ola/vn/OlaApplication;->a(I)Ljava/lang/String;

    move-result-object v0

    :cond_4
    invoke-direct {p0, v1, v0}, Lchat/ola/vn/network/a/a/w;->a(Lchat/ola/vn/entity/ag;Ljava/lang/String;)V

    :cond_5
    const-string v0, "gender"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_6

    const-string v0, "gender"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    int-to-byte v0, v0

    iput-byte v0, v1, Lchat/ola/vn/entity/ag;->w:B

    :cond_6
    const-string v0, "birthday"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_7

    const-string v0, "birthday"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v1, Lchat/ola/vn/entity/ag;->l:J

    :cond_7
    const-string v0, "registerMs"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_8

    const-string v0, "registerMs"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v1, Lchat/ola/vn/entity/ag;->m:J

    :cond_8
    const-string v0, "lastActiveAgo"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_9

    const-string v0, "lastActiveAgo"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getLong(Ljava/lang/String;)J

    move-result-wide v2

    iput-wide v2, v1, Lchat/ola/vn/entity/ag;->n:J

    :cond_9
    const-string v0, "socialLinkType"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_a

    const-string v0, "socialLinkType"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/entity/ag;->b:Ljava/lang/Integer;

    :cond_a
    const-string v0, "noFans"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_b

    const-string v0, "noFans"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iput v0, v1, Lchat/ola/vn/entity/ag;->r:I

    :cond_b
    const-string v0, "noFriends"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_c

    const-string v0, "noFriends"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iput v0, v1, Lchat/ola/vn/entity/ag;->p:I

    :cond_c
    const-string v0, "noMedias"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_d

    const-string v0, "noMedias"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    iput v0, v1, Lchat/ola/vn/entity/ag;->o:I

    :cond_d
    const-string v0, "statusMessage"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_e

    const-string v0, "statusMessage"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/entity/ag;->d:Ljava/lang/String;

    :cond_e
    const-string v0, "cared"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_f

    const-string v0, "cared"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v1, Lchat/ola/vn/entity/ag;->y:Z

    :cond_f
    const-string v0, "isFan"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_10

    const-string v0, "isFan"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v1, Lchat/ola/vn/entity/ag;->z:Z

    :cond_10
    const-string v0, "blocked"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_11

    const-string v0, "blocked"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v1, Lchat/ola/vn/entity/ag;->A:Z

    :cond_11
    const-string v0, "boxSpouse"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_12

    const-string v0, "boxSpouse"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/entity/ag;->e:Ljava/lang/String;

    :cond_12
    const-string v0, "vip"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_13

    const-string v0, "vip"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    int-to-short v0, v0

    iput-short v0, v1, Lchat/ola/vn/entity/ag;->u:S

    :cond_13
    const-string v0, "phone"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_16

    const-string v0, "phone"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "number"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_14

    const-string v2, "number"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    iget-object v2, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v2

    if-nez v2, :cond_14

    iget-object v2, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/o;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/entity/ag;->g:Ljava/lang/String;

    iget-object v2, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v2}, Lchat/ola/vn/util/o;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v2

    iput-object v2, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    :cond_14
    const-string v2, "verified"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_15

    const-string v2, "verified"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v2

    iput-boolean v2, v1, Lchat/ola/vn/entity/ag;->x:Z

    :cond_15
    const-string v2, "protect"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_16

    const-string v2, "protect"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getBoolean(Ljava/lang/String;)Z

    move-result v0

    iput-boolean v0, v1, Lchat/ola/vn/entity/ag;->B:Z

    :cond_16
    const-string v0, "like"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v0

    if-eqz v0, :cond_19

    const-string v0, "like"

    invoke-virtual {p1, v0}, Lorg/json/JSONObject;->getJSONObject(Ljava/lang/String;)Lorg/json/JSONObject;

    move-result-object v0

    const-string v2, "1"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_17

    const-string v2, "1"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    iput v2, v1, Lchat/ola/vn/entity/ag;->s:I

    :cond_17
    const-string v2, "3"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_18

    const-string v2, "3"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v2

    iput v2, v1, Lchat/ola/vn/entity/ag;->t:I

    :cond_18
    const-string v2, "liked"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_19

    const-string v2, "liked"

    invoke-virtual {v0, v2}, Lorg/json/JSONObject;->getInt(Ljava/lang/String;)I

    move-result v0

    int-to-short v0, v0

    iput-short v0, v1, Lchat/ola/vn/entity/ag;->v:S

    :cond_19
    iget-boolean v0, p0, Lchat/ola/vn/network/a/a/w;->i:Z

    if-eqz v0, :cond_1a

    iget-object v0, p0, Lchat/ola/vn/network/a/a/w;->f:Ljava/lang/String;

    iput-object v0, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    iget-object v0, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v0

    if-nez v0, :cond_1a

    iget-object v0, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/o;->c(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/entity/ag;->g:Ljava/lang/String;

    iget-object v0, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/o;->a(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v0

    iput-object v0, v1, Lchat/ola/vn/entity/ag;->f:Ljava/lang/String;
    :try_end_3
    .catch Ljava/lang/Throwable; {:try_start_3 .. :try_end_3} :catch_3

    :cond_1a
    const/4 v0, 0x0

    :try_start_4
    const-string v2, "friends"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1b

    const-string v2, "friends"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-lez v3, :cond_1b

    new-array v4, v3, [Ljava/lang/String;

    iput-object v4, v1, Lchat/ola/vn/entity/ag;->i:[Ljava/lang/String;

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v3, :cond_1b

    iget-object v5, v1, Lchat/ola/vn/entity/ag;->i:[Ljava/lang/String;

    invoke-virtual {v2, v4}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v4
    :try_end_4
    .catch Ljava/lang/Throwable; {:try_start_4 .. :try_end_4} :catch_1

    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :catch_1
    :cond_1b
    :try_start_5
    const-string v2, "fans"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1c

    const-string v2, "fans"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object v2

    invoke-virtual {v2}, Lorg/json/JSONArray;->length()I

    move-result v3

    if-lez v3, :cond_1c

    new-array v4, v3, [Ljava/lang/String;

    iput-object v4, v1, Lchat/ola/vn/entity/ag;->h:[Ljava/lang/String;

    const/4 v4, 0x0

    :goto_1
    if-ge v4, v3, :cond_1c

    iget-object v5, v1, Lchat/ola/vn/entity/ag;->h:[Ljava/lang/String;

    invoke-virtual {v2, v4}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v6

    aput-object v6, v5, v4
    :try_end_5
    .catch Ljava/lang/Throwable; {:try_start_5 .. :try_end_5} :catch_2

    add-int/lit8 v4, v4, 0x1

    goto :goto_1

    :catch_2
    :cond_1c
    :try_start_6
    const-string v2, "medias"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_1e

    const-string v2, "medias"

    invoke-virtual {p1, v2}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v2

    if-lez v2, :cond_1e

    new-array v3, v2, [Ljava/lang/String;

    iput-object v3, v1, Lchat/ola/vn/entity/ag;->j:[Ljava/lang/String;

    :goto_2
    if-ge v0, v2, :cond_1e

    iget-object v3, v1, Lchat/ola/vn/entity/ag;->j:[Ljava/lang/String;

    invoke-virtual {p1, v0}, Lorg/json/JSONArray;->getString(I)Ljava/lang/String;

    move-result-object v4

    aput-object v4, v3, v0
    :try_end_6
    .catch Ljava/lang/Throwable; {:try_start_6 .. :try_end_6} :catch_5

    add-int/lit8 v0, v0, 0x1

    goto :goto_2

    :catch_3
    move-exception p1

    goto :goto_3

    :catch_4
    move-exception p1

    move-object v1, v0

    :goto_3
    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    goto :goto_5

    :cond_1d
    :goto_4
    move-object v1, v0

    :catch_5
    :cond_1e
    :goto_5
    if-eqz v1, :cond_1f

    :try_start_7
    iget-object p1, p0, Lchat/ola/vn/network/a/a/w;->c:Lchat/ola/vn/p/g;

    iget-short v0, p0, Lchat/ola/vn/network/a/a/w;->e:S

    invoke-interface {p1, v1, v0}, Lchat/ola/vn/p/g;->a(Lchat/ola/vn/entity/ag;S)V
    :try_end_7
    .catch Ljava/lang/Throwable; {:try_start_7 .. :try_end_7} :catch_7

    return-object v1

    :cond_1f
    :try_start_8
    iget-object v2, p0, Lchat/ola/vn/network/a/a/w;->c:Lchat/ola/vn/p/g;

    iget v3, p0, Lchat/ola/vn/network/a/a/w;->h:I

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    iget-short v8, p0, Lchat/ola/vn/network/a/a/w;->e:S

    invoke-interface/range {v2 .. v8}, Lchat/ola/vn/p/g;->a(ISLjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V
    :try_end_8
    .catch Ljava/lang/Throwable; {:try_start_8 .. :try_end_8} :catch_6

    return-object v1

    :catch_6
    move-exception p1

    invoke-virtual {p1}, Ljava/lang/Throwable;->printStackTrace()V

    :catch_7
    return-object v1
.end method

.method public b(Ljava/lang/String;)V
    .locals 0

    return-void
.end method

.method public c(Ljava/lang/String;)V
    .locals 0

    iput-object p1, p0, Lchat/ola/vn/network/a/a/w;->f:Ljava/lang/String;

    const/4 p1, 0x1

    iput-boolean p1, p0, Lchat/ola/vn/network/a/a/w;->i:Z

    return-void
.end method
