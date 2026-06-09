.class Lchat/ola/vn/w/au;
.super Ljava/lang/Object;

# interfaces
.implements Lchat/ola/vn/w/bb;


# instance fields
.field private e:Ljava/lang/String;


# direct methods
.method constructor <init>()V
    .locals 0

    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private a(Ljava/lang/String;)Ljava/util/List;
    .locals 9
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Ljava/util/List<",
            "Lchat/ola/vn/entity/ad;",
            ">;"
        }
    .end annotation

    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Lorg/json/JSONObject;

    invoke-direct {v1, p1}, Lorg/json/JSONObject;-><init>(Ljava/lang/String;)V

    const-string p1, "articles"

    invoke-virtual {v1, p1}, Lorg/json/JSONObject;->getJSONArray(Ljava/lang/String;)Lorg/json/JSONArray;

    move-result-object p1

    const-string v2, "viewAll"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v2

    if-eqz v2, :cond_0

    const-string v2, "viewAll"

    invoke-virtual {v1, v2}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    iput-object v1, p0, Lchat/ola/vn/w/au;->e:Ljava/lang/String;

    :cond_0
    invoke-virtual {p1}, Lorg/json/JSONArray;->length()I

    move-result v1

    if-lez v1, :cond_8

    const/4 v2, 0x3

    new-instance v3, Ljava/util/ArrayList;

    invoke-direct {v3, v1}, Ljava/util/ArrayList;-><init>(I)V

    const/4 v4, 0x0

    :goto_0
    if-ge v4, v2, :cond_7

    if-ge v4, v1, :cond_7

    invoke-virtual {p1, v4}, Lorg/json/JSONArray;->getJSONObject(I)Lorg/json/JSONObject;

    move-result-object v5

    new-instance v6, Lchat/ola/vn/entity/ad;

    invoke-direct {v6}, Lchat/ola/vn/entity/ad;-><init>()V

    const-string v7, "title"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_1

    const-string v7, "title"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lchat/ola/vn/entity/ad;->f(Ljava/lang/String;)V

    goto :goto_1

    :cond_1
    move-object v7, v0

    :goto_1
    invoke-static {v7}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v8

    if-nez v8, :cond_6

    const-string v8, "null"

    invoke-static {v7, v8}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_2

    goto :goto_2

    :cond_2
    const-string v7, "link"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_3

    const-string v7, "link"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lchat/ola/vn/entity/ad;->e(Ljava/lang/String;)V

    :cond_3
    const-string v7, "thumbnail"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_4

    const-string v7, "thumbnail"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v7

    invoke-virtual {v6, v7}, Lchat/ola/vn/entity/ad;->d(Ljava/lang/String;)V

    :cond_4
    const-string v7, "intro"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->has(Ljava/lang/String;)Z

    move-result v7

    if-eqz v7, :cond_5

    const-string v7, "intro"

    invoke-virtual {v5, v7}, Lorg/json/JSONObject;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v5

    invoke-virtual {v6, v5}, Lchat/ola/vn/entity/ad;->c(Ljava/lang/String;)V

    :cond_5
    invoke-interface {v3, v6}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Ljava/lang/Throwable; {:try_start_0 .. :try_end_0} :catch_0

    goto :goto_3

    :cond_6
    :goto_2
    add-int/lit8 v2, v2, 0x1

    :goto_3
    add-int/lit8 v4, v4, 0x1

    goto :goto_0

    :cond_7
    return-object v3

    :catch_0
    :cond_8
    return-object v0
.end method


# virtual methods
.method public a(Lchat/ola/vn/w/bk;Lchat/ola/vn/w/cg;Lchat/ola/vn/p/g;)V
    .locals 0

    return-void
.end method

.method public a(Lchat/ola/vn/w/s;Lchat/ola/vn/p/g;Lchat/ola/vn/w/ci;)V
    .locals 10

    const/4 p3, 0x0

    const/16 v0, 0xff

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v0

    invoke-virtual {p1, v0, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v0

    int-to-short v7, v0

    const/16 v0, 0x8

    invoke-virtual {p1, v0}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v0

    const/16 v1, 0xcf

    invoke-virtual {p1, v1}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v1

    const/16 v2, 0x6d

    invoke-virtual {p1, v2}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v2

    invoke-static {v2}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_0

    const-string v3, "null"

    invoke-static {v2, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_1

    :cond_0
    const-string v2, ""

    :cond_1
    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result v3

    if-nez v3, :cond_2

    const-string v3, "null"

    invoke-static {v0, v3}, Lchat/ola/vn/util/m;->b(Ljava/lang/String;Ljava/lang/String;)Z

    move-result v3

    if-eqz v3, :cond_3

    :cond_2
    const-string v0, ""

    :cond_3
    const/16 v3, 0x1d

    invoke-virtual {p1, v3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object v3

    const/16 v4, 0x48

    invoke-virtual {p1, v4, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v4

    const-wide/16 v5, 0x0

    invoke-virtual {p1, v4, v5, v6}, Lchat/ola/vn/w/s;->a(IJ)J

    move-result-wide v4

    const/16 v6, 0x5a

    invoke-virtual {p1, v6, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v6

    invoke-virtual {p1, v6, p3}, Lchat/ola/vn/w/s;->a(IS)B

    move-result v6

    int-to-short v6, v6

    const/16 v8, 0x7c

    invoke-virtual {p1, v8, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v8

    invoke-virtual {p1, v8, p3}, Lchat/ola/vn/w/s;->a(II)I

    move-result v8

    const/16 v9, 0x7d

    invoke-virtual {p1, v9, p3}, Lchat/ola/vn/w/s;->b(SI)I

    move-result v9

    invoke-virtual {p1, v9, p3}, Lchat/ola/vn/w/s;->a(II)I

    move-result p3

    new-instance v9, Lchat/ola/vn/entity/ad;

    invoke-direct {v9}, Lchat/ola/vn/entity/ad;-><init>()V

    invoke-virtual {v9, v2}, Lchat/ola/vn/entity/ad;->f(Ljava/lang/String;)V

    invoke-virtual {v9, v1}, Lchat/ola/vn/entity/ad;->e(Ljava/lang/String;)V

    invoke-virtual {v9, v4, v5}, Lchat/ola/vn/entity/ad;->c(J)V

    invoke-virtual {v9, v8}, Lchat/ola/vn/entity/ad;->b(I)V

    invoke-virtual {v9, p3}, Lchat/ola/vn/entity/ad;->c(I)V

    invoke-virtual {v9, v3}, Lchat/ola/vn/entity/ad;->g(Ljava/lang/String;)V

    invoke-virtual {v9, v6}, Lchat/ola/vn/entity/ad;->b(S)V

    const/4 p3, -0x1

    invoke-virtual {v9, p3}, Lchat/ola/vn/entity/ad;->a(S)V

    const/4 p3, 0x0

    iput-object p3, p0, Lchat/ola/vn/w/au;->e:Ljava/lang/String;

    invoke-static {v0}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_5

    const-string p3, "\r"

    const-string v1, ""

    invoke-virtual {v0, p3, v1}, Ljava/lang/String;->replace(Ljava/lang/CharSequence;Ljava/lang/CharSequence;)Ljava/lang/String;

    move-result-object p3

    const-string v0, "\n"

    invoke-virtual {p3, v0}, Ljava/lang/String;->split(Ljava/lang/String;)[Ljava/lang/String;

    move-result-object p3

    invoke-virtual {v9, p3}, Lchat/ola/vn/entity/ad;->a([Ljava/lang/String;)V

    const/16 p3, 0x71

    invoke-virtual {p1, p3}, Lchat/ola/vn/w/s;->b(S)Ljava/lang/String;

    move-result-object p1

    invoke-static {p1}, Lchat/ola/vn/util/m;->a(Ljava/lang/String;)Z

    move-result p3

    if-nez p3, :cond_4

    invoke-direct {p0, p1}, Lchat/ola/vn/w/au;->a(Ljava/lang/String;)Ljava/util/List;

    move-result-object p1

    invoke-virtual {v9, p1}, Lchat/ola/vn/entity/ad;->d(Ljava/util/List;)V

    iget-object p1, p0, Lchat/ola/vn/w/au;->e:Ljava/lang/String;

    invoke-virtual {v9, p1}, Lchat/ola/vn/entity/ad;->j(Ljava/lang/String;)V

    :cond_4
    invoke-interface {p2, v9, v7}, Lchat/ola/vn/p/g;->a(Lchat/ola/vn/entity/ad;S)V

    return-void

    :cond_5
    const/16 v2, 0x22

    const/4 v3, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    const/4 v6, 0x0

    move-object v1, p2

    invoke-interface/range {v1 .. v7}, Lchat/ola/vn/p/g;->a(ISLjava/lang/String;[B[Lchat/ola/vn/entity/d;S)V

    return-void
.end method
